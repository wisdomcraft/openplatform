from rest_framework.views       import APIView
from rest_framework.response    import Response
from django.forms.models        import model_to_dict
from django.http                import HttpResponseRedirect
from openplatform               import models
from openplatform.settings      import BASE_DIR
from functools                  import partial
import hashlib, random, pytz, time, datetime, os


'''
# ================================
# 首页
# ================================
'''
class Home(APIView):
    def get(self, request):
        return Response({'code':0, 'message':'forbidden'})


'''
# ================================
# 开放接口, 获取token
# ================================
'''
class OpenTokenFetch(APIView):

    def get(self, request):
        return Response({'code':0, 'message':'GET is not allowed'})

    def post(self, request):
        content_type= request.content_type
        if content_type.find(r"application/json") == None:
            return Response({'code':0, 'message':'error, Content-Type is not application/json'})
            
        developer_id= request.data.get("developer_id", None)
        if developer_id == None:
            return Response({'code':0, 'message':'error, developer_id not exist'})
        if type(developer_id) != type(""):
            return Response({'code':0, 'message':'error, developer_id is not string'})
        if len(developer_id) != 32:
            return Response({'code':0, 'message':'error, developer_id length is incorrect'})
        
        app_id      = request.data.get("app_id", None)
        if app_id == None:
            return Response({'code':0, 'message':'error, app_id not exist'})
        if type(app_id) != type(""):
            return Response({'code':0, 'message':'error, app_id is not string'})
        if len(app_id) != 32:
            return Response({'code':0, 'message':'error, app_id length is incorrect'})
        
        count       = models.DeveloperApp.objects.filter(app_developer_id=developer_id).filter(app_id=app_id).count()
        if count != 1:
            return Response({'code':0, 'message':'error, app not exist by this developer_id and app_id'})
        

        uuid    = str(time.time()) + str(random.randint(1, 999999))
        token   = hashlib.sha1(uuid.encode(encoding='UTF-8')).hexdigest()
        
        timezone            = pytz.timezone('Asia/Shanghai')
        inserttime          = int(time.time())
        inserttime_datetime = datetime.datetime.fromtimestamp(inserttime, timezone).strftime("%Y-%m-%d %H:%M:%S")
        expiretime          = inserttime + 86400
        expiretime_datetime = datetime.datetime.fromtimestamp(expiretime, timezone).strftime("%Y-%m-%d %H:%M:%S")

        models.Session.objects.create(
            session_token               = token,
            session_developer_id        = developer_id,
            session_app_id              = app_id,
            session_inserttime          = inserttime,
            session_inserttime_datetime = inserttime_datetime,
            session_expiretime          = expiretime,
            session_expiretime_datetime = expiretime_datetime
        )

        if random.randint(0, 9) == 0:
            delete = models.Session.objects.filter(session_expiretime__lt=inserttime).delete()
        
        #建议 显示token的过期时间
        return Response({'code':1, 'message':'success', 'data':{'token':token, 'field':r'/api/open'}})


'''
# ================================
# 开放接口, 检查token
# ================================
'''
class OpenTokenCheck(APIView):

    def get(self, request):
        return Response({'code':0, 'message':'error, GET is not allowed'})

    def post(self, request):
        authorization   = request.META.get("HTTP_AUTHORIZATION", None)
        authorization   = authorization.split(" ")
        if len(authorization) != 2:
            return Response({'code':0, 'message':'error, Authorization is incorrect'})
        if authorization[0] != "Bearer":
            return Response({'code':0, 'message':'error, Authorization is incorrect about Bearer'})
        
        token   = authorization[1]
        unixtime= int(time.time())
        count   = models.Session.objects.filter(session_token=token).filter(session_expiretime__gt=unixtime).count()
        if count == 0:
            return Response({'code':1000, 'message':'error, token is invalid'})

        #建议 显示token的过期时间, 参考OpenTokenFetch
        return Response({'code':1, 'message':'success, token is active'})


