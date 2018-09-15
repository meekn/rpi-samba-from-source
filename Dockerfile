FROM resin/rpi-raspbian:stretch

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends xattr python-crypto libgnutls28-dev libacl1-dev libldap2-dev libpam0g-dev bison flex libtracker-sparql-1.0-dev

RUN wget https://download.samba.org/pub/samba/samba-4.8.2.tar.gz

RUN tar -zxf samba-4.8.2.tar.gz

RUN cd samba-4.8.2/; ./configure --enable-debug --systemd-install-services --with-systemd --enable-spotlight; sudo make; sudo make install
