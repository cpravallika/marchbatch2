FROM ubuntu:20.04

# Update and install basic tools
RUN apt update && apt install -y \
    curl \
    wget \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Create a working directory
WORKDIR /root

# Default command
CMD ["/bin/bash"]
