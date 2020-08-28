from django.urls import path
from tester import views

urlpatterns = [
<<<<<<< HEAD
    path('users/', views.user_list), #all users
    path('users/<int:pk>/profile/', views.user_detail), #user profile
=======
    path('users/', views.user_list),
    path('users/<int:pk>/', views.user_detail),
>>>>>>> parent of 80aa7a7... minor changes
    path('posts/', views.post_list),
    path('posts/<int:pk>/', views.post_detail),
    path('users/<int:pk>/posts/', views.user_post_list)
]