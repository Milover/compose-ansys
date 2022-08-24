# syntax=docker/dockerfile:1

# --------------------------------------------------------------------------- #
# Build image

FROM debian:bullseye as build

# Grab deps
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
 && apt-get install --no-install-recommends -y \
	apt-utils tcl tk perl gzip tar openssl \
	libgl1-mesa-dev x11-common zathura libxtst6 mesa-utils firefox-esr \
	qttools5-dev libqt5x11extras5-dev qtxmlpatterns5-dev-tools libqt5svg5-dev \
 && rm -rf /var/lib/apt/lists/*

# ansys-related stuff
RUN echo "dash dash/sh boolean false" | debconf-set-selections \
 && dpkg-reconfigure dash

# --------------------------------------------------------------------------- #
# Runtime image

FROM build as runtime

ARG USR
ARG GRP

# create the user/group and workspace directory
RUN groupadd $GRP \
 && useradd -m -d /home/$USR -s /bin/bash -g $GRP -G video $USR \
 && mkdir home/$USR/workspace

#ADD --chown=ansys:ansys ansys/ /opt/ansys/

# --------------------------------------------------------------------------- #
