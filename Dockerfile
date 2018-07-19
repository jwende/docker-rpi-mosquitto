FROM raspbian/stretch

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -yq \
            apt-transport-https \
            curl \
            gnupg \
            apt-utils

RUN sudo apt-get install -yq mosquitto mosquitto-clients

RUN adduser --system --disabled-password --disabled-login mosquitto

COPY config /mosquitto/config

RUN mkdir /mosquitto/log
RUN mkdir /mosquitto/data


VOLUME ["/mosquitto/config", "/mosquitto/data", "/mosquitto/log"]

EXPOSE 1883 9001
CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]
