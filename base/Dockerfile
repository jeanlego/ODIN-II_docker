##testh
## Custom Dockerfile
FROM ubuntu:latest

RUN apt-get update && apt-get install -y libx11-dev libxft-dev fontconfig libcairo2-dev gcc automake git cmake flex bison ctags

## pull vtr-verilog-to-routing fork from my repo
RUN mkdir -p /workspace  &&  mkdir -p /VTR
VOLUME /workspace
RUN git clone verilog-to-routing/vtr-verilog-to-routing /VTR
RUN cd /VTR && make
RUN git init
RUN add .
RUN git commit -m "base"
RUN git remote add origin https://github.com/jeanlego/vtr-build.git
RUN git remote -v
RUN git push origin master