'''
# ================================
# 开放接口, 公共方法, 被其它类调用
# ================================
'''
class OpenCommon(APIView):
    
    def __init__(self):
        pass

    def init(self, request):
        authorization   = request.META.get("HTTP_AUTHORIZATION", None)
        authorization   = authorization.split(" ")
        if len(authorization) != 2:
            return {'code':0, 'message':'error, Authorization is incorrect'}
        if authorization[0] != "Bearer":
            return {'code':0, 'message':'error, Authorization is incorrect about Bearer'}
        
        token   = authorization[1]
        unixtime= int(time.time())
        count   = models.Session.objects.filter(session_token=token).filter(session_expiretime__gt=unixtime).count()
        if count == 0:
            return {'code':0, 'message':'error, token is invalid'}

        find                = models.Session.objects.filter(session_token=token).get()
        self.developer_id   = find.session_developer_id
        self.app_id         = find.session_app_id
        
        if random.randint(0, 9) == 0:
            timezone            = pytz.timezone('Asia/Shanghai')
            expiretime          = int(time.time()) + 86400
            expiretime_datetime = datetime.datetime.fromtimestamp(expiretime, timezone).strftime("%Y-%m-%d %H:%M:%S")
            models.Session.objects.filter(session_token=token).update(session_expiretime=expiretime, session_expiretime_datetime=expiretime_datetime)

        return {'code':1, 'message':''}


'''
# ================================
# 开放接口, 上传视频文件, 生成任务
# ================================
'''
class OpenTaskUpload(OpenCommon):

    def get(self, request):
        return Response({'code':0, 'message':'error, GET is not allowed'})

    def post(self, request):
        result      = self.init(request)
        if result["code"] != 1:
            return Response(result)
        
        video_file  = request.FILES.get("video_file")
        
        video_file_name     = video_file.name
        if video_file_name.find(".") == -1:
            return Response({'code':0, 'message':'error, file name is incorrect'})
        video_file_suffix   = video_file_name[video_file_name.find(".")+1:]
        if video_file_suffix not in ["mp4", "flv"]:
            return Response({'code':0, 'message':'error, video file is not allowed, only mp4 and flv allowed'})
        
        hashlib_md5 = hashlib.md5()
        for item in iter(partial(video_file.read, 65536), b''):
            hashlib_md5.update(item)
        video_md5    = hashlib_md5.hexdigest()
        
        #检查md5在数据库是否已经存在
        md5check    = self.__post_md5check(video_md5)
        if md5check != None:
            return Response(md5check)

        path        = os.path.join(BASE_DIR, 'static', 'video', 'original')
        if not os.path.exists(path):
            os.makedirs(path)

        video_name  = video_md5 + "." + video_file_suffix
        video_uri   = "/" + os.path.join('static', 'video', 'original') + "/" + video_name
        video_path  = os.path.join(BASE_DIR) + video_uri
        openfile    = open(video_path, "wb")
        for chunk in video_file.chunks():
            openfile.write(chunk)
        openfile.close()

        #这里还要再完善, 增加对app_id的判断, 以便统计出某个app_id共计做了多少视频分析
        count       = models.Task.objects.filter(task_video_md5=video_md5).count()
        task_id     = ""
        if count == 0:
            uuid    = str(time.time()) + str(random.randint(1, 999999)) + video_md5
            task_id = hashlib.md5(uuid.encode(encoding='UTF-8')).hexdigest()
            timezone            = pytz.timezone('Asia/Shanghai')
            inserttime          = int(time.time())
            inserttime_datetime = datetime.datetime.fromtimestamp(inserttime, timezone).strftime("%Y-%m-%d %H:%M:%S")
            models.Task.objects.create(
                task_id                 = task_id,
                task_video_md5          = video_md5,
                task_video_name         = video_name,
                task_video_uri          = video_uri,
                task_video_path         = video_path,
                task_state_code         = 0,
                task_state_remark       = "视频文件上传成功, 任务待处理",
                task_inserttime         = inserttime,
                task_inserttime_datetime= inserttime_datetime,
                task_updatetime         = inserttime,
                task_updatetime_datetime= inserttime_datetime
            )
        else:
            find    = models.Task.objects.filter(task_video_md5=video_md5).get()
            task_id = find.task_id
            
        return Response({'code':1, 'message':'success', 'data':{'task_id':task_id, 'video_md5':video_md5}})


    #检查md5在数据库是否已经存在
    #如果不存在,返回None; 否则, 返回字典
    def __post_md5check(self, video_md5):
        count   = models.Task.objects.filter(task_video_md5=video_md5).count()
        if count == 0:
            return None;
        find    = models.Task.objects.filter(task_video_md5=video_md5).get()
        task_id = find.task_id
        return {'code':1, 'message':'success', 'data':{'task_id':task_id, 'video_md5':video_md5}}


