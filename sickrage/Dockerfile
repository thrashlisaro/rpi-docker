FROM debian:jessie-slim
ENV ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:en
ENV LC_ALL en_GB.UTF-8

RUN apt-get update && apt-get -y install unrar-free git-core openssl libssl-dev python2.7 python-dev \
&& groupadd -r -g 666 sickrage \
&& useradd -r -u 666 -g 666 -d /sickrage sickrage 

ADD sickrage.sh /sickrage.sh 
RUN chmod 755 /sickrage.sh 

RUN  mkdir /opt/sickrage && chown sickrage:sickrage /opt/sickrage  \
&& git clone https://github.com/SickRage/SickRage.git /opt/sickrage \
# &&  sed -i 's/^# \(en_GB\.UTF-8.*\)$/\1/' /etc/locale.gen \
    && locale-gen en_GB.UTF-8 \
    && easy_install pip \
    && pip install lxml pyOpenSSL \
    && apt-get -y remove curl build-essential python-dev libssl-dev libxml2-dev libxslt-dev \
    && apt-get -y autoremove \
    && apt-get -y clean 


RUN rm -rf /var/lib/apt/lists/*

# ENTRYPOINT python /opt/sickrage/SickBeard.py
# ENTRYPOINT bash
EXPOSE 8081
CMD ["/sickrage.sh"]
