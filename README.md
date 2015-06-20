Unofficial docker image for ARK: Survival Evolved - http://store.steampowered.com/app/346110/

Possibly the easiest way yet to create your own ARK: Survival Evolved server!  
Just follow the instructions and you'll be up and running in minutes!

If you're experiencing issues using this docker image please report them on [Github](https://github.com/phantium/docker-ark/issues)

### Preparations
- Create /data/ark on your system and give permissions to user with UID 1000:  
  `mkdir /data/ark; chown 1000 -R /data/ark/`
- On the docker host increase the ulimits for open files as recommended by ARK devs here: [http://steamcommunity.com/app/346110/discussions/0/594820656471833280/](http://steamcommunity.com/app/346110/discussions/0/594820656471833280/)
  + Edit `/etc/sysctl.conf` and set:  
    `fs.file-max=100000`

  + Edit `/etc/security/limits.conf` and set these limits:  
    `soft nofile 100000`  
    `hard nofile 100000`

  + Edit `/etc/pam.d/common-session` and add the line:  
    `session required pam_limits.so`

    Finally execute: `sysctl -p` or reboot the machine.
- Create your server configuration file
  + Create the directory which holds the configuration files  
  `mkdir -p /data/ark/arkdedicated/ShooterGame/Saved/Config/LinuxServer`
  + Create the file `/data/ark/arkdedicated/ShooterGame/Saved/Config/LinuxServer/GameUserSettings.ini`
    go to [http://steamcommunity.com/app/346110/discussions/0/615086038673139870/](http://steamcommunity.com/app/346110/discussions/0/615086038673139870/) for a list of configuration options


### Usage
- Pull the docker-ark image:  
  `docker pull phantium/docker-ark`

- Launching a server container:  
  `docker run -d -v /data/ark:/data/ark -p 27015:27015/udp -p 7778:7778/udp --name=ark phantium/ark`

- Updating a server container  
  `docker restart ark`
  + Currently no save on exit! Known issue reported by DEVs here:    [http://steamcommunity.com/app/346110/discussions/0/594820656471833280/](http://steamcommunity.com/app/346110/discussions/0/594820656471833280/)
  + Workaround: login to the game server and type the following commands into the console:  
   `enablecheats ADMINPASS`  
   `cheat saveworld`

- Starting a stopped server container  
  `docker start ark`

- Stopping a server container  
  `docker stop ark`
  + Currently no save on exit! Known issue reported by DEVs here:    [http://steamcommunity.com/app/346110/discussions/0/594820656471833280/](http://steamcommunity.com/app/346110/discussions/0/594820656471833280/)
   + Workaround: login to the game server and type the following commands into the console:  
   `enablecheats ADMINPASS`  
   `cheat saveworld`
