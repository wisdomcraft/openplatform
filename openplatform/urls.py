from django.contrib import admin
from django.urls    import path
from openplatform   import views

urlpatterns = [
    path('', views.Home.as_view()),
    path('api/open/token/fetch',    views.OpenTokenFetch.as_view()),
    path('api/open/token/check',    views.OpenTokenCheck.as_view()),
    path('api/open/task/upload',    views.OpenTaskUpload.as_view()),
    path('api/open/task/taskid',    views.OpenTaskTaskid.as_view()),
    path('api/open/task/state',     views.OpenTaskState.as_view()),
    path('api/server/task/list',    views.ServerTaskList.as_view()),
    path('api/server/task/fetch',   views.ServerTaskFetch.as_view()),
    path('api/server/task/update',  views.ServerTaskUpdate.as_view()),
    path('v1/video/download',       views.VideoDownload.as_view()),
    path('video/upload',            views.VideoUpload.as_view()),
    path('api/admin/developer/list',    views.AdminDeveloperList.as_view()),
    path('api/admin/developer/show',    views.AdminDeveloperShow.as_view()),
    path('api/admin/developer/insert',  views.AdminDeveloperInsert.as_view()),
    path('api/admin/app/list',          views.AdminAppList.as_view()),
    path('api/admin/app/show',          views.AdminAppShow.as_view()),
    path('api/admin/app/insert',        views.AdminAppInsert.as_view()),
]
