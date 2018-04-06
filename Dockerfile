FROM arm32v7/debian:stretch

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -yq \
            apt-transport-https \
            curl \
	    gnupg \
	    apt-utils
	

RUN curl -s http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key | apt-key add -
RUN curl -s -o /etc/apt/sources.list.d/mosquitto-jessie.list http://repo.mosquitto.org/debian/mosquitto-stretch.list
RUN apt-get update && \
    apt-get install -yq \
            mosquitto

RUN adduser --system --disabled-password --disabled-login mosquitto

COPY config /mqtt/config

VOLUME ["/mqtt/config", "/mqtt/data"]

EXPOSE 1883 9001
CMD ["/usr/sbin/mosquitto", "-c", "/mqtt/config/mosquitto.conf"]