'''
# ================================
# 开放接口, 根据视频md5, 生成任务, 或者查询任务id
# ================================
'''
class OpenTaskTaskid(OpenCommon):

    def get(self, request):
        return Response({'code':0, 'message':'error, GET is not allowed'})

    def post(self, request):
        result  = self.init(request)
        if result["code"] != 1:
            return Response(result)
        
        content_type= request.content_type
        if content_type.find(r"application/json") == None:
            return Response({'code':0, 'message':'error, Content-Type is not application/json'})
        
        video_md5   = request.data.get("video_md5", None)
        if video_md5 == None:
            return Response({'code':0, 'message':'error, video file md5 not exist in POST'})

        #这里还要再完善, 增加对app_id的判断, 当前video md5是否属于当前的开发者应用
        count   = models.Task.objects.filter(task_video_md5=video_md5).count()
        if count == 0:
            return Response({'code':0, 'message':'error, video file md5 not exist task list'})
        
        find    = models.Task.objects.filter(task_video_md5=video_md5).get()
        task_id = find.task_id
            
        return Response({'code':1, 'message':'success', 'data':{'task_id':task_id, 'video_md5':video_md5}})


'''
# ================================
# 开放接口, 获取任务状态, 包括任务运行结果
# task_state_code
#   0, 视频文件上传成功, 任务待处理
#   2, 视频文件等待转码
#   4, 视频文件转码中
#   6, 视频已准备好, 待识别
#   10, 视频文件正在由心理情绪软件进行识别
#   12, 视频文件的心理识别操作结束, 分析失败
#   14, 视频文件的心理识别操作, 出现未知错误, 请联系管理员
#   20, 视频文件的心理识别操作结束, 可查看识别结果
#   21, 视频文件的心理识别操作结果, 可查看识别结果, 并下载pdf报告
# ================================
'''
class OpenTaskState(OpenCommon):

    def get(self, request):
        return Response({'code':0, 'message':'error, GET is not allowed'})

    def post(self, request):
        result  = self.init(request)
        if result["code"] != 1:
            return Response(result)
        
        content_type= request.content_type
        if content_type.find(r"application/json") == None:
            return Response({'code':0, 'message':'error, Content-Type is not application/json'})
        
        task_id = request.data.get("task_id", None)
        if task_id == None:
            return Response({'code':0, 'message':'error, task_id not exist in POST'})

        #这里还要再完善, 增加对app_id的判断, 当前task_id是否属于当前的开发者应用
        count   = models.Task.objects.filter(task_id=task_id).count()
        if count == 0:
            return Response({'code':0, 'message':'error, task not exist by this task_id'})
        
        find    = models.Task.objects.filter(task_id=task_id).get()
        data    = {}
        task_state_code             = int(find.task_state_code)
        data["task_id"]             = find.task_id
        data["task_state_code"]     = task_state_code
        data["task_state_remark"]   = find.task_state_remark

        if task_state_code == 6:
            find2 = models.EmotionUserVideo.objects.filter(video_id=find.task_video_md5).get()
            video_status = int(find2.video_status)
            if video_status == 2:
                data["task_state_code"]     = 10
                data["task_state_remark"]   = '视频文件正在由心理情绪软件进行识别'
            elif video_status == 3 or video_status == 4:
                data["task_state_code"]     = 12
                data["task_state_remark"]   = '视频文件的心理识别操作结束, 分析失败'
            elif video_status == 5:
                data["task_state_code"]     = 20
                data["task_state_remark"]   = '视频文件的心理识别操作结束, 可查看识别结果'
            elif video_status not in [1, 2, 3, 4, 5]:
                data["task_state_code"]     = 14
                data["task_state_remark"]   = '视频文件的心理识别操作, 出现未知错误, 请联系管理员'
        
            if video_status == 5:
                task_state_code     = 20
                task_state_remark   = '视频文件的心理识别操作结束, 可查看识别结果'
                timezone            = pytz.timezone('Asia/Shanghai')
                updatetime          = int(time.time())
                updatetime_datetime = datetime.datetime.fromtimestamp(updatetime, timezone).strftime("%Y-%m-%d %H:%M:%S")
                models.Task.objects.filter(task_id=task_id).update(task_state_code = task_state_code, 
                    task_state_remark       = task_state_remark, 
                    task_updatetime         = updatetime, 
                    task_updatetime_datetime= updatetime_datetime)
        
        if task_state_code == 20:
            native      = self.__task_result_native(find.task_video_md5)
            task_result = {}
            task_result["native"]   = native
            
            data["task_result"]     = task_result
        
        return Response({'code':1, 'message':'success', 'data':data})


    # 心理情绪识别结果, 原生结果
    def __task_result_native(self, video_id):
        info        = {}
        detial      = models.EmotionReport.objects.filter(video_id=video_id).values()
        group_info  = models.EmotionGroup.objects.filter(group_id=detial[0]["group_id"]).values()
        ha          = models.EmotionFh.objects.filter(video_id=video_id).values("h").order_by('fh_id')

        info["report"] = {
                "report_id":detial[0]["report_id"],
                "remark":   detial[0]["remark"],
                "content":  detial[0]["content"],
            }
            
        info["group"] = {
                'group_id':     group_info[0]["group_id"],
                'group_no':     group_info[0]["group_no"],
                'group_name':   group_info[0]["group_name"],
                'group_status': group_info[0]["group_status"],
                'group_remark': group_info[0]["group_remark"],
                'group_feature':group_info[0]["group_feature"],
                'group_process':group_info[0]["group_process"]
            }
        
        vi = round(detial[0]["vi"] * 100)
        if vi < 0:
            vi = 0
        if vi > 100:
            vi = 100
        vi_yyy  = models.EmotionCoord.objects.filter(x4=vi).values('y4')
        vi_y    = vi_yyy[0]['y4']
        vi_status       = '稳定正常情绪'
        vitality_status = '低'
        vitality_color  = '#FF0000'
        vitality        = round(detial[0]["vitality"], 2)
        if round(vitality % 0.05, 2) >= 0 and round(vitality % 0.05, 2) < 0.03:
            vitality_x  = format((vitality - (vitality % 0.05)), '.2f')
        else:
            vitality_x  = format((vitality - (vitality % 0.05) + 0.05), '.2f')
        if float(vitality_x) < 0:
            vitality_x  = '0.00'
        if float(vitality_x) > 5:
            vitality_x  = '5.00'
        vitality_y      = models.EmotionCoord.objects.filter(x3=vitality_x).values('y3')
        if vitality >= 2:
            vitality_status = '高'
            vitality_color  = '#00FF00'
        elif 1 < vitality <= 2:
            vitality_color  = '#00FF00'
            vitality_status = '中'
        concentration_status= '低'
        concentration_color = '#FF0000'
        concentration       = round(detial[0]["concentration"], 2)
        if concentration < 0:
            concentration   = 0.0
        if concentration > 100:
            concentration   = 100.0
        concentration_y     = models.EmotionCoord.objects.filter(x2=float(round(concentration))).values('y2')
        if concentration > 70:
            concentration_status= '高'
            concentration_color = '#00FF00'
        elif 35 < concentration <= 70:
            concentration_status= '中'
            concentration_color = '#00FF00'
        info['emotion'] = {
                'vi':                   vi,
                'vi_y':                 vi_y,
                'vi_status':            vi_status,
                'vitality':             vitality,
                'vitality_y':           vitality_y[0]['y3'],
                'vitality_color':       vitality_color,
                'vitality_status':      vitality_status,
                'concentration':        concentration,
                'concentration_y':      concentration_y[0]['y2'],
                'energy':               round(detial[0]["energy"], 2),
                'regulation':           round(detial[0]["regulation"], 2),
                'concentration_status': concentration_status,
                'concentration_color':  concentration_color
            }
        
        brain_status    = '健康'
        brain_color     = '#00FF00'
        if detial[0]["brain_state"] == 4:
            brain_status    = '危险'
            brain_color     = '#FF0000'
        elif detial[0]["brain_state"] == 3:
            brain_color     = '#FFA500'
            brain_status    = '关注'
        elif detial[0]["brain_state"] == 2:
            brain_status    = '健康'
        elif detial[0]["brain_state"] == 1:
            brain_status    = '极好'
        brain_fatigue   = round(detial[0]["brain_fatigue"], 1)
        if brain_fatigue < -10:
            brain_fatigue   = -10.0
        elif brain_fatigue == -0.0:
            brain_fatigue   = '0.0'
        elif float(brain_fatigue) > 5:
            brain_fatigue   = '5.0'
        brain_fatigue_y = models.EmotionCoord.objects.filter(x1=float(brain_fatigue)).values('y1')
        info['brain']   = {
                'brain_state':      detial[0]["brain_state"],
                'brain_status':     brain_status,
                'brain_color':      brain_color,
                'brain_fatigue':    float(brain_fatigue),
                'brain_fatigue_y':  brain_fatigue_y[0]['y1'],
                'brain_emotion':    round(detial[0]["brain_emotion"], 2),
                'brain_energy':     round(detial[0]["brain_energy"], 2)
            }
        
        health_status   = '正常工作'
        health_color    = '#00FF00'
        if detial[0]["health_state"] == 1:
            health_status   = '正常工作'
        elif detial[0]["health_state"] == 2:
            health_color    = '#FFA500'
            health_status   = '适合休息'
        elif detial[0]["health_state"] == 3:
            health_color    = '#FF0000'
            health_status   = '建议体检'
        info['health']  = {
                'health_state':         detial[0]["health_state"],
                'health_status':        health_status,
                'health_correlation':   round(detial[0]["health_correlation"], 2),
                'health_delta':         round(detial[0]["health_delta"], 2),
                'health_color':         health_color
            }

        emotion_params_config = [
                {'name': '激动', 'en': 'aggression', 'bMin': 20, 'bMax': 50},
                {'name': '压力', 'en': 'stress', 'bMin': 20, 'bMax': 40},
                {'name': '不安', 'en': 'tension', 'bMin': 15, 'bMax': 40},
                {'name': '怀疑', 'en': 'suspect', 'bMin': 20, 'bMax': 50},
                {'name': '平衡', 'en': 'balance', 'bMin': 40, 'bMax': 80},
                {'name': '自信', 'en': 'charm', 'bMin': 50, 'bMax': 80},
                {'name': '能量', 'en': 'energy', 'bMin': 20, 'bMax': 40},
                {'name': '自控', 'en': 'regulation', 'bMin': 50, 'bMax': 80},
                {'name': '抑制', 'en': 'inhibition', 'bMin': 15, 'bMax': 25},
                {'name': '神经质', 'en': 'neuroticism', 'bMin': 10, 'bMax': 50},
            ]

        active_sum      = round(detial[0]["balance"], 2) + round(detial[0]["charm"], 2) + round(detial[0]["energy"],2) + round(detial[0]["regulation"], 2)
        negative_sum    = round(detial[0]["aggression"], 2) + round(detial[0]["stress"], 2) + round(detial[0]["tension"],2) + round(detial[0]["suspect"], 2)
        physiology_sum  = round(detial[0]["inhibition"], 2) + round(detial[0]["neuroticism"], 2)
        active_rate     = round((active_sum * 100 / (active_sum + negative_sum + physiology_sum)), 2)
        negative_rate   = round((negative_sum * 100 / (active_sum + negative_sum + physiology_sum)), 2)
        physiology_rate = round((physiology_sum * 100 / (active_sum + negative_sum + physiology_sum)), 2)
        info['tableData'] = [
                {'name': emotion_params_config[0]['name'], 'bMin': emotion_params_config[0]['bMin'],
                 'bMax': emotion_params_config[0]['bMax'], 'avg': round(detial[0]["aggression"], 2),
                 'min': round(detial[0]["aggression_min"], 2), 'max': round(detial[0]["aggression_max"], 2)},
                {'name': emotion_params_config[1]['name'], 'bMin': emotion_params_config[1]['bMin'],
                 'bMax': emotion_params_config[1]['bMax'], 'avg': round(detial[0]["stress"], 2),
                 'min': round(detial[0]["stress_min"], 2), 'max': round(detial[0]["stress_max"], 2)},
                {'name': emotion_params_config[2]['name'], 'bMin': emotion_params_config[2]['bMin'],
                 'bMax': emotion_params_config[2]['bMax'], 'avg': round(detial[0]["tension"], 2),
                 'min': round(detial[0]["tension_min"], 2), 'max': round(detial[0]["tension_max"], 2)},
                {'name': emotion_params_config[3]['name'], 'bMin': emotion_params_config[3]['bMin'],
                 'bMax': emotion_params_config[3]['bMax'], 'avg': round(detial[0]["suspect"], 2),
                 'min': round(detial[0]["suspect_min"], 2), 'max': round(detial[0]["suspect_max"], 2)},
                {'name': emotion_params_config[4]['name'], 'bMin': emotion_params_config[4]['bMin'],
                 'bMax': emotion_params_config[4]['bMax'], 'avg': round(detial[0]["balance"], 2),
                 'min': round(detial[0]["balance_min"], 2), 'max': round(detial[0]["balance_max"], 2)},
                {'name': emotion_params_config[5]['name'], 'bMin': emotion_params_config[5]['bMin'],
                 'bMax': emotion_params_config[5]['bMax'], 'avg': round(detial[0]["charm"], 2),
                 'min': round(detial[0]["charm_min"], 2), 'max': round(detial[0]["charm_max"], 2)},
                {'name': emotion_params_config[6]['name'], 'bMin': emotion_params_config[6]['bMin'],
                 'bMax': emotion_params_config[6]['bMax'], 'avg': round(detial[0]["energy"], 2),
                 'min': round(detial[0]["energy_min"], 2), 'max': round(detial[0]["energy_max"], 2)},
                {'name': emotion_params_config[7]['name'], 'bMin': emotion_params_config[7]['bMin'],
                 'bMax': emotion_params_config[7]['bMax'], 'avg': round(detial[0]["regulation"], 2),
                 'min': round(detial[0]["regulation_min"], 2), 'max': round(detial[0]["regulation_max"], 2)},
                {'name': emotion_params_config[8]['name'], 'bMin': emotion_params_config[8]['bMin'],
                 'bMax': emotion_params_config[8]['bMax'], 'avg': round(detial[0]["inhibition"], 2),
                 'min': round(detial[0]["inhibition_min"], 2), 'max': round(detial[0]["inhibition_max"], 2)},
                {'name': emotion_params_config[9]['name'], 'bMin': emotion_params_config[9]['bMin'],
                 'bMax': emotion_params_config[9]['bMax'], 'avg': round(detial[0]["neuroticism"], 2),
                 'min': round(detial[0]["neuroticism_min"], 2), 'max': round(detial[0]["neuroticism_max"], 2)},
            ]
        
        info['radarChartDataCategories'] = [
                emotion_params_config[0]['name'],
                emotion_params_config[1]['name'],
                emotion_params_config[2]['name'],
                emotion_params_config[3]['name'],
                emotion_params_config[4]['name'],
                emotion_params_config[5]['name'],
                emotion_params_config[6]['name'],
                emotion_params_config[7]['name'],
                emotion_params_config[8]['name'],
                emotion_params_config[9]['name']
            ]

        info['radarChartDataSeries'] = [{
                'name': '10维雷达图',
                'data': [
                    round(detial[0]["aggression"],  2),
                    round(detial[0]["stress"],      2),
                    round(detial[0]["tension"],     2),
                    round(detial[0]["suspect"],     2),
                    round(detial[0]["balance"],     2),
                    round(detial[0]["charm"],       2),
                    round(detial[0]["energy"],      2),
                    round(detial[0]["regulation"],  2),
                    round(detial[0]["inhibition"],  2),
                    round(detial[0]["neuroticism"], 2),
                ]
            }]
        
        info['pieChartDataSeries'] = [
                {'name':'积极', 'data':active_rate},
                {'name':'消极', 'data':negative_rate},
                {'name':'生理', 'data':physiology_rate}
            ]
        
        info['mental_state'] = {
                'x1':detial[0]['spirit_x1'],
                'y1':detial[0]['neuroticism_max'],
            }
        
                
        psychology  = []
        for i in ha:
            psychology.append(i["h"])
        info['psychology'] = psychology
        
        p_max       = max(psychology)
        info['psychology_index'] = psychology.index(p_max)

        return info


