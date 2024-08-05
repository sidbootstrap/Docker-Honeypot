FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV COWRIE_VERSION=latest

RUN apt-get update && \
    apt-get install -y git build-essential libssl-dev libffi-dev python3 python3-dev python3-pip

RUN git clone https://github.com/cowrie/cowrie.git /opt/cowrie

WORKDIR /opt/cowrie

RUN pip3 install --no-cache-dir -r requirements.txt

RUN useradd -ms /bin/bash cowrieuser

RUN mkdir -p /opt/cowrie/var/log/cowrie && \
    chown -R cowrieuser:cowrieuser /opt/cowrie

USER cowrieuser

EXPOSE 2222

COPY cowrie.cfg.dist /opt/cowrie/etc/cowrie.cfg

CMD ["bin/cowrie", "start", "-n"]

