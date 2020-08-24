from django.urls import path, include
from . import views
from rest_framework import routers

router = routers.DefaultRouter()
router.register('users', views.UsersView)
router.register('posts', views.PostsView)

urlpatterns = [
    path('', include(router.urls)), #imports all the standard urls for REST
]