# syntax=docker/dockerfile:1

# --------------------------------------------------------------------------- #
# Build image

FROM ubuntu:20.04 as build

# Grab deps
ARG DEBIAN_FRONTEND=noninteractive 
RUN apt-get update \
 && apt-get install --no-install-recommends -y \
	tcl tk perl gzip tar openssl \
	#libgl1-mesa-dri mesa-utils libpci-dev libegl-dev libgl-dev \
	nvidia-driver-460 nvidia-modprobe qt5-default firefox \
	#XXX: remove this later
	traceroute ping \
 && ln -fs /usr/share/zoneinfo/Europe/Zagreb /etc/localtime \
 && dpkg-reconfigure tzdata \
 && rm -rf /var/lib/apt/lists/*

RUN echo "dash dash/sh boolean false" | debconf-set-selections \
 && dpkg-reconfigure dash

# create the user and set the home/work dir
RUN groupadd -g 1000 ansys \
 && useradd -d /home/ansys -s /bin/bash -m ansys -u 1000 -g 1000 -G video
USER ansys:ansys
ENV HOME /home/ansys
WORKDIR /home/ansys

#ADD --chown=ansys:ansys ansys/ /opt/ansys/

#ENTRYPOINT ["/bin/bash", "-c"]
#CMD ["/usr/bin/firefox"]
#CMD ["/opt/ansys/ansys_inc/v221/fluent/bin/fluent"]
#CMD ["/opt/ansys/ansys_inc/v221/Framework/bin/Linux64/runwb2"]


# --------------------------------------------------------------------------- #
# Runtime image


# --------------------------------------------------------------------------- #