'''
# ================================
# 服务端接口, 获取视频url, 用于后续的视频下载
# ================================
'''
class VideoDownload(APIView):

    def get(self, request):
        video_id    = request.query_params.get('video_id')
        find        = models.Task.objects.filter(task_video_md5=video_id).get()
        video_uri   = find.task_video_uri
        video_url   = '{}://{}{}' . format(request.META.get('wsgi.url_scheme'), request.META.get('HTTP_HOST'), video_uri)
        return HttpResponseRedirect(video_url)


'''
# ================================
# 服务端接口, 上传接口
# ================================
'''
class VideoUpload(APIView):

    def post(self, request):
        print(request.FILES)
        return Response({'code':1, 'message':'success'})


'''
# ================================
# 服务端接口, 查询任务列表, 暂未使用
# ================================
'''
class ServerTaskList(APIView):

    def get(self, request):
        return Response({'code':0, 'message':'error, GET is not allowed'})

    def post(self, request):
        return Response({'code':1, 'message':'success', 'data':{'total':2, 'rows':[{},{}]}})



'''
# ================================
# 服务端接口, 获取一个任务, 暂未使用
# ================================
'''
class ServerTaskFetch(APIView):

    def get(self, request):
        return Response({'code':0, 'message':'error, GET is not allowed'})

    def post(self, request):
        return Response({'code':1, 'message':'success', 'data':{}})



