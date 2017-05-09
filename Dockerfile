##testh
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

RUN apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository -y ppa:webupd8team/atom
RUN apt-get install  -y atom
VOLUME ~/atom_base


EXPOSE 5901
EXPOSE 6901
CMD ["/bin/cp", "-rf", "~/atom_base", "~/.atom"]


