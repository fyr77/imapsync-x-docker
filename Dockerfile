# This is based on the official imapsync Dockerfile, found at https://hub.docker.com/r/gilleslamiral/imapsync

FROM php:apache

LABEL   maintainer="Jakob SENKL <jakob@notjakob.com>" \
        description="Imapsync /X" \
        documentation="https://github.com/fyr77/imapsync-x-docker"

COPY html/ /var/www/html/
COPY cgi/ /usr/lib/cgi-bin/

RUN set -xe && \
  apt-get update \
  && apt-get install -y \
  libauthen-ntlm-perl \
  libcgi-pm-perl \
  libcrypt-openssl-rsa-perl \
  libdata-uniqid-perl \
  libencode-imaputf7-perl \
  libfile-copy-recursive-perl \
  libfile-tail-perl \
  libio-compress-perl \
  libio-socket-ssl-perl \
  libio-socket-inet6-perl \
  libio-tee-perl \
  libhtml-parser-perl \
  libjson-webtoken-perl \
  libmail-imapclient-perl \
  libparse-recdescent-perl \
  libmodule-scandeps-perl \
  libpar-packer-perl \
  libreadonly-perl \
  libregexp-common-perl \
  libsys-meminfo-perl \
  libterm-readkey-perl \
  libtest-mockobject-perl \
  libtest-pod-perl \
  libunicode-string-perl \
  liburi-perl  \
  libwww-perl \
  procps \
  wget \
  make \
  cpanminus \
  lsof \
  ncat \
  openssl \
  ca-certificates \
  libdist-checkconflicts-perl \
  libproc-processtable-perl \
  libtest-mock-guard-perl \
  libtest-modern-perl \
  libtest-requires-perl \
  && rm -rf /var/lib/apt/lists/* \
  && cpanm IO::Socket::SSL

# I added the IO::Socket::SSL update to avoid the annoying, confusing and useless warning
# DEBUG: .../IO/Socket/SSL.pm:1177: global error: Undefined SSL object

RUN set -xe \
  && cd \
  && echo "SetEnv no-gzip 1" > add.txt \  
  && sed -i '/Require all granted/r add.txt' /etc/apache2/conf-enabled/serve-cgi-bin.conf \
  && a2enmod cgi \
  && cd /usr/lib/cgi-bin \
  && chmod +x imapsync oauth2.py \
  && cd /var/www/html \
  && ln -s imapsync_form_extra.html index.html
  

EXPOSE 80

# 
# End of imapsync-x Dockerfile
