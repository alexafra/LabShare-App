from rest_framework import status, generics, mixins, permissions
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.authtoken.models import Token
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from django.contrib.auth import authenticate, logout, login, get_user_model
from django.utils.decorators import method_decorator
from django.db.models import Value as V
from django.db.models.functions import Concat
from LabShare.utils import get_and_authenticate_user, create_user_account
from LabShare.models import Post, UserProfile, Comment
from LabShare.serializers import UserSerializer, UserLoginSerializer, UserRegisterSerializer, PostSerializer, UserProfileSerializer, CommentSerializer, UserSerializerAdmin
from LabShare.permissions import unauthenticated, userModifyPermission, postModifyPermission, profileModifyPermission, commentModifyPermission, isActive, isAdmin

User = get_user_model()

import json

class UserRegister(APIView):
    permission_classes = [unauthenticated]
    def post(self, request, format = None):
        serializer = UserRegisterSerializer(data=request.data)
        if serializer.is_valid():
            user = create_user_account(**serializer.data)
            return Response(UserSerializer(user).data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_401_UNAUTHORIZED)

class UserLogin(APIView):
    permission_classes = [unauthenticated]
    def post(self, request, format = None):
        serializer = UserLoginSerializer(data=request.data)
        if serializer.is_valid():
            user = get_and_authenticate_user(**serializer.validated_data)
            token, created = Token.objects.get_or_create(user = user)
            responseDict = {
                'token': token.key,
                'id': user.id,
                'is_staff': user.is_staff,
                'is_active': user.is_active
            }
            return Response(responseDict, status = status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_401_UNAUTHORIZED)

class UserLogout(APIView):
    permission_classes = [IsAuthenticated, isActive]
    def post(self, request, format = None):
        self.request.user.auth_token.delete()
        return Response(status=status.HTTP_200_OK)

class Users(APIView):
    permission_classes = [IsAuthenticated, isActive]
    def get(self, request):
        if 'search' in self.request.GET:
            queryset = User.objects.annotate(full_name = Concat('first_name', V(' '), 'last_name')).filter(full_name__icontains = self.request.GET.get('search')).order_by('last_name')[:15]
        else:
            queryset = User.objects.all().order_by('last_name')[:15]
        serializer = UserSerializer(queryset, many = True)
        return Response(serializer.data, status = status.HTTP_200_OK)

class SingleUser(APIView):
    permission_classes = [IsAuthenticated, userModifyPermission, isActive]
    def get(self, request, user_id):
        user = User.objects.get(pk = user_id)
        serializer = UserSerializer(user)
        return Response(serializer.data)
    def put(self, request, user_id):
        user = User.objects.get(pk = user_id)
        if user.is_staff:
            serializer = UserSerializerAdmin(user, data = request.data, partial = True)
        else:
            serializer = UserSerializer(user, data = request.data, partial = True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status = status.HTTP_200_OK)
        return Response(serializer.errors, status = status.HTTP_400_BAD_REQUEST)
    def delete(self, request, user_id):
        user = User.objects.get(pk = user_id)
        user.delete()
        return Response(status = status.HTTP_204_NO_CONTENT)

class Profile(generics.GenericAPIView, mixins.RetrieveModelMixin, mixins.UpdateModelMixin, mixins.DestroyModelMixin):
    permission_classes = [IsAuthenticated, profileModifyPermission, isActive]
    lookup_field = 'owner__id'
    lookup_url_kwarg = 'user_id'
    serializer_class = UserProfileSerializer
    queryset = UserProfile.objects.all()
    def get(self, request, *args, **kwargs):
        return self.retrieve(request, *args, **kwargs)
    def put(self, request, *args, **kwargs):
        return self.update(request, *args, **kwargs)
    def delete(self, request, *args, **kwargs):
        return self.destroy(request, *args, **kwargs)

class Comments(APIView):
    permission_classes = [IsAuthenticated, isActive]
    def get(self, request, **kwargs):
        queryset = Comment.objects.filter(post__id = self.kwargs['post_id']).order_by("-date_created")
        serializer = CommentSerializer(queryset, many = True)
        return Response(serializer.data, status = status.HTTP_200_OK)
    def post(self, request, **kwargs):
        serializer = CommentSerializer(data = request.data)
        if serializer.is_valid():
            serializer.save(author = self.request.user, post = Post.objects.get(id = self.kwargs['post_id']))
            return Response(serializer.data, status = status.HTTP_201_CREATED)
        return Response(serializer.errors, status = status.HTTP_400_BAD_REQUEST)
    

