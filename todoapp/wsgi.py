"""
WSGI config for todoapp project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/1.11/howto/deployment/wsgi/
"""

import os

from django.core.wsgi import get_wsgi_application

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "todoapp.settings")

application = get_wsgi_application()
# WhiteNoise is configured via middleware (see settings.MIDDLEWARE).
# For modern whitenoise versions the DjangoWhiteNoise helper was removed.
# Keep a plain WSGI application here.
