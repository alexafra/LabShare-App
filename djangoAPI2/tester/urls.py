from django.urls import path
from tester import views

urlpatterns = [
    path('users/', views.user_list), #all users
    path('users/<int:pk>/profile/', views.user_detail), #user profile
    path('posts/', views.post_list),
    path('posts/<int:pk>/', views.post_detail),
    path('users/<int:pk>/posts/', views.user_post_list)
]