# "VPS" Docker Container

A Docker container that acts as a personal VPS running Ubuntu with ssh setup.

It loads git, curl, and vim onto the machine, then sets up passwordless ssh access.

This will be my super simple way to hack on a random "server" thing in a new container as the sandbox. It obviously doesn't replace the need for cloud hosting when exposing to a public network, but for things I'm working on my own for, this will do just fine.

## Quick Start

```bash
# Build and start the container
docker compose up -d

# Connect via SSH
ssh vps@localhost -p 2222
```

## Customization

### Change the username
Edit `docker-compose.yml` and modify the build args:
```yaml
args:
  USERNAME: your-username
```

### Change the SSH port
Edit `docker-compose.yml`:
```yaml
ports:
  - "YOUR_PORT:22"
```

### Add more packages
Edit the `Dockerfile` and add packages to the `apt-get install` line.
