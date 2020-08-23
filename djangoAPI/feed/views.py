from django.shortcuts import render
from rest_framework import viewsets
from .models import Users
from .serializers import UsersSerializer

class UsersView(viewsets.ModelViewSet):
    queryset = Users.objects.all()
    serializer_class = UsersSerializer