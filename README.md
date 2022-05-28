# Synergy Half-Life 2 Dedicated Server Docker container
This docker image and compose file run the windows version of the dedicated Synergy server on wine.

## Why not the Linux native version of Synergy?
While the native srcds build technically runs it is missing features such as ingame voice lines.

## Configuration
The container is configured using the following environment variables passed through from the host:
- STEAM_USER_NAME
- STEAM_PASSWORD
- STEAM_GUARD (Optional: if enabled)
- SERVER_NAME
- SERVER_PASSWORD
- VNC_PASSWORD

To download the required Half-Life 2 game files from Steam a Steam account owning the game (And the episodes) is required.

## First run
To run the container, simply specifiy all required options as follows:
`STEAM_USER_NAME=AAA STEAM_PASSWORD=AAA STEAM=GUARD=AAA SERVER_NAME=AAA SERVER_PASSWORD=AAA VNC_PASSWORD=AAA docker-compose up`

SERVER_NAME, SERVER_PASSWORD and VNC_PASSWORD will be stored in a file called optionfile.sh inside the container

## Update
Run `docker-compose down` to destroy the current container and after that rerun the ['First run'](#first-run) command. Steam will update the game files if necassary.

## VNC access
An x11vnc server is running for the virtual x11 framebuffer displaying the Servers console. It can be accessed using any VNC viewer on port 5900

## Missing a feature?
This docker container only supports the Synergy options I personally need. Pull requests and issues are welcome.
