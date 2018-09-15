FROM resin/rpi-raspbian:stretch

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends xattr python-crypto libgnutls28-dev libacl1-dev libldap2-dev libpam0g-dev bison flex libtracker-sparql-1.0-dev

RUN apt-get install -y --no-install-recommends wget

RUN wget https://download.samba.org/pub/samba/samba-4.9.0.tar.gz

RUN tar -zxf samba-4.9.0.tar.gz

RUN apt-get install -y --no-install-recommends build-essential

RUN apt-get install -y --no-install-recommends python-dev

RUN apt-get install -y --no-install-recommends libjansson-dev

RUN apt-get install -y --no-install-recommends libgpgme11-dev

RUN apt-get install -y --no-install-recommends libarchive-dev

RUN cd samba-4.9.0/; ./configure --enable-debug --systemd-install-services --with-systemd --enable-spotlight; sudo make; sudo make install

ADD run.sh /run.sh

RUN chmod u+x /run.sh

EXPOSE 445

ENTRYPOINT ["/run.sh"]

RUN mkdir /etc/samba

CMD ["-h"]
