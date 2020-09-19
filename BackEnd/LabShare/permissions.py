from rest_framework import permissions

class unauthenticated(permissions.BasePermission):
    message = 'User is already authenticated'
    
    def has_permission(self, request, view):
        return not request.user.is_authenticated