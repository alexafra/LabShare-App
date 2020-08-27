from django.shortcuts import render
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.parsers import JSONParser
from django.contrib.auth.models import User
from tester.models import Post
from tester.serializers import UserSerializer, PostSerializer

@api_view(['GET', 'POST'])
def user_list(request):
    if request.method == 'GET':
        users = User.objects.all()
        serializer = UserSerializer(users, many=True)
        return Response(serializer.data)
    elif request.method == 'POST':
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
@api_view(['GET', 'PUT', 'DELETE'])
def user_detail(request, pk):
    try:
        user = User.objects.get(pk=pk)
    except User.DoesNotExist:
        return Response(status = status.HTTP_404_NOT_FOUND)
    
    if request.method == 'GET':
        serializer = UserSerializer(user) #converts Python to JSON
        return Response(serializer.data)
    
    elif request.method == 'PUT': #change user data to data parsed in (data=data)
        serializer = UserSerializer(user, data=request.data) #converts new Python back to JSON
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    elif request.method == 'DELETE':
        user.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

@api_view(['GET', 'POST'])
def post_list(request):
    if request.method == 'GET':
        posts = Post.objects.all()
        serializer = PostSerializer(posts, many = True) #all posts from Python to JSON
        return Response(serializer.data)
    elif request.method == 'POST': 
        serializer = PostSerializer(data=posts.data) #Python to JSON, confirm valid
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED) #valid
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST) #invalid

@api_view(['GET', 'PUT', 'DELETE'])
def post_detail(request, pk):
    try:
        post = Post.objects.get(pk=pk)
    except Post.DoesNotExist:
        return Response(status=status.HTTP_400_BAD_REQUEST)
    
    if request.method == 'GET':
        serializer = PostSerializer(post) #converts Python to JSON for post with ID
        return Response(serializer.data) #returns
    
    elif request.method == 'PUT': #change user data to data parsed in (data=data)
        serializer = PostSerializer(post, data=request.data) #converts new Python back to JSON
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.data, status.HTTP_400_BAD_REQUEST)
    
    elif request.method == 'DELETE':
        post.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

@api_view(['GET'])
def user_post_list(request, pk):
    posts = Post.objects.filter(author=pk)
    if request.method == 'GET':
        serializer = PostSerializer(posts, many = True) #converts Python to JSON for post with ID
        return Response(serializer.data) #returns


# Create your views here.
