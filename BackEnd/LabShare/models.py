from django.db import models
from django.contrib.auth.base_user import BaseUserManager
from django.contrib.auth.models import AbstractUser
from django.contrib.auth import get_user_model
from BackEnd import settings
from datetime import datetime

class CustomUserManager(BaseUserManager):
    def create_user(self, email, password, **extra_fields):
        if not email:
            raise ValueError('Must include Email')
        email = self.normalize_email(email)
        user = self.model(email = email, **extra_fields)
        user.set_password(password)
        user.save()
        return user
    def create_superuser(self, email, password, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        extra_fields.setdefault('is_active', True)
        
        if extra_fields.get('is_staff') is not True:
            raise ValueError('Superuser must have is_staff=True.')
        if extra_fields.get('is_superuser') is not True:
            raise ValueError('Superuser must have is_superuser=True.')
        return self.create_user(email, password, **extra_fields)

class CustomUser(AbstractUser):
    username = None
    email = models.EmailField('email address', unique = True)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    objects = CustomUserManager()

    def __str__(self):
        return self.email

class Post(models.Model):
    date_created = models.DateTimeField(auto_now_add= True)
    title = models.CharField(max_length = 80)
    content = models.TextField()
    author = models.ForeignKey(settings.AUTH_USER_MODEL, related_name = 'posts', on_delete=models.CASCADE)

    def author_first(self):
        return self.author.first_name

    def author_last(self):
        return self.author.last_name

    def __str__(self):
        return self.title

class UserPreferences(models.Model):
    owner = models.OneToOneField(settings.AUTH_USER_MODEL, related_name = 'preferences', on_delete = models.CASCADE)

    def __str__(self):
        return self.owner.email

class UserProfile(models.Model):
    owner = models.OneToOneField(settings.AUTH_USER_MODEL, related_name = 'profile', on_delete = models.CASCADE)
    bio = models.TextField()
    dob = models.DateField(default = datetime.now(), blank = True)

    def __str__(self):
        return self.owner.email