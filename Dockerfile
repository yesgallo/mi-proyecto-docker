FROM debian:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    vim \
    net-tools \
    && apt-get clean

CMD ["bash"]
