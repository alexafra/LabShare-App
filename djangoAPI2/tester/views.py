from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework.parsers import JSONParser
from tester.models import User, Post
from tester.serializers import UserSerializer, PostSerializer

@csrf_exempt
def user_list(request):
    if request.method == 'GET':
        users = User.objects.all()
        serializer = UserSerializer(users, many=True)
        return JsonResponse(serializer.data, safe = False)
    elif request.method == 'POST':
        data = JSONParser().parse(request)
        serializer = UserSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data, status=201)
        return JsonResponse(serializer.errors, status=400)
    
@csrf_exempt
def user_detail(request, pk):
    try:
        user = User.objects.get(pk=pk)
    except User.DoesNotExist:
        return HttpResponse(status=404)
    
    if request.method == 'GET':
        serializer = UserSerializer(user) #converts Python to JSON
        return JsonResponse(serializer.data)
    
    elif request.method == 'PUT': #change user data to data parsed in (data=data)
        data = JSONParser().parse(request) #converts JSON to Python
        serializer = UserSerializer(user, data=data) #converts new Python back to JSON
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data)
        return JsonResponse(serializer.data, status=400)
    
    elif request.method == 'DELETE':
        user.delete()
        return HttpResponse(status=204)

@csrf_exempt
def post_list(request):
    if request.method == 'GET':
        posts = Post.objects.all()
        serializer = PostSerializer(posts, many=True) #all posts from Python to JSON
        return JsonResponse(serializer.data, safe = False)
    elif request.method == 'POST': 
        data = JSONParser().parse(request) #JSON to Python, so serializer can read
        serializer = PostSerializer(data=data) #Python to JSON, confirm valid
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data, status=201) #valid
        return JsonResponse(serializer.errors, status=400) #invalid

@csrf_exempt
def post_detail(request, pk):
    try:
        post = Post.objects.get(pk=pk)
    except Post.DoesNotExist:
        return HttpResponse(status=404)
    
    if request.method == 'GET':
        serializer = PostSerializer(post) #converts Python to JSON for post with ID
        return JsonResponse(serializer.data) #returns
    
    elif request.method == 'PUT': #change user data to data parsed in (data=data)
        data = JSONParser().parse(request) #converts JSON to Python
        serializer = PostSerializer(post, data=data) #converts new Python back to JSON
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data)
        return JsonResponse(serializer.data, status=400)
    
    elif request.method == 'DELETE':
        post.delete()
        return HttpResponse(status=204)

@csrf_exempt
def user_post_list(request, pk):
    try:
        posts = Post.objects.filter(author=pk)
    except Post.DoesNotExist:
        return HttpResponse(status=404)
    
    if request.method == 'GET':
        serializer = PostSerializer(posts, many=True) #converts Python to JSON for post with ID
        return JsonResponse(serializer.data, safe = False) #returns


# Create your views here.