'''
# ================================
# 服务端接口, 更新任务数据, 暂未使用
# ================================
'''
class ServerTaskUpdate(APIView):

    def get(self, request):
        return Response({'code':0, 'message':'error, GET is not allowed'})

    def post(self, request):
        return Response({'code':1, 'message':'success'})


'''
# ================================
# 管理后台接口 查看所有开发者
# ================================
'''
class AdminDeveloperList(APIView):

    def get(self, request):
        select      = models.Developer.objects.values().order_by('developer_inserttime')
        if not select:
            return Response({'code':1, 'message':'', 'data':{'total':0, 'rows':[]}})
        
        developer   = []
        for _select in select:
            _select['developer_inserttime_datetime'] = _select['developer_inserttime_datetime'].strftime("%Y-%m-%d %H:%M:%S")
            developer.append(_select)

        select2     = models.DeveloperApp.objects.values().order_by('-app_inserttime')
        if not select2:
            total   = len(developer)
            return Response( {'code':1, 'message':'', 'data':{'total':total, 'rows':developer}} )
        
        for _developer in developer:
            if _developer.get('', None) == None:
                _developer['developer_app'] = []
            for _select2 in select2:
                if _developer['developer_id'] == _select2['app_developer_id']:
                    _developer['developer_app'].append(_select2)
        
        total       = len(developer)
        return Response( {'code':1, 'message':'', 'data':{'total':total, 'rows':developer}} )


