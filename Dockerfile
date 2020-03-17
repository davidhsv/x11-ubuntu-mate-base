FROM birchwoodlangham/x11-ubuntu-base:latest

MAINTAINER Tan Quach <tan.quach@birchwoodlangham.com>

ENV DEBIAN_FRONTEND noninteractive

RUN add-apt-repository ppa:leaeasy/dde -y && apt-get update && apt-mark hold iptables && \
    apt-get install -y sudo && apt-get install -y dde && apt-get install dde-file-manager deepin-calculator deepin-gtk-theme deepin-movie deepin-image-viewer deepin-screen-recorder deepin-screenshot deepin-terminal deepin-voice-recorder deepin-gtk-theme -y && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

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
