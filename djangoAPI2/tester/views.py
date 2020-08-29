from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from tester.models import User, Post
from tester.serializers import UserSerializer, PostSerializer
from django.http import Http404

class UserList(APIView):
    def get(self, request, format = None):
        users = User.objects.all()
        serializer = UserSerializer(users, many=True)
        return Response(serializer.data)
    def post(self, request, format = None):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class UserDetail(APIView):
    def get_object(self, pk):
        try:
            return User.objects.get(pk=pk)
        except User.DoesNotExist:
            raise Http404
    def get(self, request, pk, format = None):
        user = self.get_object(pk)
        serializer = UserSerializer(user) #converts Python to JSON
        return Response(serializer.data)
    def put(self, request, pk, format = None):
        user = self.get_object(pk)
        serializer = UserSerializer(user, data=request.data) #converts new Python back to JSON
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    def delete(self, request, pk, format = None):
        user = self.get_object(pk)
        user.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

class PostList(APIView):
    def get(self, request, format = None):
        posts = Post.objects.all()
        serializer = PostSerializer(posts, many=True) #all posts from Python to JSON
        return Response(serializer.data)
    def post(self, request, format = None):
        serializer = PostSerializer(data = request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class PostDetail(APIView):
    def get_object(self, pk):
        try:
            return Post.objects.get(pk=pk)
        except Post.DoesNotExist:
            raise Http404
    def get(self, request, pk, format = None):
        post = self.get_object(pk)
        serializer = PostSerializer(post) #converts Python to JSON for post with ID
        return Response(serializer.data) #returns
    def put(self, request, pk, format = None):
        post = self.get_object(pk)
        serializer = PostSerializer(post, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    def delete(self, request, pk, format = None):
        post = self.get_object(pk)
        post.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

class UserPostList(APIView):
    def get_object(self, pk):
        try:
            return Post.objects.filter(author=pk)
        except Post.DoesNotExist:
            raise Http404
    def get(self, request, pk, format = None):
        posts = self.get_object(pk)
        serializer = PostSerializer(posts, many= True)
        return Response(serializer.data)


