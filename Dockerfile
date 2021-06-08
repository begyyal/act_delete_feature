FROM ubuntu:latest

RUN apt-get update
RUN apt-get -y install git curl jq

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
