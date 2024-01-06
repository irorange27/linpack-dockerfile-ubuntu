FROM ubuntu:22.04
MAINTAINER niina C27shu@gmail.com

ADD ./sources.list ./

RUN mv /etc/apt/sources.list /etc/apt/sources.list.backup
RUN cp ./sources.list /etc/apt/sources.list

RUN apt-get update; \
    apt update; apt-get -y upgrade;

RUN apt-get install -y build-essential gfortran
RUN apt-get install -y python3 python3-dev
RUN apt-get install -y vim wget curl unzip tar
RUN apt-get install -y openssh-server openssh-client passwd

RUN apt-get install -y net-tools iproute2 iputils-ping

RUN sed -i 's/UsePAm yes/Use PAM no/g' /etc/ssh/sshd_config
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

ADD scripts/mpich-4.1.2.sh ./
RUN bash ./mpich-4.1.2.sh 

ADD scripts/blas-3.11-Cblas.sh ./
RUN bash ./blas-3.11-Cblas.sh

ADD scripts/HPL-2.3.sh ./
RUN bash ./HPL-2.3.sh

ADD scripts/HPCG.sh ./
RUN bash ./HPCG.sh

RUN mkdir scripts
RUN mv *.sh scripts/
# RUN sed -i 's/UsePAm no/Use PAM yes/g' /etc/ssh/sshd_config

RUN echo 'root:password' | chpasswd
RUN ssh-keygen -t rsa -f "/root/.ssh/id_rsa" -N ""
RUN ssh-keygen -t ed25519 -f "/root/.ssh/id_ed25519" -N ""
RUN ssh-keygen -t ecdsa -f "/root/.ssh/id_ecdsa" -N ""

RUN cat /root/.ssh/id_rsa.pub > /root/.ssh/authorized_keys
RUN cat /root/.ssh/id_ed25519.pub > /root/.ssh/authorized_keys
RUN cat /root/.ssh/id_ecdsa.pub > /root/.ssh/authorized_keys
# RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''


EXPOSE 22

RUN mkdir /run/sshd

ENTRYPOINT ["/usr/sbin/init"]
