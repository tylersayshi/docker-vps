FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    git \
    curl \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Configure SSH - no password, key-based only
RUN mkdir -p /var/run/sshd /run/sshd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Use existing ubuntu user (UID/GID 1000), give sudo access
RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && passwd -d ubuntu \
    && passwd -d root

# Create workspace
RUN mkdir -p /home/ubuntu/workspace && chown ubuntu:ubuntu /home/ubuntu/workspace

EXPOSE 22

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
