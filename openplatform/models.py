from django.db import models


class Developer(models.Model):
    developer_id                    = models.CharField(primary_key=True, max_length=32)
    developer_contact_name          = models.CharField(max_length=50)
    developer_contact_phone         = models.CharField(max_length=11)
    developer_inserttime            = models.PositiveIntegerField()
    developer_inserttime_datetime   = models.DateTimeField()
    
    class Meta:
        managed = False
        db_table= 'platform_developer'


class DeveloperApp(models.Model):
    app_id                  = models.CharField(primary_key=True, max_length=32)
    app_developer_id        = models.CharField(max_length=32)
    app_name                = models.CharField(max_length=50)
    app_inserttime          = models.PositiveIntegerField()
    app_inserttime_datetime = models.DateTimeField()
    
    class Meta:
        managed = False
        db_table= 'platform_developer_app'


class Session(models.Model):
    session_token               = models.CharField(primary_key=True, max_length=50)
    session_developer_id        = models.CharField(max_length=32)
    session_app_id              = models.CharField(max_length=50)
    session_inserttime          = models.PositiveIntegerField()
    session_inserttime_datetime = models.DateTimeField()
    session_expiretime          = models.PositiveIntegerField()
    session_expiretime_datetime = models.DateTimeField()
    
    class Meta:
        managed = False
        db_table= 'platform_session'


class Task(models.Model):
    task_id                 = models.CharField(primary_key=True, max_length=50)
    task_video_md5          = models.CharField(max_length=32)
    task_video_name         = models.CharField(max_length=50)
    task_video_uri          = models.CharField(max_length=255)
    task_video_path         = models.CharField(max_length=255)
    task_state_code         = models.PositiveIntegerField()
    task_state_remark       = models.CharField(max_length=50)
    task_inserttime          = models.PositiveIntegerField()
    task_inserttime_datetime = models.DateTimeField()
    task_updatetime          = models.PositiveIntegerField()
    task_updatetime_datetime = models.DateTimeField()
    
    class Meta:
        managed = False
        db_table= 'platform_task'


class EmotionUserVideo(models.Model):
    rid             = models.AutoField(primary_key=True)
    user_id         = models.CharField(max_length=32)
    video_id        = models.CharField(max_length=32)
    kid_id          = models.CharField(max_length=32, blank=True, null=True)
    video_status    = models.PositiveIntegerField()
    status          = models.PositiveIntegerField(default=1)
    created_at      = models.DateTimeField()
    updated_at      = models.DateTimeField(blank=True, null=True)
    
    class Meta:
        managed = False
        db_table= 'emotion_user_video'


class EmotionReport(models.Model):
    report_id           = models.CharField(primary_key=True, max_length=32)
    record_id           = models.CharField(max_length=32)
    video_id            = models.CharField(max_length=32)
    user_id             = models.CharField(max_length=32)
    aggression          = models.FloatField()
    aggression_min      = models.FloatField()
    aggression_max      = models.FloatField()
    stress              = models.FloatField()
    stress_min          = models.FloatField()
    stress_max          = models.FloatField()
    tension             = models.FloatField()
    tension_min         = models.FloatField()
    tension_max         = models.FloatField()
    suspect             = models.FloatField()
    suspect_min         = models.FloatField()
    suspect_max         = models.FloatField()
    balance             = models.FloatField()
    balance_min         = models.FloatField()
    balance_max         = models.FloatField()
    charm               = models.FloatField()
    charm_min           = models.FloatField()
    charm_max           = models.FloatField()
    energy              = models.FloatField()
    energy_min          = models.FloatField()
    energy_max          = models.FloatField()
    regulation          = models.FloatField()
    regulation_min      = models.FloatField()
    regulation_max      = models.FloatField()
    inhibition          = models.FloatField()
    inhibition_min      = models.FloatField()
    inhibition_max      = models.FloatField()
    neuroticism         = models.FloatField()
    neuroticism_min     = models.FloatField()
    neuroticism_max     = models.FloatField()
    vi                  = models.FloatField()
    vitality            = models.FloatField()
    concentration       = models.FloatField()
    group_id            = models.PositiveIntegerField()
    brain_state         = models.FloatField()
    brain_fatigue       = models.FloatField()
    brain_emotion       = models.FloatField()
    brain_energy        = models.FloatField()
    health_state        = models.PositiveIntegerField()
    health_correlation  = models.FloatField()
    health_delta        = models.FloatField()
    spirit_x1           = models.FloatField()
    spirit_y1           = models.FloatField()
    spirit_x2           = models.FloatField()
    spirit_y2           = models.FloatField()
    remark              = models.TextField(blank=True, null=True)
    content             = models.TextField(blank=True, null=True)
    status              = models.PositiveIntegerField(default=1)
    created_at          = models.DateTimeField()
    updated_at          = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed     = True
        db_table    = 'emotion_report'


class EmotionGroup(models.Model):
    group_id        = models.AutoField(primary_key=True)
    group_no        = models.CharField(max_length=32)
    group_name      = models.CharField(max_length=255)
    group_status    = models.CharField(max_length=255)
    group_remark    = models.CharField(max_length=255)
    group_feature   = models.CharField(max_length=2000)
    group_process   = models.CharField(max_length=2000)
    status          = models.PositiveIntegerField()
    created_at      = models.DateTimeField()
    updated_at      = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed     = True
        db_table    = 'emotion_group'


class EmotionFh(models.Model):
    fh_id           = models.BigAutoField(primary_key=True)
    user_id         = models.CharField(max_length=32)
    video_id        = models.CharField(max_length=32)
    record_id       = models.CharField(max_length=32)
    report_id       = models.CharField(max_length=32)
    h               = models.FloatField()
    ha              = models.FloatField()
    status          = models.PositiveIntegerField(default=1)
    created_at      = models.DateTimeField()
    updated_at      = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed     = True
        db_table    = 'emotion_fh'


class EmotionCoord(models.Model):
    x1 = models.CharField(max_length=32, blank=True, null=True)
    y1 = models.CharField(max_length=32, blank=True, null=True)
    x2 = models.CharField(max_length=32, blank=True, null=True)
    y2 = models.CharField(max_length=32, blank=True, null=True)
    x3 = models.CharField(max_length=32, blank=True, null=True)
    y3 = models.CharField(max_length=32, blank=True, null=True)
    x4 = models.CharField(max_length=32, blank=True, null=True)
    y4 = models.CharField(max_length=32, blank=True, null=True)

    class Meta:
        managed     = True
        db_table    = 'emotion_coord'

