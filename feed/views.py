from django.shortcuts import render
from django.http import HttpResponse
from django.views.generic import ListView, DetailView, CreateView, UpdateView, DeleteView
from .models import Users, Posts
from django.urls import reverse_lazy

class PostListView(ListView):
    model = Posts
    ordering = ['-date_posted']
#comment
class PostCreateView(CreateView):
    model = Posts
    fields = ['title', 'content', 'author']
    success_url = reverse_lazy('feed-home')

class PostDetailView(DetailView):
    model = Posts

class PostDeleteView(DeleteView):
    model = Posts
    success_url = reverse_lazy('feed-home')

class PostUpdateView(UpdateView):
    model = Posts
    fields = ['title', 'content']
    success_url = reverse_lazy('feed-home')

class UserCreateView(CreateView):
    model = Users
    fields = ['name']
    success_url = reverse_lazy('feed-home')

class UserDeleteView(DeleteView):
    model = Users
    success_url = reverse_lazy('feed-home')

def UserPosts(request, author):
    context = {
        'posts': Posts.objects.filter(author = author)
    }
    return render(request, 'feed/user_posts_list.html', context)


