from tester.models import User, Post
from tester.serializers import UserSerializer, PostSerializer
from django.http import Http404
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

class UserList(APIView):
    def get(self, request, format=None):
        users = User.objects.all()
        serializer = UserSerializer(users, many=True)
        return Response(serializer.data)

    def post(self, request, format=None):
        serializer = UserSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

#def user_list(request):
#    if request.method == 'GET':
#        users = User.objects.all()
#        serializer = UserSerializer(users, many=True)
#        return JsonResponse(serializer.data, safe = False)
#    elif request.method == 'POST':
#        data = JSONParser().parse(request)
#        serializer = UserSerializer(data=data)
#        if serializer.is_valid():
#            serializer.save()
#            return JsonResponse(serializer.data, status=201)
#        return JsonResponse(serializer.errors, status=400)
    
class UserDetail(APIView):
    def get_object(self, pk):
        try:
            return Snippet.objects.get(pk=pk)
        except Snippet.DoesNotExist:
            raise Http404

    def get(self, request, pk, format=None):
        snippet = self.get_object(pk)
        serializer = UserSerializer(user)
        return Response(serializer.data)

    def put(self, request, pk, format=None):
        snippet = self.get_object(pk)
        serializer = UserSerializer(user, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, pk, format=None):
        snippet = self.get_object(pk)
        user.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

#def user_detail(request, pk):
#    try:
#        user = User.objects.get(pk=pk)
#    except User.DoesNotExist:
#        return HttpResponse(status=404)
#    
#    if request.method == 'GET':
#        serializer = UserSerializer(user) #converts Python to JSON
#        return JsonResponse(serializer.data)
#    
#    elif request.method == 'PUT': #change user data to data parsed in (data=data)
#        data = JSONParser().parse(request) #converts JSON to Python
#        serializer = UserSerializer(user, data=data) #converts new Python back to JSON
#        if serializer.is_valid():
#            serializer.save()
#            return JsonResponse(serializer.data)
#        return JsonResponse(serializer.data, status=400)
#    
#    elif request.method == 'DELETE':
#        user.delete()
#        return HttpResponse(status=204)

class PostList(APIView):
    def get(self, request, format=None):
        users = Post.objects.all()
        serializer = PostSerializer(users, many=True)
        return Response(serializer.data)

    def post(self, request, format=None):
        serializer = PostSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

#def post_list(request):
#    if request.method == 'GET':
#        posts = Post.objects.all()
#        serializer = PostSerializer(posts, many=True) #all posts from Python to JSON
#        return JsonResponse(serializer.data, safe = False)
#    elif request.method == 'POST': 
#        data = JSONParser().parse(request) #JSON to Python, so serializer can read
#        serializer = PostSerializer(data=data) #Python to JSON, confirm valid
#        if serializer.is_valid():
#            serializer.save()
#            return JsonResponse(serializer.data, status=201) #valid
#        return JsonResponse(serializer.errors, status=400) #invalid

class PostDetail(APIView):
    def get_object(self, pk):
        try:
            return Post.objects.get(pk=pk)
        except Post.DoesNotExist:
            raise Http404

    def get(self, request, pk, format=None):
        snippet = self.get_object(pk)
        serializer = PostSerializer(user)
        return Response(serializer.data)

    def put(self, request, pk, format=None):
        snippet = self.get_object(pk)
        serializer = PostSerializer(user, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, pk, format=None):
        snippet = self.get_object(pk)
        post.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

#def post_detail(request, pk):
#    try:
#        post = Post.objects.get(pk=pk)
#    except Post.DoesNotExist:
#        return HttpResponse(status=404)
#    
#    if request.method == 'GET':
#        serializer = PostSerializer(post) #converts Python to JSON for post with ID
#        return JsonResponse(serializer.data) #returns
#    
#    elif request.method == 'PUT': #change user data to data parsed in (data=data)
#        data = JSONParser().parse(request) #converts JSON to Python
#        serializer = PostSerializer(post, data=data) #converts new Python back to JSON
#        if serializer.is_valid():
#            serializer.save()
#            return JsonResponse(serializer.data)
#        return JsonResponse(serializer.data, status=400)
#    
#    elif request.method == 'DELETE':
#        post.delete()
#        return HttpResponse(status=204)

class UserPostList(APIView):
    def get_object(self, pk):
        try:
            return Post.objects.filter(author = pk)
        except Post.DoesNotExist:
            raise Http404

    def get(self, request, pk, format=None):
        post = self.get_object(pk)
        serializer = PostSerializer(post)
        return Response(serializer.data)

#def user_post_list(request, pk):
#    try:
#        posts = Post.objects.filter(author=pk)
#    except Post.DoesNotExist:
#        return HttpResponse(status=404)
#    
#    if request.method == 'GET':
#        serializer = PostSerializer(posts, many=True) #converts Python to JSON for post with ID
#        return JsonResponse(serializer.data, safe = False) #returns