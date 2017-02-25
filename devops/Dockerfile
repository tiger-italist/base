FROM ubuntu:14.04

WORKDIR /tmp/
RUN sudo apt-get update

# install vim, python and pip
RUN sudo apt-get -y install build-essential checkinstall libreadline-gplv2-dev libncursesw5-dev \
    libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev wget curl vim && \
    wget https://www.python.org/ftp/python/2.7.11/Python-2.7.11.tgz && \
    tar -xzf Python-2.7.11.tgz && cd Python-2.7.11 && ./configure && make && sudo checkinstall
RUN wget https://bootstrap.pypa.io/get-pip.py && sudo python get-pip.py

# Install tmpwatch
RUN wget http://pkgs.fedoraproject.org/repo/pkgs/tmpwatch/tmpwatch-2.11.tar.bz2/9ea7e169296eb1196b80fe05bba1cbd0/tmpwatch-2.11.tar.bz2 && \
    tar xjf tmpwatch-2.11.tar.bz2 && cd tmpwatch-2.11 && ./configure && make && sudo make install

# install nginx
RUN sudo apt-get -y install nginx

# workaround for not able to chown mounted folders inside docker
# RUN sudo usermod -u 1000 www-data

# install pip packages
ADD requirements.txt requirements_dev.txt ./
RUN pip install -r requirements.txt && pip install -r requirements_dev.txt

ADD nginx.conf start_server.sh ./
RUN sudo cp nginx.conf /etc/nginx/ && \
    sudo mkdir /usr/local/bin/dockerrun && sudo cp start_server.sh /usr/local/bin/dockerrun/ && \
    sudo chmod +x /usr/local/bin/dockerrun/start_server.sh && \
    sudo ln -s /usr/local/bin/dockerrun/start_server.sh /bin/start_server
# ADD server-cron .
# RUN sudo chmod 0644 server-cron && mv server-cron /etc/cron.d/

EXPOSE 80

ENV USE_HTTPS false
ENV DEBUG_MODE false
ENV DB_URL 127.0.0.1
ENV DB_PORT 3306
ENV DB_USER root
ENV DB_PWD ''
ENV AWS_ACCESS_KEY_ID ''
ENV AWS_SECRET_KEY ''
ENV AWS_REGION us-west-2
ENV AWS_IMG_BUCKET italist-test-img
ENV AWS_VEN_BUCKET italist-test-ven
ENV AWS_MKI_BUCKET italist-test-mki
ENV AWS_INV_BUCKET italist-test-inv
ENV AWS_SHP_BUCKET italist-test-shp
ENV AWS_MSC_BUCKET italist-test-msc
ENV NEW_RELIC_APP_NAME 'italist-api-test'
ENV NEW_RELIC_API_KEY ''

CMD start_server
