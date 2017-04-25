## Custom Dockerfile
FROM consol/ubuntu-xfce-vnc:latest
MAINTAINER Tobias Schneck "tobias.schneck@consol.de"
ENV REFRESHED_AT 2017-04-10

USER 0
## install libraries
RUN apt-get update && apt-get install -y libx11-dev libxft-dev fontconfig libcairo2-dev gcc automake git cmake flex bison

## switch back to default user
USER 1984
