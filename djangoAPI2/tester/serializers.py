from rest_framework import serializers
from tester.models import User, Post, LANGUAGE_CHOICES, STYLE_CHOICES

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'name']

class PostSerializer(serializers.ModelSerializer):
    class Meta:
        model = Post
        fields = ['id', 'title', 'content', 'date_created', 'author']