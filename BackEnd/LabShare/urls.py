from django.urls import path
from django.conf.urls import include
from rest_framework import routers
from LabShare import views
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('userinfo/<int:user_id>/', views.GetUserInfo.as_view()),
    path('current/', views.Current.as_view()),
    path('user/feed/<int:id>/', views.SinglePost.as_view()), #
    path('user/feed/', views.Feed.as_view()),
    path('user/<int:user_id>/posts/', views.UserPosts.as_view()),
    path('user/<int:user_id>/profile/', views.Profile.as_view()),
    path('categories/', views.AvailableCategories.as_view()),
    path('categories/<int:id>/', views.SingleCategory.as_view()),
    path('register/', views.UserRegister.as_view()),
    path('login/', views.UserLogin.as_view()),
    path('logout/', views.UserLogout.as_view()),
] + static(settings.MEDIA_URL, document_root = settings.MEDIA_ROOT)

#GRAE
#Create Categories table ##DONE
#Attach profile and permissions to users automatically upon registration ##DONE
#Give ability to update these categories and permissions available ##DONE
#Change a user’s permissions
#Add categories to posts ##DONE
#Add the ability to query these posts by categories
#Add page restrictions based on permissions of logged in user ##DONE
#search functionality
#Get started on admin functionality
#Pagination
#Profile photos ##DONE

#GREG
#Reimplement Postgres
#Host app on AWS server
#Strengthen authentication security

#categories/ show all categories and add categories
#categories/id/ shows a category for manipulation
#userinfo/<user_id>/ now returns {token, email} 
#current/ now returns id of currently logged in user
#views now restricted to logged in users
#register and login restricted to logged out users
#pip install pillow
#profile images now work