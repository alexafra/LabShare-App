from django.shortcuts import render

posts = [
    {
        'author': 'Greg',
        'title': 'Ay I need a thermometer',
        'content': 'Getting hot',
        'date_posted': 'August 14, 2020'
    },
    {
        'author': 'Tom',
        'title': 'Anyone have a beaker?',
        'content': 'Need to store my chemicals',
        'date_posted': 'August 13, 2020'
    }
]

# Create your views here.
def home(request):
    context = {
        'posts': posts
    }
    return render(request, 'feed/home.html', context)

def about(request):
    return render(request, 'feed/about.html')