# syntax=docker/dockerfile:1

# --------------------------------------------------------------------------- #
# Runtime image

FROM ansys-base:latest as runtime

ARG USR
ARG GRP
ARG ANSYS_SERVER_HOSTNAME

# create the user/group and workspace directory, and update the licence server
RUN groupadd $GRP \
 && useradd -m -d /home/$USR -s /bin/bash -g $GRP -G video -G render $USR \
 && mkdir home/$USR/workspace \
 && sed -i -e "s/127\.0\.0\.1/$ANSYS_SERVER_HOSTNAME/g" /usr/ansys_inc/shared_files/licensing/ansyslmd.ini

#RUN chown -R $USR:$GRP /opt/ansys

# --------------------------------------------------------------------------- #
