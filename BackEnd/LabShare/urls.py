from django.urls import path
from django.conf.urls import include
from rest_framework import routers
from LabShare import views

urlpatterns = [
    path('user/<str:email>/preferences/', views.Preferences.as_view()), #user preferences
    path('user/current/', views.Current.as_view()), #currently logged in user email
    path('user/<str:email>/feed/<int:id>/', views.SinglePost.as_view()), #
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

#automatically set preferences and profile on register
#search function
#change authentication to cookies
#add categories and tags to posts
#add page permissions