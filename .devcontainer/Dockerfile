# https://github.com/CrafterKolyan/tiny-python-docker-image/tree/main
FROM python:3.11.6-slim-bullseye

# Install system dependencies
RUN apt update && apt install -y --no-install-recommends \
    git \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/bash", "-c"]
