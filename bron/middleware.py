import logging
from .models import LogEntry

class APILoggingMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        # Process request
        response = self.get_response(request)

        # Log only API requests to avoid cluttering with admin/static files
        if request.path.startswith('/api/'):
            user = request.user.username if request.user.is_authenticated else "Anonymous"
            status_code = response.status_code
            method = request.method
            path = request.path

            level = 'INFO'
            if status_code >= 400:
                level = 'ERROR'
            
            message = f"User: {user} | Method: {method} | Path: {path} | Status: {status_code}"
            
            # Save to Database
            LogEntry.objects.create(
                level=level,
                message=message
            )

        return response
