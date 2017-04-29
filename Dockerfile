##test
## Custom Dockerfile
FROM consol/ubuntu-xfce-vnc:latest

USER 0
## install libraries
RUN apt-get update && apt-get install -y libx11-dev libxft-dev fontconfig libcairo2-dev gcc automake git cmake flex bison ctags

## pull vtr-verilog-to-routing fork from my repo
RUN mkdir -p /workspace  &&  mkdir -p /VTR
VOLUME /workspace
RUN git clone https://github.com/jeanlego/vtr-verilog-to-routing.git /VTR
RUN cd /VTR && make && make install

## switch back to default user
USER 1984
