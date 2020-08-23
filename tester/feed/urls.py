from django.urls import path
from . import views
from .views import (PostCreateView, PostListView, PostDetailView, PostUpdateView,
UserCreateView, PostDeleteView, UserDeleteView)

urlpatterns = [
    path('posts/<int:pk>/', PostDetailView.as_view(), name='post-detail'),
    path('posts/<int:pk>/delete/', PostDeleteView.as_view(), name='post-delete'),
    path('posts/<int:pk>/update/', PostUpdateView.as_view(), name = 'post-update'),
    path('posts/new/', PostCreateView.as_view(), name='post-create'),
    path('posts/', PostListView.as_view(), name='feed-home'),
    path('users/new/', UserCreateView.as_view(), name='user-create'),
    path('users/<int:pk>/delete/', UserDeleteView.as_view(), name='user-delete'),
    path('<author>/posts/', views.UserPosts, name = 'feed-user')
]