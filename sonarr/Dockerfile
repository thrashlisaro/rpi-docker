FROM debian:jessie-slim

RUN apt-get update && apt-get upgrade && apt-get install -y \ 
libmono-cil-dev \ 
smbclient \
&& apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC \
&& echo "deb http://apt.sonarr.tv/ master main" | tee /etc/apt/sources.list.d/sonarr.list \
&& apt-get update && apt-get && apt-get install -y \ 
nzbdrone \ 
&& rm -rf /var/lib/apt/lists/*
VOLUME /home/steve/sonarr
EXPOSE 8989 445 137 139
CMD ["mono /pot/NzbDrone/Nzbdrone.exe"]
