# Description
This image builds with werevolff/pyenv, based on debian:bullseye-20190708

Image contains Gunicorn for django project.

# Installation
1. Create django project
2. Set environment variable $PROJECT_SRC to project's root
3. Add django-environ==0.4.5 to requirements.txt
4. Up container

# Variables
- GUNICORN_SUFFIX='[gevent]' (if you want to install original gunicorn, just set to '')
- GUNICORN_VERSION='19.9.0'
- PROJECT_USER='gunicorn'
- GUNICORN_HOMEDIR=/home/$PROJECT_USER
- GUNICORN_PROJECT_ROOT='/var/www/'
- GUNICORN_LOG_DIR=/home/$PROJECT_USER/logs
- PROJECT_SRC='./project'
- GUNICORN_WORKER_CLASS='gunicorn.workers.ggevent.GeventWorker' (set it, according to GUNICORN_SUFFIX)
- GUNICORN_BIND='0.0.0.0:8080'
- GUNICORN_PROJECT_NAME='test_project' (name of the django package, contains wsgi.py)
- GUNICORN_APPLICATION='application'
