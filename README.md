<h1>BackEnd API:</h1>

**user/<str:email>/preferences/**<br>
Preferences of a user<br>
get, put, *post*<br>
{<br>
  "id":,<br>
  "owner":<br>
}<br>

**user/current/**<br>
Email id of logged in user<br>
get<br>
"email"/"no user is currently logged in"<br>

**user/<str:email>/feed/<int:id>/**<br>
A single post<br>
get, put, delete<br>

  "id":,<br>
  "title":,<br>
  "content":,<br>
  "date_created":,<br>
  "author": {<br>
              "id":,<br>
              "email":,<br>
              "profile":,<br>
              "posts": [],<br>
              "preferences":<br>
            }<br>
}<br>

**user/<str:email>/feed/**<br>
All posts<br>
get, post<br>
{<br>
  {<br>
    "id":,<br>
    "title":,<br>
    "content":,<br>
    "date_created":<br>
    "author": {<br>
              "id":,<br>
              "email":,<br>
              "profile":,<br>
              "posts": [],<br>
              "preferences":<br>
            }<br>
  },<br>
}<br>

**user/<str:email>/posts/**<br>
A users posts<br>
get<br>
{<br>
  {<br>
    "id":,<br>
    "title":,<br>
    "content":,<br>
    "date_created":<br>
    "author": {<br>
              "id":,<br>
              "email":,<br>
              "profile":,<br>
              "posts": [],<br>
              "preferences":<br>
            }<br>
  },<br>
}<br>

**user/<str:email>/profile/**<br>
A users profile<br>
get, put, *post*<br>
{<br>
  "id":,<br>
  "bio":,<br>
  "dob":,<br>
  "owner": {<br>
              "id":,<br>
              "email":,<br>
              "profile":,<br>
              "posts": [],<br>
              "preferences":<br>
            }<br>
}<br>

**register/**<br>
post<br>
{<br>
  "email":,<br>
  "password":,<br>
  "first_name":,<br>
  "last_name":<br>
}<br>

**login/**<br>
post<br>
{<br>
  "email":,<br>
  "password":,<br>
}<br>

**logout/**<br>
post<br>
{}
