#!/bin/bash
# Run the SteamCMD command
/home/steam/steamcmd/steamcmd.sh +force_install_dir /home/steam/steamcmd/sandstorm/ +login anonymous +app_update 581330 +quit

# Run the Insurgency server command with variable substitutions
/home/steam/steamcmd/sandstorm/Insurgency/Binaries/Linux/InsurgencyServer-Linux-Shipping "$LAUNCH_SCENARIO"?MaxPlayers="$MAX_PLAYERS"?Password="$PASSWORD" -log -hostname="$HOSTNAME" -Port="$PORT" -QueryPort="$QUERY_PORT" -AdminList=Admins -MapCycle=MapCycle
