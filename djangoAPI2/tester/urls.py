from django.urls import path
from tester import views

urlpatterns = [
    path('users/', views.user_list),
    path('users/<int:pk>/', views.user_detail),
    path('posts/', views.post_list),
    path('posts/<int:pk>/', views.post_detail)
]