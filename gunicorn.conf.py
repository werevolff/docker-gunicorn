import multiprocessing
import environ

env = environ.Env(
    GUNICORN_RELOAD=(bool, True),
    GUNICORN_LOG_DIR=(str, ''),
    PROJECT_USER=(str, ''),
    GUNICORN_WORKER_CLASS=(str, ''),
    GUNICORN_BIND=(str, ''),
)

workers = multiprocessing.cpu_count() + int(multiprocessing.cpu_count() / 2)
reload = env('GUNICORN_RELOAD')

timeout = 700
accesslog = env('GUNICORN_LOG_DIR') + '/server_access.log'
errorlog = env('GUNICORN_LOG_DIR') + '/server_error.log'
user = env('PROJECT_USER')
umask = 755
worker_class = env('GUNICORN_WORKER_CLASS')
worker_connections = 10000
bind = env('GUNICORN_BIND')
