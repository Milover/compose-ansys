# syntax=docker/dockerfile:1

# --------------------------------------------------------------------------- #
# Runtime image

FROM ansys-base:latest as runtime

ARG USR
ARG GRP

# create the user/group and workspace directory
RUN groupadd $GRP \
 && useradd -m -d /home/$USR -s /bin/bash -g $GRP -G video $USR \
 && mkdir home/$USR/workspace

#RUN chown -R $USR:$GRP /opt/ansys

# --------------------------------------------------------------------------- #
