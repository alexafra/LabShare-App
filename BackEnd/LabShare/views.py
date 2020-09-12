from rest_framework import status, generics, mixins, permissions
from rest_framework.response import Response
from rest_framework.views import APIView
from django.contrib.auth import authenticate, logout, login, get_user_model
from LabShare.utils import get_and_authenticate_user, create_user_account
from LabShare.models import Post, UserPreferences, UserProfile
from LabShare.serializers import UserSerializer, UserLoginSerializer, UserRegisterSerializer, PostSerializer, UserPreferencesSerializer, UserProfileSerializer

User = get_user_model()

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
            return Response(request.user.email, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_401_UNAUTHORIZED)

class UserLogout(APIView):
    def post(self, request, format = None):
        logout(request)
        return Response(status=status.HTTP_200_OK)

class Profile(generics.GenericAPIView, mixins.RetrieveModelMixin, mixins.UpdateModelMixin):
    lookup_field = 'owner__email'
    lookup_url_kwarg = 'email'
    serializer_class = UserProfileSerializer
    queryset = UserProfile.objects.all()
    def get(self, request, *args, **kwargs):
        return self.retrieve(request, *args, **kwargs)
    def put(self, request, *args, **kwargs):
        return self.update(request, *args, **kwargs)

class UserPosts(generics.GenericAPIView, mixins.ListModelMixin):
    lookup_field = 'author__email'
    lookup_url_kwarg = 'email'
    serializer_class = PostSerializer
    queryset = Post.objects.all()
    def get(self, request, *args, **kwargs):
        return self.list(request, *args, **kwargs)

class Feed(generics.GenericAPIView, mixins.ListModelMixin):
    queryset = Post.objects.all()
    serializer_class = PostSerializer
    def get(self, request, *args, **kwargs):
        return self.list(request, *args, **kwargs)
    def post(self, request, *args, **kwargs):
        return self.list(request, *args, **kwargs)

class SinglePost(generics.GenericAPIView, mixins.RetrieveModelMixin, mixins.UpdateModelMixin, mixins.DestroyModelMixin):
    lookup_field = 'id'
    lookup_url_kwarg = 'id'
    serializer_class = PostSerializer
    queryset = Post.objects.all()
    def get(self, request, *args, **kwargs):
        return self.retrieve(request, *args, **kwargs)
    def put(self, request, *args, **kwargs):
        return self.update(request, *args, **kwargs)
    def delete(self, request, *args, **kwargs):
        return self.destroy(request, *args, **kwargs)

class Current(APIView):
    def get(self, request, format = None):
        try:
            return Response(request.user.email)
        except:
            return Response("no user currently logged in")

class Preferences(generics.GenericAPIView, mixins.RetrieveModelMixin, mixins.CreateModelMixin, mixins.UpdateModelMixin):
    lookup_field = 'owner__email'
    lookup_url_kwarg = 'email'
    serializer_class = UserPreferencesSerializer
    queryset = UserPreferences.objects.all()
    def get(self, request, *args, **kwargs):
        return self.retrieve(request, *args, **kwargs)
    def put(self, request, *args, **kwargs):
        return self.update(request, *args, **kwargs)
    def post(self, request, *args, **kwargs):
        return self.create(request, *args, **kwargs)

##TESTING

#class UserList(generics.GenericAPIView, mixins.ListModelMixin, mixins.CreateModelMixin):
#    queryset = User.objects.all()
#    serializer_class = UserSerializer
#    def get(self, request, *args, **kwargs):
#        return self.list(request, *args, **kwargs)

#class UserDetail(generics.GenericAPIView, mixins.RetrieveModelMixin, mixins.UpdateModelMixin, mixins.DestroyModelMixin):
#    queryset = User.objects.all()
#    serializer_class = UserSerializer
#    def get(self, request, *args, **kwargs):
#        return self.retrieve(request, *args, **kwargs)
#    def post(self, request, *args, **kwargs):
#        return self.update(request, *args, **kwargs)
#    def delete(self, request, *args, **kwargs):
#        return self.destroy(request, *args, **kwargs)

#class Current(APIView):
#    def get(self, request, format = None):
#        return Response(request.user.email)

#class PostList(generics.GenericAPIView, mixins.ListModelMixin, mixins.CreateModelMixin):
#    queryset = Post.objects.all()
#    serializer_class = PostSerializer
#    def perform_create(self, serializer):
#        serializer.save(author = self.request.user)
#    def get(self, request, *args, **kwargs):
#        return self.list(request, *args, **kwargs)
#    def post(self, request, *args, **kwargs):
#        return self.create(request, *args, **kwargs)

#class PostDetail(generics.GenericAPIView, mixins.UpdateModelMixin, mixins.DestroyModelMixin):
#    queryset = Post.objects.all()
#    serializer_class = PostSerializer
#    def get(self, request, *args, **kwargs):
#        return self.retrieve(request, *args, **kwargs)
#    def put(self, request, *args, **kwargs):
#        return self.update(request, *args, **kwargs)
#    def delete(self, request, *args, **kwargs):
#        return self.destroy(request, *args, **kwargs)

#class UserPostList(generics.GenericAPIView, mixins.ListModelMixin):
#    def get_queryset(self):
#        author = self.kwargs['author']
#        return Post.objects.filter(author = author)
#    serializer_class = PostSerializer
#    def get(self, request, *args, **kwargs):
#        return self.list(request, *args, **kwargs)

#class Preferences(generics.GenericAPIView, mixins.ListModelMixin, mixins.CreateModelMixin):
#    queryset = UserPreferences.objects.all()
#    serializer_class = UserPreferencesSerializer
#    def get(self, request, *args, **kwargs):
#        return self.list(request, *args, **kwargs)
#    def post(self, request, *args, **kwargs):
#        return self.create(request, *args, **kwargs)

#class Profile(generics.GenericAPIView, mixins.ListModelMixin, mixins.CreateModelMixin):
#    queryset = UserProfile.objects.all()
#    serializer_class = UserProfileSerializer
#    def get(self, request, *args, **kwargs):
#        return self.list(request, *args, **kwargs)
#    def post(self, request, *args, **kwargs):
#        return self.create(request, *args, **kwargs)