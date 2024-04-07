FROM ubuntu:18.04 as ivy-docker

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN apt-get -y install python python-pip g++ cmake python-ply python-pygraphviz git python-tk tix pkg-config libssl-dev libreadline-dev
RUN pip install pyparsing==2.1.4 pexpect
RUN pip install tarjan==0.2.3.2
RUN pip install ply==3.11
RUN pip install pydot==1.4.2

RUN git clone https://github.com/kenmcmil/ivy.git
RUN cd ivy && git reset --hard cea1534 && git submodule update --init --recursive && python build_submodules.py && python setup.py install
WORKDIR /root/tiks-proof
COPY tiks-proof/ .

