# Ubuntu 18.04 LTS
FROM phusion/baseimage:0.11

CMD ["/sbin/my_init"]

MAINTAINER Mikey Schaefer <mikeylikesrocks@gmail.com>

# The docker container version
ENV BUILD_VERSION="1.0"

ENV APP_NAME="CrushFTP Server"
ENV DEBIAN_FRONTEND=noninteractive

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8




# Speed up APT
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup \
  && echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# libraries stuff
RUN set -x \
  && apt-get update && apt-get upgrade -y \
  && apt-get install -y net-tools file \
    less vim software-properties-common unzip cifs-utils sudo \
    libjpeg-dev libjpeg8 libjpeg-turbo8 ufraw ufraw-batch imagemagick \
    openjdk-8-jre \
  && rm -rf /var/cache/apt/* 
    
    
RUN apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
    
# Add in custom my_ini.d scripts    

ADD init.d/00-install /etc/my_init.d/00-install
RUN chmod 755 /etc/my_init.d/00-install

ADD init.d/10-adduser /etc/my_init.d/10-adduser
RUN chmod 755 /etc/my_init.d/10-adduser

ADD init.d/90-crushftp /etc/my_init.d/90-crushftp
RUN chmod 755 /etc/my_init.d/90-crushftp

ADD init.d/99-zmessage /etc/my_init.d/99-zmessage
RUN chmod 755 /etc/my_init.d/99-zmessage


ADD https://crushftp.com/early9/CrushFTP9_PC.zip /tmp/CrushFTP9_PC.zip
# ADD ./CrushFTP9_PC.zip /tmp/CrushFTP9_PC.zip  #uncomment if .zip is already dowloaded to local dir



VOLUME ["/var/opt/CrushFTP9_PC"]

# WebServer
EXPOSE 8080 9090 9921 9443 2222 10000-10500

