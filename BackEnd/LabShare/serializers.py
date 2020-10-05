from rest_framework import serializers
from rest_framework.authtoken.models import Token
from django.contrib.auth import get_user_model
from django.contrib.auth import password_validation
from LabShare.models import Post, UserProfile, Comment
from datetime import datetime

User = get_user_model()

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'email', 'profile', 'first_name', 'last_name']

    #def to_representation(self, instance):
    #    response = super().to_representation(instance)
    #    response['image'] = UserProfileSerializer(instance.profile).data['image']
    #    return response

    def get_auth_token(self, obj):
        token = Token.objects.create(user=obj)
        return token.key

class UserLoginSerializer(serializers.Serializer):
    email = serializers.EmailField(max_length=300, required=True)
    password = serializers.CharField(required=True, write_only=True)

class UserRegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['email', 'password', 'first_name', 'last_name']

    def validate_email(self, value):
        user = User.objects.filter(email=value)
        if user:
            raise serializers.ValidationError('email already taken')
        return value
    def validate_password(self, value):
        password_validation.validate_password(value)
        return value

class PostSerializer(serializers.ModelSerializer):
    date_created = serializers.DateTimeField(default = None, required = False, format="%Y-%m-%dT%H:%M:%SZ")
    category = serializers.CharField(allow_blank = True)
    class Meta:
        model = Post
        fields = ['id', 'title', 'content', 'date_created', 'category']

    def to_representation(self, instance):
        response = super().to_representation(instance)
        response['author'] = UserSerializer(instance.author).data
        return response
##same

class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = ['id', 'bio', 'dob', 'occupation', 'employer']
        # fields = ['id', 'bio', 'dob', 'occupation', 'employer', 'image', 'owner']

    def to_representation(self, instance):
        response = super().to_representation(instance)
        response['owner'] = UserSerializer(instance.owner).data
        return response
##same

class CommentSerializer(serializers.ModelSerializer):
    date_created = serializers.DateTimeField(default = None, required = False, format="%Y-%m-%dT%H:%M:%SZ")
    class Meta:
        model = Comment
        fields = ['id', 'date_created', 'post', 'content']

    def to_representation(self, instance):
        response = super().to_representation(instance)
        response['author'] = UserSerializer(instance.author).data
        return response