class SingleComment(generics.GenericAPIView, mixins.RetrieveModelMixin, mixins.UpdateModelMixin, mixins.DestroyModelMixin):
    permission_classes = [IsAuthenticated, commentModifyPermission, isActive]
    lookup_field = 'id'
    lookup_url_kwarg = 'comment_id'
    serializer_class = CommentSerializer
    queryset = Comment.objects.all()
    def get(self, request, *args, **kwargs):
        return self.retrieve(request, *args, **kwargs)
    def put(self, request, *args, **kwargs):
        return self.update(request, *args, **kwargs)
    def delete(self, request, *args, **kwargs):
        return self.destroy(request, *args, **kwargs)

class Feed(APIView):
    permission_classes = [IsAuthenticated, isActive]
    def get(self, request, **kwargs):
        if 'category' in self.request.GET:
            queryset = Post.objects.filter(category = self.request.GET.get('category')).order_by('-date_created')
        else:
            queryset = Post.objects.all().order_by('-date_created')
        serializer = PostSerializer(queryset, many = True)
        return Response(serializer.data, status = status.HTTP_200_OK)

class SinglePost(generics.GenericAPIView, mixins.RetrieveModelMixin, mixins.UpdateModelMixin, mixins.DestroyModelMixin):
    permission_classes = [IsAuthenticated, postModifyPermission, isActive]
    lookup_field = 'id'
    lookup_url_kwarg = 'post_id'
    serializer_class = PostSerializer
    queryset = Post.objects.all()
    def get(self, request, *args, **kwargs):
        return self.retrieve(request, *args, **kwargs)
    def put(self, request, *args, **kwargs):
        return self.update(request, *args, **kwargs)
    def delete(self, request, *args, **kwargs):
        return self.destroy(request, *args, **kwargs)

class UserPosts(APIView):
    permission_classes = [IsAuthenticated, isActive]
    def get(self, request, **kwargs):
        if 'category' in self.request.GET:
            queryset = Post.objects.filter(author__id = self.kwargs['user_id'], category = self.request.GET.get('category')).order_by("-date_created")
        else:
            queryset = Post.objects.filter(author__id = self.kwargs['user_id']).order_by("-date_created")
        serializer = PostSerializer(queryset, many = True)
        return Response(serializer.data, status = status.HTTP_200_OK)
    def post(self, request, **kwargs):
        serializer = PostSerializer(data = request.data)
        if serializer.is_valid():
            serializer.save(author = self.request.user)
            return Response(serializer.data, status = status.HTTP_201_CREATED)
        return Response(serializer.errors, status = status.HTTP_400_BAD_REQUEST)

class NonActive(generics.GenericAPIView, mixins.ListModelMixin):
    permission_classes = [isAdmin]
    serializer_class = UserSerializer
    def get_queryset(self):
        return User.objects.filter(is_active = False)
    def get(self, request, *args, **kwargs):
        return self.list(request, *args, **kwargs)

class Active(generics.GenericAPIView, mixins.ListModelMixin):
    permission_classes = [isAdmin]
    serializer_class = UserSerializer
    def get_queryset(self):
        return User.objects.filter(is_active = True)
    def get(self, request, *args, **kwargs):
        return self.list(request, *args, **kwargs)

##TEST FUNCTIONS
class Current(APIView):
    def get(self, request, format = None):
        if self.request.user.id != None:
            return Response(self.request.user.id)
        else:
            return Response("no user currently logged in")

class GetUserInfo(APIView):
    def get(self, request, user_id, format = None):
        try:
            user = User.objects.get(id = user_id)
        except:
            return Response("user does not exist")
        try:
            userToken = user.auth_token.key
        except:
            return Response("user does not have an associated token")
        responseDict = {
            'token': userToken,
            'email': user.email
        }
        try:
            return Response(responseDict)
        except:
            return Response("no token associated with this ID")
