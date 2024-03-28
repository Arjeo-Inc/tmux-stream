FROM node:18 AS build

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    ffmpeg \
    xvfb \
    wget

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

# Use the tiangolo/nginx-rtmp image
FROM tiangolo/nginx-rtmp

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    curl \
    ffmpeg \
    xvfb

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# Copy files from the previous stage
COPY --from=build /app/scripts/stream.sh /app/scripts/stream.sh
COPY --from=build /usr/local/bin/gotty /usr/local/bin/gotty

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose ports
EXPOSE 80
EXPOSE 1935

# Set environment variables for YouTube streaming
ENV YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2"

# Start Nginx and the streaming script as root
CMD ["sh", "-c", "gotty --port 3000 --permit-write bash & nginx -g 'daemon off;' & /app/scripts/stream.sh"]
