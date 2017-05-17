## Custom Dockerfile
FROM jeanlego/vnc_base

## pull vtr-verilog-to-routing fork from my repo
RUN mkdir -p /VTR && git clone https://github.com/jeanlego/vtr-verilog-to-routing.git /VTR

## build vtr-verilog-to-routing and base test
RUN cd /VTR && make && make install

RUN touch /on_boot.sh
RUN echo 'case $(/bin/ls /workspace) in' >> /on_boot.sh
RUN echo '*VTR*);;*)' >> /on_boot.sh
RUN echo '/bin/cp -r /VTR /workspace' >> /on_boot.sh
RUN echo ';;esac' >> /on_boot.sh
RUN echo 'supervisord -c /etc/supervisor/supervisord.conf' >> /on_boot.sh

VOLUME /workspace

EXPOSE 8080
EXPOSE 22
CMD ./on_boot.sh
