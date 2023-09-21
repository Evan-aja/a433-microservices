#!/bin/bash

# Build Docker Image
docker build -t ghcr.io/evan-aja/karsajobs-ui:latest .

# Login to GitHub Package
echo "$PAT" | docker login ghcr.io -u evan-aja --password-stdin

# Push Docker Image
docker push ghcr.io/evan-aja/karsajobs-ui:latest