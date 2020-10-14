from rest_framework import permissions
from LabShare.models import Post, Comment, UserProfile

class unauthenticated(permissions.BasePermission):
    message = 'User is already authenticated'
    
    def has_permission(self, request, view):
        return not request.user.is_authenticated

class userModifyPermission(permissions.BasePermission):
    message = 'User cannot modify another user'
    
    def has_permission(self, request, view):
        if request.method != 'GET':
            return request.user.id == view.kwargs['user_id'] or request.user.is_staff
        else:
            return True

class postModifyPermission(permissions.BasePermission):
    message = 'User cannot modify another users post'

    def has_permission(self, request, view):
        if request.method != 'GET':
            return request.user.id == Post.objects.get(pk = view.kwargs['post_id']).author.id or request.user.is_staff
        else:
            return True

class profileModifyPermission(permissions.BasePermission):
    message = 'User cannot modify another users profile'

    def has_permission(self, request, view):
        if request.method != 'GET':
            return request.user.id == UserProfile.objects.get(pk = view.kwargs['user_id']).owner.id or request.user.is_staff
        else:
            return True

class commentModifyPermission(permissions.BasePermission):
    message = 'User cannot modify another users profile'

    def has_permission(self, request, view):
        if request.method != 'GET':
            return request.user.id == Comment.objects.get(pk = view.kwargs['user_id']).author.id or request.user.is_staff
        else:
            return True

class isActive(permissions.BasePermission):
    message = 'User not active'

    def has_permission(self, request, view):
        return request.user.is_active

class isAdmin(permissions.BasePermission):
    message = 'User not admin'

    def has_permission(self, request, view):
        return request.user.is_staff