FROM debian:stretch
MAINTAINER Adrian Dvergsdal [atmoz.net]

# Steps done in one RUN layer:
# - Install packages
# - OpenSSH needs /var/run/sshd to run
# - Remove generic host keys, entrypoint generates unique keys
RUN apt-get update && \
  apt-get -y install openssh-server && \
  rm -rf /var/lib/apt/lists/* && \
  mkdir -p /var/run/sshd && \
  rm -f /etc/ssh/ssh_host_*key*

COPY sshd_config /etc/ssh/sshd_config

RUN  ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ''
RUN ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key -N ''

COPY entrypoint /

EXPOSE 22

ENTRYPOINT ["/entrypoint"]