'''
# ================================
# 管理后台接口 查看某个开发者
# ================================
'''
class AdminDeveloperShow(APIView):

    def get(self, request):
        developer_id= request.query_params.get('developer_id')
        if developer_id == None:
            return Response({'code':0, 'message':'error, developer_id not exist in url'})
            
        select      = models.Developer.objects.filter(developer_id=developer_id)
        if not select:
            return Response( {'code':0, 'message':'error, data not exist by this developer_id'} )
        
        data        = model_to_dict(select[0])
        data['developer_inserttime_datetime']   = data['developer_inserttime_datetime'].strftime("%Y-%m-%d %H:%M:%S")
        data['developer_app']                   = []

        select2     = models.DeveloperApp.objects.filter(app_developer_id=developer_id).values().order_by('-app_inserttime')
        if select2:
            for _select2 in select2:
                data['developer_app'].append(_select2)
        
        return Response( {'code':1, 'message':'', 'data':data} )



'''
# ================================
# 管理后台接口 新增开发者
# ================================
'''
class AdminDeveloperInsert(APIView):

    def post(self, request):
        content_type= request.content_type
        if content_type.find(r"application/json") == None:
            return Response({'code':0, 'message':'error, Content-Type is not application/json'})
            
        developer_contact_name  = request.data.get("developer_contact_name", None)
        if developer_contact_name == None:
            return Response({'code':0, 'message':'error, developer_contact_name not exist'})
        if type(developer_contact_name) != type(""):
            return Response({'code':0, 'message':'error, developer_contact_name is not string'})

        
        developer_contact_phone = request.data.get("developer_contact_phone", None)
        if developer_contact_phone == None:
            return Response({'code':0, 'message':'error, developer_contact_phone not exist'})
        if type(developer_contact_phone) != type(""):
            return Response({'code':0, 'message':'error, developer_contact_phone is not string'})

        uuid                = str(time.time()) + str(random.randint(1, 999999))
        developer_id        = hashlib.md5(uuid.encode(encoding='UTF-8')).hexdigest()
        timezone            = pytz.timezone('Asia/Shanghai')
        inserttime          = int(time.time())
        inserttime_datetime = datetime.datetime.fromtimestamp(inserttime, timezone).strftime("%Y-%m-%d %H:%M:%S")
        models.Developer.objects.create(
            developer_id                    = developer_id,
            developer_contact_name          = developer_contact_name,
            developer_contact_phone         = developer_contact_phone,
            developer_inserttime            = inserttime,
            developer_inserttime_datetime   = inserttime_datetime
        )
        
        return Response({'code':1, 'message':'success'})



