from rest_framework import status, generics, mixins, permissions
from rest_framework.response import Response
from rest_framework.views import APIView
from tester.models import Post
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, logout, login
from tester.serializers import UserSerializer, PostSerializer, UserLoginSerializer, UserRegisterSerializer
<<<<<<< Updated upstream
from django.http import Http404
=======
>>>>>>> Stashed changes
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

class UserDetail(generics.GenericAPIView, mixins.RetrieveModelMixin, mixins.UpdateModelMixin, mixins.DestroyModelMixin):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    def get(self, request, *args, **kwargs):
        return self.retrieve(request, *args, **kwargs)
    def post(self, request, *args, **kwargs):
        return self.update(request, *args, **kwargs)
    def delete(self, request, *args, **kwargs):
        return self.destroy(request, *args, **kwargs)

class PostList(generics.GenericAPIView, mixins.ListModelMixin, mixins.CreateModelMixin):
    queryset = Post.objects.all()
    serializer_class = PostSerializer
    def perform_create(self, serializer):
            serializer.save(author = self.request.user)
    def get(self, request, *args, **kwargs):
        return self.list(request, *args, **kwargs)
    def post(self, request, *args, **kwargs):
        return self.create(request, *args, **kwargs)

class PostDetail(generics.GenericAPIView, mixins.UpdateModelMixin, mixins.DestroyModelMixin):
    queryset = Post.objects.all()
    serializer_class = PostSerializer
    #def get(self, request, *args, **kwargs):
    #    return self.retrieve(request, *args, *kwargs)
    def get(self, request, *args, **kwargs):
        pk = self.kwargs['pk']
        singlePost = Post.objects.get(pk = pk)
        postID = singlePost.id
        title = singlePost.title
        content = singlePost.content
        date_created = singlePost.date_created
        author = singlePost.author
        authorID = author.id
        authorName = author.username
        jsonResponse = {
            "id": postID,
            "title": title,
            "content": content,
            "date_created": date_created,
            "author": authorID,
            "authorName": authorName
        }
        return Response(jsonResponse)
    def put(self, request, *args, **kwargs):
        return self.update(request, *args, **kwargs)
    def delete(self, request, *args, **kwargs):
        return self.destroy(request, *args, **kwargs)

class UserPostList(generics.GenericAPIView, mixins.ListModelMixin):
    def get_queryset(self):
        author = self.kwargs['author']
        return Post.objects.filter(author = author)
    serializer_class = PostSerializer
    def get(self, request, *args, **kwargs):
        return self.list(request, *args, **kwargs)

class Current(APIView):
    def get(self, request, format = None):
        return Response(request.user.username)