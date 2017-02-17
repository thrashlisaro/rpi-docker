FROM debian:jessie-slim

RUN apt-get update -qq && apt-get upgrade -qq && apt-get -qq install -y \ 
libmono-cil-dev \ 
smbclient \
&& apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC \
&& echo "deb http://apt.sonarr.tv/ master main" | tee /etc/apt/sources.list.d/sonarr.list \
&& apt-get update -qq && apt-get install -qq -y \ 
nzbdrone \ 
&& rm -rf /var/lib/apt/lists/* \ 
&& apt-get upgrade -y
VOLUME /home/steve/sonarr
EXPOSE 8989 445 137 139
ENTRYPOINT mono /opt/NzbDrone/NbzDrone.exe
