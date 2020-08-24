from django.db import models

from pygments.lexers import get_all_lexers
from pygments.styles import get_all_styles

LEXERS = [item for item in get_all_lexers() if item[1]]
LANGUAGE_CHOICES = sorted([(item[1][0], item[0]) for item in LEXERS])
STYLE_CHOICES = sorted([(item, item) for item in get_all_styles()])

class User(models.Model):
    date_created = models.DateTimeField(auto_now_add= True)
    name = models.CharField(max_length = 56)

    class Meta:
        ordering = ['-date_created']
    
    def __str__(self):
        return self.name

class Post(models.Model):
    date_created = models.DateTimeField(auto_now_add= True)
    title = models.CharField(max_length = 80)
    content = models.TextField()
    author = models.ForeignKey(User, on_delete=models.CASCADE)
    
    def __str__(self):
        return self.title
