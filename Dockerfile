FROM node:18

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    ffmpeg \
    xvfb \
    xterm \
    tmux \
    fonts-roboto \
    wget \
    socat

# Download and install gotty
RUN wget https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz && \
    tar -xzf gotty_linux_amd64.tar.gz && \
    mv gotty /usr/local/bin/gotty && \
    chmod +x /usr/local/bin/gotty

# Create directories
RUN mkdir -p /app/scripts

# Copy the streaming script
COPY scripts/stream.sh /app/scripts/stream.sh
RUN chmod +x /app/scripts/stream.sh

# Expose ports
EXPOSE 3000

# Set environment variables
ENV TERM=xterm

# Start gotty and the streaming script
CMD ["sh", "-c", "tmux new -d -s session-01 & gotty --port 3000 --permit-write tmux attach -t session-01 & /app/scripts/stream.sh | socat - TCP-LISTEN:1935,fork"]
