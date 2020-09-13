<h1>BackEnd API:</h1>

**user/<str:email>/preferences/**
Preferences of a user
get, put, *post*
{
  "id":,
  "owner":
}

**user/current/**
Email id of logged in user
get
"email"/"no user is currently logged in"

**user/<str:email>/feed/<int:id>/**
A single post
get, put, delete
{
  "id":,
  "title":,
  "content":,
  "date_created":,
  "author": {
              "id":,
              "email":,
              "profile":,
              "posts": [],
              "preferences":
            }
}

**user/<str:email>/feed/**
All posts
get, post
{
  {
    "id":,
    "title":,
    "content":,
    "date_created":
    "author": {
              "id":,
              "email":,
              "profile":,
              "posts": [],
              "preferences":
            }
  },
}

**user/<str:email>/posts/**
A users posts
get
{
  {
    "id":,
    "title":,
    "content":,
    "date_created":
    "author": {
              "id":,
              "email":,
              "profile":,
              "posts": [],
              "preferences":
            }
  },
}

**user/<str:email>/profile/**
A users profile
get, put, *post*
{
  "id":,
  "bio":,
  "dob":,
  "owner": {
              "id":,
              "email":,
              "profile":,
              "posts": [],
              "preferences":
            }
}

**register/**
post
{
  "email":,
  "password":,
  "first_name":,
  "last_name":
}

**login/**
post
{
  "email":,
  "password":,
}

**logout/**
post
{}
