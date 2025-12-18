#!/bin/bash

# Create SSH privilege separation directory
mkdir -p /run/sshd

# Generate SSH host keys if they don't exist
if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
    ssh-keygen -A
fi

# Fix permissions on home directory (for persistent volumes)
chown -R ubuntu:ubuntu /home/ubuntu

echo "Starting SSH server..."
echo "Connect with: ssh ubuntu@localhost -p 2222"
exec /usr/sbin/sshd -D
