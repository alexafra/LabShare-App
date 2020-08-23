from django.db import models
from django.utils import timezone

class Users(models.Model):
    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name

class Posts(models.Model):
    title = models.CharField(max_length=100)
    content = models.TextField()
    date_posted = models.DateTimeField(default=timezone.now)
    author = models.ForeignKey(Users, on_delete=models.CASCADE)

    class Meta:
        ordering = ['-date_posted']

    def __str__(self):
        return self.name