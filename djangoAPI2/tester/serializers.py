from rest_framework import serializers
from rest_framework.authtoken.models import Token
from tester.models import Post, LANGUAGE_CHOICES, STYLE_CHOICES
from django.contrib.auth.models import User

from django.contrib.auth import password_validation

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'posts']
    
    def get_auth_token(self, obj):
        token = Token.objects.create(user=obj)
        return token.key

class PostSerializer(serializers.ModelSerializer):
    class Meta:
        model = Post
        author = serializers.ReadOnlyField(source='author.username')
        fields = ['id', 'title', 'content', 'date_created', 'author']

class UserLoginSerializer(serializers.Serializer):
    username = serializers.CharField(max_length=300, required=True)
    password = serializers.CharField(required=True, write_only=True)

class UserRegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['username', 'password', 'email', 'first_name', 'last_name']
    
    def validate_username(self, value):
        user = User.objects.filter(username=value)
        if user:
            raise serializers.ValidationError('username already taken')
        return value
    def validate_password(self, value):
        password_validation.validate_password(value)
        return value