from django.shortcuts import render
from rest_framework import viewsets
from .models import Users, Posts
from .serializers import UsersSerializer, PostsSerializer

class UsersView(viewsets.ModelViewSet):
    queryset = Users.objects.all()
    serializer_class = UsersSerializer

class PostsView(viewsets.ModelViewSet):
    queryset = Posts.objects.all()
    serializer_class = PostsSerializer