# syntax=docker/dockerfile:1

# --------------------------------------------------------------------------- #
# Build image

FROM debian:bullseye as build

# Grab the Ansys installer image
ARG ANSYS_ARCHIVE
RUN mkdir -p /root/ansys
ADD ${ANSYS_ARCHIVE} /root/ansys

# --------------------------------------------------------------------------- #
# Base image

FROM debian:bullseye as base

# Grab deps
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
 && apt-get install --no-install-recommends -y \
	apt-utils tcl tk perl gzip tar openssl \
	libgl1-mesa-dev x11-common zathura libxtst6 mesa-utils firefox-esr \
	qttools5-dev libqt5x11extras5-dev qtxmlpatterns5-dev-tools libqt5svg5-dev libqwt-qt5-6 \
	libdrm-amdgpu1 xserver-xorg-video-amdgpu \
 && rm -rf /var/lib/apt/lists/*

# Install Ansys
RUN --mount=type=bind,from=build,source=/root/ansys,target=/root/ansys echo "dash dash/sh boolean false" | debconf-set-selections \
 && dpkg-reconfigure dash \
 && cd /root/ansys \
 && ./INSTALL -silent -licserverinfo "::127.0.0.1"

#ADD ansys/ /opt/ansys/

# --------------------------------------------------------------------------- #
