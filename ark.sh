#!/usr/bin/env bash

cd /data/ark

if [ ${CHECKFILES} == "true" ]; then
	ARKVALIDATE="validate"
fi

# Get steamcmd
if [ ! -f steamcmd_linux.tar.gz ]; then
        echo "Grabbing SteamCMD..."
        wget -q https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
        tar -xf steamcmd_linux.tar.gz
fi

# Backup before updating just to be safe
if [ -d /data/ark/arkdedicated/ShooterGame/Saved ]; then
        echo "Backing up Saved folder..."
	if [ ! -f /data/ark/backup/ ]; then
		mkdir /data/ark/backup/
	fi
        cp -ra /data/ark/arkdedicated/ShooterGame/Saved /data/ark/backup/Saved-startup_$(date +%Y-%m-%d_%H-%M)
fi


# Update / install server
echo "Updating ARK..."
./steamcmd.sh +login anonymous +force_install_dir /data/ark/arkdedicated +app_update 376030 ${ARKVALIDATE} +quit


# Start ARK
cd /data/ark/arkdedicated/ShooterGame/Binaries/Linux/
export LD_LIBRARY_PATH=/data/ark/arkdedicated/

echo "Launching ARK Dedicated Server..."

./ShooterGameServer TheIsland?listen -server -log
