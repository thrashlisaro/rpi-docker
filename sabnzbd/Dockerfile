FROM debian:jessie-slim

RUN groupadd -r -g 666 sabnzbd \
    && useradd -l -r -u 666 -g 666 -d /sabnzbd sabnzbd

ADD sabnzbd.sh /sabnzbd.sh
RUN chmod 755 /sabnzbd.sh

ENV LANG en_GB.utf8

RUN export SABNZBD_VERSION=1.2.0 PAR2CMDLINE_VERSION=v0.6.14 \
    && export DEBIAN_FRONTEND=noninteractive \
    && echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list \
    && export BUILD_PACKAGES="automake build-essential curl git" \
    && export RUNTIME_BACKPORTS_PACKAGES="openssl python-cryptography python-openssl" \
    && export RUNTIME_PACKAGES="ca-certificates p7zip-full python-cheetah python-yenc unrar unzip smbclient" \
    && sed -i "s/ main$/ main contrib non-free/" /etc/apt/sources.list \
    && apt-get -q update \
    && apt-get install -qqy $BUILD_PACKAGES $RUNTIME_PACKAGES \
    && apt-get -t jessie-backports install -qqy $RUNTIME_BACKPORTS_PACKAGES \
    && git clone https://github.com/sabnzbd/sabnzbd.git \
    #    && mv SABnzbd-* sabnzbd \
    && chown -R sabnzbd: sabnzbd \
    && curl -o /tmp/par2cmdline.tar.gz https://codeload.github.com/Parchive/par2cmdline/tar.gz/${PAR2CMDLINE_VERSION} \
    && tar xzf /tmp/par2cmdline.tar.gz -C /tmp \
    && cd /tmp/par2cmdline-* \
    && aclocal \
    && automake --add-missing \
    && autoconf \
    && ./configure \
    && make \
    && make install \
    && export AUTO_ADDED_PACKAGES="$(apt-mark showauto)" \
    && apt-get -y remove --purge $BUILD_PACKAGES $AUTO_ADDED_PACKAGES \
    && apt-get -y autoremove \
    && apt-get install -qqy $RUNTIME_PACKAGES \
    && apt-get -t jessie-backports install -qqy $RUNTIME_BACKPORTS_PACKAGES \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && cd / \
    && rm -rf /tmp/*


VOLUME ["/datadir", "/media"]

EXPOSE 8080

WORKDIR /sabnzbd

CMD ["/sabnzbd.sh"]




