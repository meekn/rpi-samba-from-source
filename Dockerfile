FROM resin/rpi-raspbian:stretch

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
  bison \
  build-essential \
  flex \
  libacl1-dev \
  libarchive-dev \
  libgnutls28-dev \
  libgpgme11-dev \
  libjansson-dev \
  libldap2-dev \
  libpam0g-dev \
  libtracker-sparql-1.0-dev \
  python-crypto \
  python-dev \
  wget \
  xattr \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

RUN mkdir samba \
&& curl -SL https://download.samba.org/pub/samba/samba-4.9.0.tar.gz | tar -zxC samba --strip-components 1 \
&& cd samba \
&& ./configure --enable-debug --systemd-install-services --with-systemd --enable-spotlight \
&& sudo make \
&& sudo make install \
&& cd ../ \
&& rm -rf samba

ADD run.sh /run.sh

RUN chmod u+x /run.sh

EXPOSE 445

ENTRYPOINT ["/run.sh"]

RUN mkdir /etc/samba

CMD ["-h"]
