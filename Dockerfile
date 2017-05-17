## Custom Dockerfile
FROM jeanlego/vnc_base

## pull vtr-verilog-to-routing fork from my repo
RUN mkdir -p /VTR && git clone https://github.com/jeanlego/vtr-verilog-to-routing.git /VTR

## build vtr-verilog-to-routing and base test
RUN cd /VTR && make && make install

VOLUME /workspace

EXPOSE 8080
EXPOSE 22
ENTRYPOINT "case $(/bin/ls /workspace) in *VTR*);;*)/bin/cp -r /VTR /workspace;;esac && supervisord -c /etc/supervisor/supervisord.conf"
