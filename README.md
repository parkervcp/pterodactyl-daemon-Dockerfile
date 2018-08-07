# pterodactyl daemon dockerfile

### This is the 0.6.X version of the daemon and not the latest.

[![Docker Repository on Quay](https://quay.io/repository/parkervcp/pterodactyl-daemon/status "Docker Repository on Quay")](https://quay.io/repository/parkervcp/pterodactyl-daemon)

I build a resonably tested docker image for the [pterodactyl daemon](https://github.com/pterodactyl/daemon)

It's hosted on quay.

`docker pull quay.io/parkervcp/pterodactyl-daemon:0.6.X` for this version.


###  Compose
#### required
There are several volumes required to get this to run in the container.

You need volumes for docker.sock and docker container logs. (2 volumes)

The temp pterodactyl volume is also required for installs to work properly. (1 volume)

#### configurable
The daemon config volume is required but you can put it wherever you want (be careful editing).

The daemon data folder can also be put where ever you want but needs to match the config for the daemon (be careful editing)

Certs are required if the daemon is using ssl (You should be) and the let's encrypt folder uses links.

The volume in the compose file is commented out by default if you use another cert location.

If you want to tighten up the security on the links you need 2 volumes to specific folders. I will not walk you through this.