## Custom Dockerfile
FROM jeanlego/vnc_base

## pull vtr-verilog-to-routing fork from my repo
RUN mkdir -p /vtr-verilog-to-routing && git clone https://github.com/jeanlego/vtr-verilog-to-routing.git /vtr-verilog-to-routing

## build vtr-verilog-to-routing and base test
RUN cd /vtr-verilog-to-routing && make && make install

RUN touch /on_boot.sh
RUN echo 'case $(/bin/ls /workspace) in' >> /on_boot.sh
RUN echo '*vtr*);;*)' >> /on_boot.sh
RUN echo '/bin/cp -r /vtr-verilog-to-routing /workspace' >> /on_boot.sh
RUN echo ';;esac' >> /on_boot.sh
RUN echo 'supervisord -c /etc/supervisor/supervisord.conf' >> /on_boot.sh

RUN chmod +x /on_boot.sh

VOLUME /workspace

EXPOSE 8080
EXPOSE 22
CMD ["/bin/sh", "/on_boot.sh", "&&", "supervisord", "-c", "/etc/supervisor/supervisord.conf"]