'''
# ================================
# 管理后台接口 查看所有应用
# ================================
'''
class AdminAppList(APIView):

    def get(self, request):
        app_developer_id = request.query_params.get('app_developer_id')
        if app_developer_id == None:
            select  = models.DeveloperApp.objects.values().order_by('-app_inserttime')
        else:
            select  = models.DeveloperApp.objects.filter(app_developer_id=app_developer_id).values().order_by('-app_inserttime')
        if not select:
            return Response({'code':1, 'message':'', 'data':{'total':0, 'rows':[]}})
        
        app     = []
        for _select in select:
            _select['app_inserttime_datetime'] = _select['app_inserttime_datetime'].strftime("%Y-%m-%d %H:%M:%S")
            app.append(_select)
            
        total   = len(app)
        return Response( {'code':1, 'message':'', 'data':{'total':total, 'rows':app}} )



'''
# ================================
# 管理后台接口 查看某个应用
# ================================
'''
class AdminAppShow(APIView):

    def get(self, request):
        app_id  = request.query_params.get('app_id')
        if app_id == None:
            return Response({'code':0, 'message':'error, app_id not exist in url'})
            
        select  = models.DeveloperApp.objects.filter(app_id=app_id)
        if not select:
            return Response( {'code':0, 'message':'error, data not exist by this app_id'} )
        
        data    = model_to_dict(select[0])
        data['app_inserttime_datetime'] = data['app_inserttime_datetime'].strftime("%Y-%m-%d %H:%M:%S")

        return Response( {'code':1, 'message':'', 'data':data} )



