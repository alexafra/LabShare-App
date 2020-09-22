from rest_framework import status, generics, mixins, permissions
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.authtoken.models import Token
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from django.contrib.auth import authenticate, logout, login, get_user_model
from django.utils.decorators import method_decorator
from LabShare.utils import get_and_authenticate_user, create_user_account
from LabShare.models import Post, Categories, UserProfile
from LabShare.serializers import UserSerializer, UserLoginSerializer, UserRegisterSerializer, PostSerializer, CategoriesSerializer, UserProfileSerializer
from LabShare.permissions import unauthenticated

User = get_user_model()

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
                'id': user.id
            }
            return Response(responseDict, status = status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_401_UNAUTHORIZED)

class UserLogout(APIView):
    permission_classes = [IsAuthenticated]
    def post(self, request, format = None):
        self.request.user.auth_token.delete()
        return Response(status=status.HTTP_200_OK)

class SingleUser(generics.GenericAPIView, mixins.RetrieveModelMixin, mixins.UpdateModelMixin, mixins.DestroyModelMixin):
    permission_classes = [IsAuthenticated]
    lookup_field = 'id'
    lookup_url_kwarg = 'user_id'
    serializer_class = UserSerializer
    queryset = User.objects.all()
    def get(self, request, *args, **kwargs):
        return self.retrieve(request, *args, **kwargs)
    def put(self, request, *args, **kwargs):
        return self.update(request, *args, **kwargs)
    def delete(self, request, *args, **kwargs):
        return self.destroy(request, *args, **kwargs) 

class Profile(generics.GenericAPIView, mixins.RetrieveModelMixin, mixins.UpdateModelMixin):
    permission_classes = [IsAuthenticated]
    lookup_field = 'owner__id'
    lookup_url_kwarg = 'user_id'
    serializer_class = UserProfileSerializer
    queryset = UserProfile.objects.all()
    def get(self, request, *args, **kwargs):
        return self.retrieve(request, *args, **kwargs)
    def put(self, request, *args, **kwargs):
        return self.update(request, *args, **kwargs)
    def post(self, request, *args, **kwargs):
        return self.create(request, *args, **kwargs)
    def delete(self, request, *args, **kwargs):
        return self.destroy(request, *args, **kwargs)

class UserPosts(generics.GenericAPIView, mixins.ListModelMixin):
    permission_classes = [IsAuthenticated]
    serializer_class = PostSerializer
    def get_queryset(self):
        return Post.objects.filter(author__id = self.kwargs['user_id']).order_by("-date_created")
    def get(self, request, *args, **kwargs):
        return self.list(request, *args, **kwargs)

class Posts(generics.GenericAPIView, mixins.ListModelMixin, mixins.CreateModelMixin):
    permission_classes = [IsAuthenticated]
    queryset = Post.objects.all().order_by('-date_created')
    serializer_class = PostSerializer
    def perform_create(self, serializer) -> None:
        serializer.save(author = self.request.user)
    def get(self, request, *args, **kwargs):
        return self.list(request, *args, **kwargs)
    def post(self, request, *args, **kwargs):
        return self.create(request, *args, **kwargs)

class SinglePost(generics.GenericAPIView, mixins.RetrieveModelMixin, mixins.UpdateModelMixin, mixins.DestroyModelMixin):
    permission_classes = [IsAuthenticated]
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

class AvailableCategories(generics.GenericAPIView, mixins.ListModelMixin, mixins.CreateModelMixin):
    permission_classes = [IsAuthenticated]
    queryset = Categories.objects.all()
    serializer_class = CategoriesSerializer
    def get(self, request, *args, **kwargs):
        return self.list(request, *args, **kwargs)
    def post(self, request, *args, **kwargs):
        return self.create(request, *args, **kwargs)

class SingleCategory(generics.GenericAPIView, mixins.RetrieveModelMixin, mixins.UpdateModelMixin, mixins.DestroyModelMixin):
    permission_classes = [IsAuthenticated]
    lookup_field = 'id'
    lookup_url_kwarg = 'id'
    serializer_class = CategoriesSerializer
    queryset = Categories.objects.all()
    def get(self, request, *args, **kwargs):
        return self.retrieve(request, *args, **kwargs)
    def put(self, request, *args, **kwargs):
        return self.update(request, *args, **kwargs)
    def delete(self, request, *args, **kwargs):
        return self.destroy(request, *args, **kwargs)

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
