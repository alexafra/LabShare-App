from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from tester import views

urlpatterns = [
    path('users/', views.UserList.as_view()),
    path('users/<int:pk>/', views.UserDetail.as_view()),
    path('posts/', views.PostList.as_view()),
    path('posts/<int:pk>/', views.PostDetail.as_view()),
    path('users/<int:pk>/posts/', views.UserPostList.as_view())
]