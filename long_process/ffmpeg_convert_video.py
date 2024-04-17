import os, time, datetime, pytz, pymysql, shutil, subprocess


'''
ffmpeg的视频转码
'''
def handle_mp4_convert(connect, cursor, row):
    timezone    = pytz.timezone('Asia/Shanghai')
    updatetime  = int(time.time())
    updatetime_datetime = datetime.datetime.fromtimestamp(updatetime, timezone).strftime("%Y-%m-%d %H:%M:%S")
    sql         = "update `platform_task` set `task_state_code`='2', `task_state_remark`='视频文件转码中', `task_updatetime`='{}', `task_updatetime_datetime`='{}' where `task_id`='{}'" . format(updatetime, updatetime_datetime, row["task_id"])
    cursor.execute(sql)
    connect.commit()
    
    root        = os.path.dirname(os.getcwd())
    audiofile   = '{}/static/video/emptyaudio.aac' . format(root)
    videonewfile= '{}/static/video/original/{}_new.mp4' . format(root, row["task_video_md5"])
    command     = "/usr/bin/ffmpeg -i {} -i {} -vcodec h264 -profile:v baseline -pix_fmt yuv420p -acodec aac -ar 44100 -ac 2 -b:a 32k -y {}" . format(row['task_video_path'], audiofile, videonewfile)
    process     = subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT)
    
    if os.path.exists(videonewfile) == False:
        updatetime  = int(time.time())
        updatetime_datetime = datetime.datetime.fromtimestamp(updatetime, timezone).strftime("%Y-%m-%d %H:%M:%S")
        sql         = "update `platform_task` set `task_state_code`='4', `task_state_remark`='视频文件转码失败', `task_updatetime`='{}', `task_updatetime_datetime`='{}' where `task_id`='{}'" . format(updatetime, updatetime_datetime, row["task_id"])
        cursor.execute(sql)
        connect.commit()
        row['task_state_code']          = 4
        row['task_state_remark']        = '视频文件转码失败'
        row['task_updatetime']          = updatetime
        row['task_updatetime_datetime'] = updatetime_datetime
        return row
    
    video_name  = '{}.mp4'.format(row["task_video_md5"])
    video_uri   = '/static/video/original/{}' . format(video_name)
    video_path  = '{}/static/video/original/{}' . format(root, video_name)
    
    os.remove(row['task_video_path'])
    os.rename(videonewfile, video_path)
    
    updatetime  = int(time.time())
    updatetime_datetime = datetime.datetime.fromtimestamp(updatetime, timezone).strftime("%Y-%m-%d %H:%M:%S")
    sql         = "update `platform_task` set `task_video_name`='{}', `task_video_uri`='{}', `task_video_path`='{}', `task_updatetime`='{}', `task_updatetime_datetime`='{}' where `task_id`='{}'" . format(video_name, video_uri, video_path, updatetime, updatetime_datetime, row["task_id"])
    cursor.execute(sql)
    connect.commit()
    
    row['task_state_code']          = 2
    row['task_state_remark']        = '视频文件转码中'
    row['task_video_name']          = video_name
    row['task_video_uri']           = video_uri
    row['task_video_path']          = video_path
    row['task_updatetime']          = updatetime
    row['task_updatetime_datetime'] = updatetime_datetime
    return row


'''
判断是否为标准的mp4视频文件
是mp4, 返回True
非mp4, 返回False
'''
def handle_mp4_check(video_path):
    command = "/usr/bin/ffprobe -i {}" . format(video_path)
    process = subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT)
    feature = {}
    for line in process.splitlines(): 
        line = str(line, encoding = "utf-8").strip()

        if line.find('Stream') == 0:
            if line.find('Video') > 0:
                feature['video'] = line
            elif line.find('Audio') > 0:
                feature['audio'] = line
        del line
    if len(feature) != 2:
        return False

    if feature['audio'].find('aac')==-1 or feature['audio'].find('mp4a')==-1:
        return False
    
    if feature['video'].find('h264')==-1 or feature['video'].find('yuv420p')==-1:
        return False
    
    return True



'''
对每个任务的处理
'''
def handle(connect, cursor, row):
    if handle_mp4_check(row['task_video_path']) == False:
        row = handle_mp4_convert(connect, cursor, row)

    root    = os.path.dirname(os.getcwd())
    path1   = row['task_video_name'][:1]
    path2   = row['task_video_name'][1:3]
    path3   = '{}/static/video/download/{}/{}' . format(root, path1, path2)
    if os.path.exists(path3) == False:
        os.makedirs(path3)
    
    task_video_uri  = '/static/video/download/{}/{}/{}' . format(path1, path2, row['task_video_name'])
    task_video_path = '{}/{}' . format(path3, row['task_video_name'])
    shutil.move(row["task_video_path"], task_video_path)
    
    timezone    = pytz.timezone('Asia/Shanghai')
    updatetime  = int(time.time())
    updatetime_datetime = datetime.datetime.fromtimestamp(updatetime, timezone).strftime("%Y-%m-%d %H:%M:%S")
    sql         = "update `platform_task` set `task_video_uri`='{}', `task_video_path`='{}', `task_state_code`='6', `task_state_remark`='视频已准备好, 待识别', `task_updatetime`='{}', `task_updatetime_datetime`='{}' where `task_id`='{}'" . format(task_video_uri, task_video_path, updatetime, updatetime_datetime, row["task_id"])
    cursor.execute(sql)
    
    sql2    = "insert into `emotion_video` (`video_id`, `video_photo`, `video_path`, `video_origin`, `status`, `created_at`, `updated_at`) values('{}', '', '{}', '1', '1', '{}','{}');" . format(row["task_video_md5"], row["task_video_name"], updatetime_datetime, updatetime_datetime)
    cursor.execute(sql2)
    
    sql3    = "insert into `emotion_user_video` (`user_id`, `video_id`, `video_status`, `status`, `created_at`, `updated_at`) values ('user_id_temp', '{}', '1', '1', '{}','{}')" . format(row["task_video_md5"], updatetime_datetime, updatetime_datetime)
    cursor.execute(sql3)

    connect.commit()



'''
轮询数据库, 当查找需要处理的视频文件后, 就移动其目录位置
后续, 我会添加上ffmpeg转码的功能
'''
def main():
    while True:
        connect = pymysql.connect(host='127.0.0.1', user='root', password='00bee1027c2b11ebbd5600163e16e4df', db='emotion', port=3306, charset='utf8')
        cursor  = connect.cursor()
        sql     = "select * from `platform_task` where `task_state_code`='0'"
        count   = cursor.execute(sql)
        if count == 0:
            cursor.close()
            del sql, count, cursor, connect
            time.sleep(1)
            continue
        
        column  = []
        for description in cursor.description:
            column.append(description[0])
            del description
        data    = []
        for row in cursor.fetchall():
            data.append(dict(zip(column, row)))
            del row
        
        for row in data:
            handle(connect, cursor, row)
        
        cursor.close()
        connect.close()
        del sql, count, column, data, cursor, connect


if __name__ == '__main__':
    main()

