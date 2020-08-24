import requests

headers = []
headers['Authorization'] = 'Bearer '

r = requests.get('http://127.0.0.1:8000/users/', headers = headers)