#!/bin/bash
echo "Synergy container entrypoint reached."

runServer () {
	echo " ----- SYNERGY HL2 DOCKER CONTAINER STARTING ----- "
	echo "Server name: $SERVER_NAME"
	echo "Server password: $SERVER_PASSWORD"
	echo "Vnc password: $VNC_PASSWORD"
	echo ""
	echo "Launching Xvfb"	
	Xvfb :1 -screen 0 1024x768x24 &
	echo "Xvfb launched!"
	echo "Launching x11vnc"
	x11vnc -display :1 -xkb -forever -shared -repeat -capslock -passwd $VNC_PASSWORD &
	echo "x11vnc launched!"
	cd /root/Steam/steamapps/common/Synergy/

	echo "Running processes:"
	ps aux

	echo "Launching srcds.exe"
	DISPLAY=:1 wine start /wait srcds.exe -console -game synergy -ip $ip -port 27015 +map d1_trainstation_01 -insecure +hostname "$SERVER_NAME" +sv_password "$SERVER_PASSWORD" +maxplayers 2

	echo "srcds.exe exited!"
}


if test -f "/installed"; then
	echo "Server files already installed. Launching!"
	
	echo "Reading option file.."
	source /optionfile.sh

	echo "Running the server!"
	runServer
else
	echo " ----- SYNERGY HL2 DOCKER CONTAINER SETUP ----- "
	echo "Server not installed yet. Installing.."
	echo "Server name: $SERVER_NAME"
	echo "Server password: $SERVER_PASSWORD"
	echo "Vnc password: $VNC_PASSWORD"

	echo "Writing optionfile.."
	echo "SERVER_NAME=$SERVER_NAME" >> /optionfile.sh
	echo "SERVER_PASSWORD=$SERVER_PASSWORD" >> /optionfile.sh
	echo "VNC_PASSWORD=$VNC_PASSWORD" >> /optionfile.sh
	
	cd /steamcmd/
	echo "Installing synergy and Half-Life 2 (including Episode 1 and Episode 2)"
	./steamcmd.sh +login $STEAM_USER_NAME $STEAM_PASSWORD $STEAM_GUARD +@sSteamCmdForcePlatformType windows +app_update 220 +app_update 420  +app_update 380 +app_update 17520 validate +quit
	echo "Installation completed."
	touch "/installed"
	runServer
fi
