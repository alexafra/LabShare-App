from django.db import models

class Post(models.Model):
    name = models.CharField(max_length = 50)
    description = models.CharField(max_length = 200)

    def __str__(self):
        return self.name

class User(models.Model):
    name = models.CharField(max_length = 50)
    post = models.ForeignKey(Post, on_delete = models.CASCADE)
    datetime = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name
    
class Group(models.Model):
    name = models.CharField(max_length = 50)
    users = models.ManyToManyField(User)

    def __str__(self):
        return self.name