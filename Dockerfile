FROM dorowu/ubuntu-desktop-lxde-vnc
## install libraries
RUN apt-get update && apt-get install -y libx11-dev libxft-dev fontconfig libcairo2-dev gcc automake git cmake flex bison ctags

## pull vtr-verilog-to-routing fork from my repo
RUN mkdir -p /workspace  &&  mkdir -p /VTR

VOLUME /workspace
RUN git clone https://github.com/jeanlego/vtr-verilog-to-routing.git /VTR
RUN cd /VTR && make && make install

RUN apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository -y ppa:webupd8team/atom
RUN apt-get update
RUN apt-get install  -y atom
RUN mkdir -p /atom_settings
RUN chmod 775 -Rf ~/.atom
RUN ln -s ~/.atom /
VOLUME /atom_settings


EXPOSE 5901
EXPOSE 6901
CMD ["/bin/cp", "-Rf", "/atom_settings/.", "/.atom"]
