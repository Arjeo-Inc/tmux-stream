# YouTube Live Terminal Streaming

This project demonstrates how to stream a terminal window to YouTube Live using Docker, Xvfb, tmux, gotty, and FFmpeg. The setup allows you to share your terminal session in real-time with viewers on YouTube.

## Rationale

The purpose of this project is to provide a solution for streaming a terminal window to YouTube Live, which can be useful for educational purposes, live coding demonstrations, or any scenario where sharing a terminal session with a wide audience is desired.

By leveraging Docker, the project ensures a consistent and reproducible environment for running the necessary components. Xvfb provides a virtual framebuffer for capturing the terminal window, while tmux allows for a persistent terminal session. Gotty enables web-based access to the terminal, and FFmpeg handles the video capture and streaming to YouTube Live.

## Architecture

The project consists of the following components:

- Docker: Used to containerize the application and provide a consistent runtime environment.
- Xvfb: A virtual framebuffer X server that allows running graphical applications without a physical display.
- tmux: A terminal multiplexer that enables multiple terminal sessions within a single window.
- gotty: A web-based terminal emulator that provides access to the terminal session via a web browser.
- FFmpeg: A powerful multimedia framework used for capturing the terminal window and streaming it to YouTube Live.

The architecture works as follows:

1. Xvfb is started within the Docker container to provide a virtual display.
2. A tmux session is created to host the terminal session.
3. Gotty is started and attached to the tmux session, allowing web-based access to the terminal.
4. An Xterm window is launched and connected to the tmux session.
5. FFmpeg captures the Xterm window from the virtual display and streams it to YouTube Live using the provided stream key.

## Prerequisites

Before running the project, ensure that you have the following:

- Docker installed on your machine.
- A YouTube account with live streaming enabled.
- A YouTube Live stream key.

## Getting Started

To run the project, follow these steps:

1. Clone the repository:

```
git clone https://github.com/your-username/youtube-live-terminal-streaming.git


```
	
2. Navigate to the project directory:

```
cd youtube-live-terminal-streaming


```

3. Build the Docker image:

```
docker build -t youtube-terminal-streaming .


```

4. Run the Docker container:

```
docker run -p 80:80 -p 1935:1935 -e YT_STREAM_KEY="your-youtube-stream-key" youtube-terminal-streaming


```

Replace `your-youtube-stream-key` with your actual YouTube Live stream key.

5. Access the web-based terminal by opening a web browser and navigating to `http://localhost`.

6. Interact with the terminal session as needed. The terminal window will be streamed to YouTube Live.

7. To stop the streaming, press `Ctrl+C` in the terminal where you ran the Docker container.

## Customization

You can customize the project by modifying the following:

- `Dockerfile`: Adjust the base image, install additional dependencies, or modify the build process.
- `stream.sh`: Update the FFmpeg command parameters to change the video quality, bitrate, or other streaming settings.
- `nginx.conf`: Modify the Nginx configuration to suit your specific requirements.

## Troubleshooting

If you encounter any issues while running the project, consider the following:

- Ensure that you have a stable internet connection with sufficient upload bandwidth for streaming.
- Verify that your YouTube account is in good standing and has live streaming enabled.
- Double-check that you have provided the correct YouTube Live stream key.
- Check the Docker logs for any error messages or indications of issues with the containers.
- Ensure that you have the necessary ports (80 for gotty, 1935 for RTMP) open and accessible.

If the issue persists, feel free to open an issue on the GitHub repository for further assistance.

## License

This project is licensed under the [MIT License](LICENSE).
