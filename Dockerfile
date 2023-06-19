FROM ubuntu:jammy-20230605
ENV DEBIAN_FRONTEND noninteractive

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh

# Make the script executable
RUN chmod +x /entrypoint.sh

RUN     apt-get update && apt-get install --no-install-recommends --no-install-suggests -y \
        lib32gcc-s1 \
        curl \
        ca-certificates \
        locales && \
        apt-get -y upgrade && \
        locale-gen "en_US.UTF-8" && \
        export LC_ALL="en_US.UTF-8" && \
        useradd -m steam && \
        su "steam" -c \
        "mkdir -p /home/steam/steamcmd && cd /home/steam/steamcmd && \
        curl -o steamcmd_linux.tar.gz "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" && \
        tar zxf steamcmd_linux.tar.gz && \
        rm steamcmd_linux.tar.gz" && \
        apt-get remove --purge -y curl && \
        apt-get clean autoclean && \
        apt-get autoremove -y && \
        rm -rf /var/lib/{apt,dpkg} /var/{cache,log} && \
        su "steam" -c "./home/steam/steamcmd/steamcmd.sh +force_install_dir /home/steam/steamcmd/sandstorm/ +login anonymous +app_update 581330 validate +quit && \
        mkdir -p /home/steam/steamcmd/sandstorm/Insurgency/Saved/SaveGames"
WORKDIR /home/steam/steamcmd
USER steam

# Set the entry point
ENTRYPOINT ["/entrypoint.sh"]

# ENTRYPOINT /home/steam/steamcmd/steamcmd.sh +force_install_dir /home/steam/steamcmd/sandstorm/ +login anonymous +app_update 581330 +quit && \
#            /home/steam/steamcmd/sandstorm/Insurgency/Binaries/Linux/InsurgencyServer-Linux-Shipping Canyon?Scenario=Scenario_Crossing_Skirmish?MaxPlayers=$MAXPLAYERS?Password=$PASSWORD -log -hostname=$HOSTNAME -Port=$PORT -QueryPort=$QUERYPORT -AdminList=Admins -MapCycle=MapCycle 
