FROM birchwoodlangham/x11-ubuntu-base:latest

MAINTAINER Tan Quach <tan.quach@birchwoodlangham.com>

ENV DEBIAN_FRONTEND noninteractive

# choose a mirror
#RUN echo "deb http://packages.deepin.com/deepin/ panda main non-free contrib" > /etc/apt/sources.list
#RUN echo "deb http://mirrors.kernel.org/deepin/  panda main non-free contrib" > /etc/apt/sources.list
#RUN echo "deb http://ftp.fau.de/deepin/          panda main non-free contrib" > /etc/apt/sources.list

RUN add-apt-repository ppa:leaeasy/dde -y && apt-get update && apt-mark hold iptables && \
    apt-get install -y sudo && apt-get install -y dde && apt-get install dde-file-manager deepin-calculator deepin-gtk-theme deepin-movie deepin-image-viewer deepin-screen-recorder deepin-screenshot deepin-terminal deepin-voice-recorder deepin-gtk-theme -y && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

# basics
RUN rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    apt-get update && \
    apt-mark hold iptables && \
    apt-get dist-upgrade -y && \
    apt-get -y autoremove && \
    apt-get clean && \
env DEBIAN_FRONTEND=noninteractive apt-get install -y \
    dbus-x11 \
    libxv1 \
    locales-all \
    mesa-utils \
    mesa-utils-extra \
    procps \
    psmisc

# deepin desktop
RUN env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    dde \
    at-spi2-core \
    gnome-themes-standard \
    gtk2-engines-murrine \
    gtk2-engines-pixbuf \
    pciutils

# additional applications
RUN env DEBIAN_FRONTEND=noninteractive apt-get install -y \
    deepin-calculator \
    deepin-image-viewer \
    deepin-screenshot \
    deepin-system-monitor \
    deepin-terminal \
    deepin-movie \
    gedit \
    oneko \
    sudo \
    synaptic
    
RUN apt-get install -y rsyslog && service rsyslog start

RUN apt-get install -y dbus-x11


ENV DISPLAY=172.30.224.1:0
ENV LIBGL_ALWAYS_INDIRECT=1

CMD ["service dbus start && startdde"]

ENV DEBIAN_FRONTEND newt
