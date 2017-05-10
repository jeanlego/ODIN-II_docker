## Custom Dockerfile
FROM jeanlego/odin-ii_docker

## pull vtr-verilog-to-routing fork from my repo
RUN mkdir -p /VTR && git clone https://github.com/jeanlego/vtr-verilog-to-routing.git /VTR

## build vtr-verilog-to-routing and base test
RUN cd /VTR && make && make install

VOLUME /workspace

EXPOSE 80
EXPOSE 3000
EXPOSE 8080

CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