'''
# ================================
# 管理后台接口 新增应用
# ================================
'''
class AdminAppInsert(APIView):

    def post(self, request):
        content_type= request.content_type
        if content_type.find(r"application/json") == None:
            return Response({'code':0, 'message':'error, Content-Type is not application/json'})
            
        app_developer_id    = request.data.get("app_developer_id", None)
        if app_developer_id == None:
            return Response({'code':0, 'message':'error, app_developer_id not exist'})
        if type(app_developer_id) != type(""):
            return Response({'code':0, 'message':'error, app_developer_id is not string'})
            
        app_name            = request.data.get("app_name", None)
        if app_name == None:
            return Response({'code':0, 'message':'error, app_name not exist'})
        if type(app_name) != type(""):
            return Response({'code':0, 'message':'error, app_name is not string'})

        count               = models.Developer.objects.filter(developer_id=app_developer_id).count()
        if count != 1:
            return Response({'code':0, 'message':'error, developer not exist by this app_developer_id'})
            
        uuid                = str(time.time()) + str(random.randint(1, 999999))
        app_id              = hashlib.md5(uuid.encode(encoding='UTF-8')).hexdigest()
        timezone            = pytz.timezone('Asia/Shanghai')
        inserttime          = int(time.time())
        inserttime_datetime = datetime.datetime.fromtimestamp(inserttime, timezone).strftime("%Y-%m-%d %H:%M:%S")
        models.DeveloperApp.objects.create(
            app_id                  = app_id,
            app_developer_id        = app_developer_id,
            app_name                = app_name,
            app_inserttime          = inserttime,
            app_inserttime_datetime = inserttime_datetime
        )
        
        return Response({'code':1, 'message':'success'})


