## Custom Dockerfile
FROM consol/ubuntu-xfce-vnc:latest
MAINTAINER Tobias Schneck "tobias.schneck@consol.de"
ENV REFRESHED_AT 2017-04-10

USER 0
## install libraries
RUN apt-get update && apt-get install -y libx11-dev libxft-dev fontconfig libcairo2-dev gcc automake git

## pull vtr-verilog-to-routing fork from my repo
RUN mkdir -p /VTR && git clone https://github.com/jeanlego/vtr-verilog-to-routing.git /VTR


## switch back to default user
USER 1984

## build vtr-verilog-to-routing and base test
RUN cd /VTR && make && make install



