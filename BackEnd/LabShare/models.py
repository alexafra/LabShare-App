from django.db import models
from django.contrib.auth.base_user import BaseUserManager
from django.contrib.auth.models import AbstractUser
from django.db.models.signals import post_save
from django.contrib.auth import get_user_model
from rest_framework.authtoken.models import Token
from django.dispatch import receiver
from BackEnd import settings
from datetime import datetime
from django.dispatch import receiver
from django.urls import reverse
from django_rest_passwordreset.signals import reset_password_token_created
from django.core.mail import send_mail 

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
    first_name = models.CharField(max_length = 32, blank = False, null = False)
    last_name = models.CharField(max_length = 160, blank = False, null = False)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    objects = CustomUserManager()

    def __str__(self):
        return self.email

@receiver(post_save, sender = settings.AUTH_USER_MODEL)
def create_auth_token(sender, instance=None, created=False, **kwargs):
    if created:
        Token.objects.create(user=instance)

class Categories(models.Model):
    category_name = models.CharField(max_length = 80)

class Post(models.Model):
    date_created = models.DateTimeField(auto_now_add= True)
    title = models.CharField(max_length = 80)
    content = models.TextField()
    author = models.ForeignKey(to=settings.AUTH_USER_MODEL, related_name = 'posts', on_delete=models.CASCADE)
    category = models.ForeignKey(Categories, related_name = 'posts', on_delete = models.CASCADE, blank = True, null = True)

    def author_first(self):
        return self.author.first_name

    def author_last(self):
        return self.author.last_name

    def __str__(self):
        return self.title

class UserProfile(models.Model):
    owner = models.OneToOneField(settings.AUTH_USER_MODEL, related_name = 'profile', on_delete = models.CASCADE)
    bio = models.TextField(blank = True, default = "")
    dob = models.DateField(default = '2000-01-01', blank = True)
    occupation = models.TextField(blank = True, default = "")
    employer = models.TextField(blank = True, default = "")
    image = models.ImageField(upload_to = 'profile_image', blank = True, default = 'avatar.jpg')

    def __str__(self):
        return self.owner.email

class Comment(models.Model):
    date_created = models.DateTimeField(auto_now_add= True)
    post = models.ForeignKey(Post, default = 12, related_name = 'comments', on_delete=models.CASCADE)
    author = models.ForeignKey(to=settings.AUTH_USER_MODEL, related_name = 'comments', on_delete = models.CASCADE)
    content = models.TextField(blank = True, default = "")

@receiver(post_save, sender = settings.AUTH_USER_MODEL)
def create_profile(sender, instance=None, created=False, **kwargs):
    if created:
        profile = UserProfile.objects.create(owner=instance)

@receiver(reset_password_token_created)
def password_reset_token_created(sender, instance, reset_password_token, *args, **kwargs):

    email_plaintext_message = "{}?token={}".format(reverse('password_reset:reset-password-request'), reset_password_token.key)

    send_mail(
        # title:
        "Password Reset for {title}".format(title="Some website title"),
        # message:
        email_plaintext_message,
        # from:
        "noreply@somehost.local",
        # to:
        [reset_password_token.user.email]
    )
