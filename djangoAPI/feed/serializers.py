from rest_framework import serializers
from .models import Users, Posts

class UsersSerializer(serializers.ModelSerializer):
    class Meta:
        model = Users
        fields = ('id', 'name')

class PostsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Posts
        fields = ('id', 'title', 'content', 'date_posted', 'author')