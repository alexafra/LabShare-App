from django.urls import path
from django.conf.urls import include
from rest_framework import routers
from LabShare import views

urlpatterns = [
    #path('users/', views.UserList.as_view()), ##all users
    #path('users/<int:pk>/', views.UserDetail.as_view()), ##user fact data
    #path('current/', views.Current.as_view()), ##current user
    #path('posts/', views.PostList.as_view()), ##all posts
    #path('posts/<int:pk>/', views.PostDetail.as_view()), ##single post
    #path('users/<int:author>/posts/', views.UserPostList.as_view()), ##posts for a user
    #path('preferences/', views.Preferences.as_view()), ##create preference
    #path('profile/', views.Profile.as_view()), ##create profile
    path('user/<str:email>/preferences/', views.Preferences.as_view()),
    path('user/current/', views.Current.as_view()),
    path('user/<str:email>/feed/<int:id>/', views.SinglePost.as_view()),
    path('user/<str:email>/feed/', views.Feed.as_view()),
    path('user/<str:email>/posts/', views.UserPosts.as_view()),
    path('user/<str:email>/profile/', views.Profile.as_view()),
    path('register/', views.UserRegister.as_view()),
    path('login/', views.UserLogin.as_view()),
    path('logout/', views.UserLogout.as_view()),
]

#register/
#login/
#logout/
#user/<email>/profile/      #user profile
#user/<email>/posts/        #user posts
#user/<email>/feed/         #all posts
#user/<email>/posts/<post_id>/        #a single post

#current/       #current user
#profile/       #add/remove profile
#preferences/       #user preferences
