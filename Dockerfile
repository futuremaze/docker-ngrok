FROM node:latest
MAINTAINER Admin

#environments
ENV NGROK_FORWARD localhost:8080
RUN set -ex; \
        apt-get update; \
        apt-get install -y --no-install-recommends \
                zip unzip \
        && useradd ngrok -m

WORKDIR /home/ngrok
USER ngrok
ADD --chown=ngrok:ngrok https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip ./
COPY --chown=ngrok:ngrok ./config.yml ./
RUN ls -la ./ \ 
  && unzip ./ngrok-stable-linux-amd64.zip \
  && chmod 755 ./ngrok

EXPOSE 4040

CMD ./ngrok http --config=./config.yml --log=stdout ${NGROK_FORWARD}
