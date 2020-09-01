from django.urls import path
from django.conf.urls import include
from rest_framework.urlpatterns import format_suffix_patterns
from tester import views
from rest_framework import routers

urlpatterns = [
    path('users/', views.UserList.as_view()),
    path('users/<int:pk>/profile/', views.UserDetail.as_view()),
    path('posts/', views.PostList.as_view()),
    path('posts/<int:pk>/', views.PostDetail.as_view()),
    path('users/<int:author>/posts/', views.UserPostList.as_view()),
    path('register/', views.UserRegister.as_view()),
    path('login/', views.UserLogin.as_view()),
    path('logout/', views.UserLogout.as_view()),
    path('current/', views.Current.as_view())
]