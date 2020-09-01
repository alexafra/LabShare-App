from rest_framework import status, generics, mixins, permissions
from rest_framework.response import Response
from rest_framework.views import APIView
from tester.models import Post
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, logout, login
from tester.serializers import UserSerializer, PostSerializer, EmptySerializer, UserLoginSerializer, UserRegisterSerializer
from django.http import Http404
from tester.utils import get_and_authenticate_user, create_user_account

class UserRegister(APIView):
    def post(self, request, format = None):
        serializer = UserRegisterSerializer(data=request.data)
        if serializer.is_valid():
            user = create_user_account(**serializer.data)
            return Response(UserSerializer(user).data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_401_UNAUTHORIZED)

class UserLogin(APIView):
    def post(self, request, format = None):
        serializer = UserLoginSerializer(data=request.data)
        if serializer.is_valid():
            user = get_and_authenticate_user(**serializer.validated_data)
            login(request, user)
            return Response(request.user.username, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_401_UNAUTHORIZED)

class UserLogout(APIView):
    def post(self, request, format = None):
        logout(request)
        return Response(status=status.HTTP_200_OK)

class UserList(generics.GenericAPIView, mixins.ListModelMixin, mixins.CreateModelMixin):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    def get(self, request, *args, **kwargs):
        return self.list(request, *args, **kwargs)
    def post(self, request, *args, **kwargs):
        return self.create(request, *args, **kwargs)

#class UserList(APIView):
#    def get(self, request, format = None):
#        users = User.objects.all()
#        serializer = UserSerializer(users, many=True)
#        return Response(serializer.data)
#    def post(self, request, format = None):
#        serializer = UserSerializer(data=request.data)
#        if serializer.is_valid():
#            serializer.save()
#            return Response(serializer.data, status=status.HTTP_201_CREATED)
#        return Response(serializer.errors, status=status.HTTP_401_UNAUTHORIZED)

class UserDetail(generics.GenericAPIView, mixins.RetrieveModelMixin, mixins.UpdateModelMixin, mixins.DestroyModelMixin):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    def get(self, request, *args, **kwargs):
        return self.retrieve(request, *args, **kwargs)
    def post(self, request, *args, **kwargs):
        return self.update(request, *args, **kwargs)
    def delete(self, request, *args, **kwargs):
        return self.destroy(request, *args, **kwargs)

#class UserDetail(APIView):
#    def get_object(self, pk):
#        try:
#            return User.objects.get(pk=pk)
#        except User.DoesNotExist:
#            raise Http404
#    def get(self, request, pk, format = None):
#        user = self.get_object(pk)
#        serializer = UserSerializer(user) #converts Python to JSON
#        return Response(serializer.data)
#    def put(self, request, pk, format = None):
#        user = self.get_object(pk)
#        serializer = UserSerializer(user, data=request.data) #converts new Python back to JSON
#        if serializer.is_valid():
#            serializer.save()
#            return Response(serializer.data)
#        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
#    def delete(self, request, pk, format = None):
#        user = self.get_object(pk)
#        user.delete()
#        return Response(status=status.HTTP_204_NO_CONTENT)

class PostList(generics.GenericAPIView, mixins.ListModelMixin, mixins.CreateModelMixin):
    queryset = Post.objects.all()
    serializer_class = PostSerializer
    def get(self, request, *args, **kwargs):
        return self.list(request, *args, **kwargs)
    def post(self, request, *args, **kwargs):
        return self.create(request, *args, **kwargs)

#class PostList(APIView):
#    permission_classes = [permissions.IsAuthenticatedOrReadOnly]
#    def perform_create(self, serializer):
#        serializer.save(author = self.request.user)
#    def get(self, request, format = None):
#        posts = Post.objects.all()
#        serializer = PostSerializer(posts, many=True) #all posts from Python to JSON
#        return Response(serializer.data)
#    def post(self, request, format = None):
#        serializer = PostSerializer(data = request.data)
#        if serializer.is_valid():
#            serializer.save()
#            return Response(serializer.data, status=status.HTTP_201_CREATED)
#        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class PostDetail(generics.GenericAPIView, mixins.RetrieveModelMixin, mixins.UpdateModelMixin, mixins.DestroyModelMixin):
    queryset = Post.objects.all()
    serializer_class = PostSerializer
    def get(self, request, *args, **kwargs):
        return self.retrieve(request, *args, **kwargs)
    def put(self, request, *args, **kwargs):
        return self.update(request, *args, **kwargs)
    def delete(self, request, *args, **kwargs):
        return self.destroy(request, *args, **kwargs)

#class PostDetail(APIView):
#    permission_classes = [permissions.IsAuthenticatedOrReadOnly]
#    def get_object(self, pk):
#        try:
#            return Post.objects.get(pk=pk)
#        except Post.DoesNotExist:
#            raise Http404
#    def get(self, request, pk, format = None):
#        post = self.get_object(pk)
#        serializer = PostSerializer(post) #converts Python to JSON for post with ID
#        return Response(serializer.data) #returns
#    def put(self, request, pk, format = None):
#        post = self.get_object(pk)
#        serializer = PostSerializer(post, data=request.data)
#        if serializer.is_valid():
#            serializer.save()
#            return Response(serializer.data)
#        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
#    def delete(self, request, pk, format = None):
#        post = self.get_object(pk)
#        post.delete()
#        return Response(status=status.HTTP_204_NO_CONTENT)

class UserPostList(generics.GenericAPIView, mixins.ListModelMixin):
    def get_queryset(self):
        author = self.kwargs['author']
        return Post.objects.filter(author = author)
    serializer_class = PostSerializer
    def get(self, request, *args, **kwargs):
        return self.list(request, *args, **kwargs)

#class UserPostList(APIView):
#    def get_object(self, pk):
#        try:
#            return Post.objects.filter(author=pk)
#        except Post.DoesNotExist:
#            raise Http404
#    def get(self, request, pk, format = None):
#        posts = self.get_object(pk)
#        serializer = PostSerializer(posts, many= True)
#        return Response(serializer.data)


class Current(APIView):
    def get(self, request, format = None):
        return Response(request.user.username)