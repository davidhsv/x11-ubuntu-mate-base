FROM birchwoodlangham/x11-ubuntu-base:latest

MAINTAINER Tan Quach <tan.quach@birchwoodlangham.com>

ENV DEBIAN_FRONTEND noninteractive

RUN add-apt-repository ppa:leaeasy/dde -y && apt-get update && apt-mark hold iptables && \
    apt-get install -y sudo && apt-get install -y dde && apt-get install dde-file-manager deepin-calculator deepin-gtk-theme deepin-movie deepin-image-viewer deepin-screen-recorder deepin-screenshot deepin-terminal deepin-voice-recorder deepin-gtk-theme -y && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

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
    
RUN apt-get build-dep startdde

RUN cat /usr/share/xsessions/deepin.desktop

RUN echo '[Desktop Entry]\n\
Name=Deepin\n\
Comment=Deepin Desktop Environment\n\
Exec=/usr/bin/startdde\n\
' > /usr/share/xsessions/deepin.desktop 
# startscript to copy dotfiles from /etc/skel
# runs either CMD or image command from docker run
RUN echo '#! /bin/sh\n\
[ -e "$HOME/.config" ] || cp -R /etc/skel/. $HOME/ \n\
exec $* \n\
' > /usr/local/bin/start 
RUN chmod +x /usr/local/bin/start 

ENV DISPLAY=172.30.224.1:0

ENTRYPOINT ["/usr/local/bin/start"]
CMD ["startdde"]

ENV DEBIAN_FRONTEND newt
