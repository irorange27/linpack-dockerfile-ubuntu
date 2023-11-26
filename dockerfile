FROM ubuntu:22.04
MAINTAINER niina C27shu@gmail.com

WORKDIR /home

ADD ./sources.list ./

RUN mv /etc/apt/sources.list /etc/apt/sources.list.backup
RUN cp ./sources.list /etc/apt/sources.list

RUN apt-get update; \
    apt update; apt -y upgrade;
RUN apt install -y build-essential gfortran
RUN apt install -y vim wget curl unzip tar
RUN apt install -y python3 python3-dev

ADD scripts/mpi.sh ./
RUN bash ./mpi.sh 

ADD scripts/blas.sh ./
RUN bash ./blas.sh

ADD scripts/HPL.sh ./
RUN bash ./HPL.sh

ADD scripts/HPCG.sh ./
RUN bash ./HPCG.sh

EXPOSE 22
