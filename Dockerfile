#
## Salt Stack Salt Master Container
#

FROM ubuntu:16.04
MAINTAINER <balz.aschwanden@unibas.ch>

# Update System
RUN apt-get update && apt-get upgrade -y -o DPkg::Options::=--force-confold
RUN apt-get install -y sudo wget apt-utils

# Add PPA
# Pin to Major Version: https://repo.saltstack.com/#ubuntu
RUN wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/2016.3/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
RUN echo 'deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/2016.3 xenial main' > /etc/apt/sources.list.d/saltstack.list
RUN apt-get update

# Install Salt

RUN apt-get install -y salt-master

# Volumes

VOLUME ['/etc/salt/pki', '/var/cache/salt', '/var/logs/salt', '/etc/salt/master.d', '/srv/salt']

# Add Run File

ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Ports

EXPOSE 4505 4506

# Run Command

CMD "/usr/local/bin/run.sh"
