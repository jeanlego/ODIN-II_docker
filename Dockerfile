FROM dorowu/ubuntu-desktop-lxde-vnc

RUN apt-get update
RUN apt-get upgrade -y
# ------------------------------------------------------------------------------
# Install base
RUN apt-get install -y supervisor build-essential g++ curl libssl-dev apache2-utils git libxml2-dev sshfs libx11-dev libxft-dev fontconfig libcairo2-dev gcc automake git cmake flex bison ctags libpam-cracklib
RUN rm -rf /var/lib/apt/lists/*
RUN sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf

# ------------------------------------------------------------------------------
# Security changes
# - Determine runlevel and services at startup [BOOT-5180]
RUN update-rc.d supervisor defaults

# - Install a PAM module for password strength testing like pam_cracklib or pam_passwdqc [AUTH-9262]
RUN ln -s /lib/x86_64-linux-gnu/security/pam_cracklib.so /lib/security

# ------------------------------------------------------------------------------
# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get install -y nodejs

# ------------------------------------------------------------------------------
# Install Cloud9
RUN git clone https://github.com/c9/core.git /cloud9
RUN /cloud9/scripts/install-sdk.sh

# Tweak standlone.js conf
RUN sed -i -e 's_127.0.0.1_0.0.0.0_g' /cloud9/configs/standalone.js

RUN touch /etc/supervisor/conf.d/cloud9.conf

RUN echo '[program:cloud9]' >> /etc/supervisor/conf.d/cloud9.conf
RUN echo 'command = node /cloud9/server.js --listen 0.0.0.0 --port 8080 -w /workspace --collab' >> /etc/supervisor/conf.d/cloud9.conf
RUN echo 'directory = /cloud9' >> /etc/supervisor/conf.d/cloud9.conf
RUN echo 'user = root' >> /etc/supervisor/conf.d/cloud9.conf
RUN echo 'autostart = true' >> /etc/supervisor/conf.d/cloud9.conf
RUN echo 'autorestart = true' >> /etc/supervisor/conf.d/cloud9.conf
RUN echo 'stdout_logfile = /var/log/supervisor/cloud9.log' >> /etc/supervisor/conf.d/cloud9.conf
RUN echo 'stderr_logfile = /var/log/supervisor/cloud9_errors.log' >> /etc/supervisor/conf.d/cloud9.conf
RUN echo 'environment = NODE_ENV="production"' >> /etc/supervisor/conf.d/cloud9.conf

# ------------------------------------------------------------------------------
# Add volumes
RUN mkdir /workspace
VOLUME /workspace

# ------------------------------------------------------------------------------
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## pull vtr-verilog-to-routing fork from my repo
RUN mkdir -p /VTR

RUN git clone https://github.com/jeanlego/vtr-verilog-to-routing.git /VTR
RUN cd /VTR && make && make install

EXPOSE 80
EXPOSE 3000
EXPOSE 8080

CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
