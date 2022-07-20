# syntax=docker/dockerfile:1

# --------------------------------------------------------------------------- #
# Build image

FROM ubuntu:20.04 as build

# Grab deps
ARG DEBIAN_FRONTEND=noninteractive 
RUN apt-get update \
 && apt-get install --no-install-recommends -y \
	#tcl tk perl gzip tar gnome firefox \
	tcl tk perl gzip tar libpci-dev libegl-dev libgl-dev firefox \
 && ln -fs /usr/share/zoneinfo/Europe/Zagreb /etc/localtime \
 && dpkg-reconfigure -f noninteractive tzdata \
 && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 ansys \
 && useradd -d /home/ansys -s /bin/bash -m ansys -u 1000 -g 1000

USER ansys:ansys
ENV HOME /home/ansys
WORKDIR /home/ansys

ENTRYPOINT ["/bin/bash", "-c"]
CMD ["/usr/bin/firefox"]


# --------------------------------------------------------------------------- #
# Runtime image


# --------------------------------------------------------------------------- #
