from django.shortcuts import render
from rest_framework import viewsets, permissions
from .models import User, Post, Group
from .serializers import UserSerializer, PostSerializer, GroupSerializer 

class UserView(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

class PostView(viewsets.ModelViewSet):
    queryset = Post.objects.all()
    serializer_class = PostSerializer

class GroupView(viewsets.ModelViewSet):
    queryset = Group.objects.all()
    serializer_class = GroupSerializer
