FROM werevolff/pyenv

ARG GUNICORN_SUFFIX='[gevent]'
ENV GUNICORN_SUFFIX=$GUNICORN_SUFFIX

ARG GUNICORN_VERSION='19.9.0'
ENV GUNICORN_VERSION=$GUNICORN_VERSION

ARG PROJECT_USER='gunicorn'
ENV PROJECT_USER=$PROJECT_USER

ARG GUNICORN_HOMEDIR=/home/$PROJECT_USER
ENV GUNICORN_HOMEDIR=$GUNICORN_HOMEDIR

ARG GUNICORN_PROJECT_ROOT='/var/www/'
ENV GUNICORN_PROJECT_ROOT=$GUNICORN_PROJECT_ROOT

ARG GUNICORN_LOG_DIR=/home/$PROJECT_USER/logs
ENV GUNICORN_LOG_DIR=$GUNICORN_LOG_DIR

ARG PROJECT_SRC='./project'
ENV PROJECT_SRC=$PROJECT_SRC

ARG GUNICORN_WORKER_CLASS='gunicorn.workers.ggevent.GeventWorker'
ENV GUNICORN_WORKER_CLASS=$GUNICORN_WORKER_CLASS

ARG GUNICORN_BIND='0.0.0.0:8080'
ENV GUNICORN_BIND=$GUNICORN_BIND

ARG GUNICORN_PROJECT_NAME='test_project'
ENV GUNICORN_PROJECT_NAME=$GUNICORN_PROJECT_NAME

ARG GUNICORN_APPLICATION='application'
ENV GUNICORN_APPLICATION=$GUNICORN_APPLICATION

# Create user
RUN groupadd $PROJECT_USER && useradd --create-home --home-dir $GUNICORN_HOMEDIR -g $PROJECT_USER $PROJECT_USER

# Create logs dir
RUN mkdir -p $GUNICORN_LOG_DIR
RUN chown -hR $PROJECT_USER $GUNICORN_LOG_DIR

# Create workdir
RUN mkdir -p $GUNICORN_PROJECT_ROOT
RUN chown -hR $PROJECT_USER $GUNICORN_PROJECT_ROOT

# Create Volume
VOLUME $PROJECT_SRC $GUNICORN_PROJECT_ROOT
ADD $PROJECT_SRC $GUNICORN_PROJECT_ROOT
ENV PYTHONPATH $PYTHONPATH:$GUNICORN_PROJECT_ROOT

# Install requirements
RUN pip install gunicorn$GUNICORN_SUFFIX==$GUNICORN_VERSION
RUN pip install -r $GUNICORN_PROJECT_ROOT/requirements.txt

# Copy config file
COPY gunicorn.conf.py $GUNICORN_HOMEDIR/gunicorn.conf.py

# Expose
EXPOSE 8080

# Chdir
WORKDIR $GUNICORN_PROJECT_ROOT

# CMD
CMD gunicorn $GUNICORN_PROJECT_NAME.wsgi:$GUNICORN_APPLICATION -c $GUNICORN_HOMEDIR/gunicorn.conf.py