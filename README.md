<h1>BackEnd API:</h1>

**user/<int:id>/preferences/**<br>
Preferences of a user<br>
get, put, *post*<br>
{<br>
&emsp;"id":,<br>
&emsp;"owner":<br>
}<br>

**user/current/**<br>
Email id of logged in user<br>
get<br>
id/"no user is currently logged in"<br>

**user/feed/<int:id>/**<br>
A single post<br>
get, put, delete<br>
{<br>
&emsp;  "id":,<br>
&emsp;  "title":,<br>
&emsp;  "content":,<br>
&emsp;  "date_created":,<br>
&emsp;  "author": {<br>
&emsp;&emsp;              "id":,<br>
&emsp;&emsp;              "email":,<br>
&emsp;&emsp;              "profile":,<br>
&emsp;&emsp;              "posts": [],<br>
&emsp;&emsp;              "preferences":<br>
&emsp;            }<br>
}<br>

**user/feed/**<br>
All posts<br>
get, post<br>
{<br>
&emsp;  {<br>
&emsp;    "id":,<br>
&emsp;    "title":,<br>
&emsp;    "content":,<br>
&emsp;    "date_created":<br>
&emsp;    "author": {<br>
&emsp;&emsp;              "id":,<br>
&emsp;&emsp;              "email":,<br>
&emsp;&emsp;              "profile":,<br>
&emsp;&emsp;              "posts": [],<br>
&emsp;&emsp;              "preferences":<br>
&emsp;&emsp;            }<br>
&emsp;  },<br>
}<br>

**user/<int:id>/posts/**<br>
A users posts<br>
get<br>
{<br>
&emsp;  {<br>
&emsp;    "id":,<br>
&emsp;    "title":,<br>
&emsp;    "content":,<br>
&emsp;    "date_created":<br>
&emsp;    "author": {<br>
&emsp;&emsp;              "id":,<br>
&emsp;&emsp;              "email":,<br>
&emsp;&emsp;              "profile":,<br>
&emsp;&emsp;              "posts": [],<br>
&emsp;&emsp;              "preferences":<br>
&emsp;&emsp;            }<br>
&emsp;  },<br>
&emsp;}<br>

**user/<int:id>/profile/**<br>
A users profile<br>
get, put, *post*<br>
{<br>
&emsp;  "id":,<br>
&emsp;  "bio":,<br>
&emsp;  "dob":,<br>
&emsp;  "owner": {<br>
&emsp;&emsp;              "id":,<br>
&emsp;&emsp;              "email":,<br>
&emsp;&emsp;              "profile":,<br>
&emsp;&emsp;              "posts": [],<br>
&emsp;&emsp;              "preferences":<br>
&emsp;&emsp;            }<br>
&emsp;}<br>

**register/**<br>
post<br>
{<br>
&emsp;  "email":,<br>
&emsp;  "password":,<br>
&emsp;  "first_name":,<br>
&emsp;  "last_name":<br>
}<br>

**login/**<br>
post<br>
{<br>
&emsp;  "email":,<br>
&emsp;  "password":,<br>
}<br>

**logout/**<br>
post<br>
{}

<h1>Running Backend:</h1>
virtualenv x<br>
source x/bin/activate<br>
pip install django<br>
pip install djangorestframework<br>
pip install postgres<br>
cd (to backend directory)<br>
python3 manage.py makemigrations<br>
python3 manage.py migrate<br>
python3 manage.py runserver

Must get rid of AppTransportSecurity key before production!!!
