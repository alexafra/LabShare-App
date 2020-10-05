from django.urls import path, re_path
from django.conf.urls import include
from rest_framework import routers
from LabShare import views
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    #TEST URLS
    path('current', views.Current.as_view()), #id of currently logged in user (GET)
    path('userinfo/<int:user_id>', views.GetUserInfo.as_view()), #token and email for a given user id (GET)
    #USER
    path('users/<int:user_id>', views.SingleUser.as_view()), #(GET, PUT, DELETE)
    path('users/<int:user_id>/profile', views.Profile.as_view()), #(GET, PUT, DELETE)
    path('users', views.Users.as_view()), #all users or user search(GET)
    #POSTS
    path('users/<int:user_id>/feed', views.Feed.as_view()), #view posts with(?) or without filters (GET)
    path('users/<int:user_id>/posts/<int:post_id>', views.SinglePost.as_view()), #(GET, PUT, DELETE)
    path('users/<int:user_id>/posts', views.UserPosts.as_view()), #get posts for a user, create a post (GET, POST)
    #COMMENTS
    path('users/<int:user_id>/posts/<int:post_id>/comments', views.Comments.as_view()), #create post comment, get post comments (GET, POST)
    path('users/<int:user_id>/posts/<int:post_id>/comments/<int:comment_id>', views.SingleComment.as_view()), #(GET, PUT, DELETE)
    #AUTHENTICATION
    path('register', views.UserRegister.as_view()), #(POST)
    path('login', views.UserLogin.as_view()), #(POST)
    path('logout', views.UserLogout.as_view()), #(POST)
]
# + static(settings.MEDIA_URL, document_root = settings.MEDIA_ROOT)

#GRAE
#comments ##DONE
#category filter ##DONE
#search ##DONE
#user image changed to a string ##DONE
#categories changed to hardcoded strings rather than updateable model ##DONE
#user id, email and profile_id locked ##DONE
#users who are not the owner of a user, post, profile or comment object, cannot modify that object
#admins have all permissions that a normal user would have of their own content
#admin functionality to change users from active/non-active
#make serializers more concise ##DONE
#https
#first_name and last name essential ##DONE

#REFACTORING:
##users/user_id/feed: get all posts and category filters if query string
##users/user_id/posts: get posts from a user, create posts ##posts not created from feed anymore
##users/user_id/posts/post_id/comments: create post comments, get post comments ##comments not created from post_id/comments anymore
##users/user_id: change to APIView


#GREG
#Reimplement Postgres
#Host app on AWS server
#Strengthen authentication security
