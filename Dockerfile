FROM birchwoodlangham/x11-ubuntu-base:latest

MAINTAINER Tan Quach <tan.quach@birchwoodlangham.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-mark hold iptables && \
    apt-get install -y mate-desktop-environment sudo && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

# startscript to copy dotfiles from /etc/skel
# runs either CMD or image command from docker run
RUN echo '#! /bin/sh\n\
[ -e "$HOME/.config" ] || cp -R /etc/skel/. $HOME/ \n\
exec $* \n\
' > /usr/local/bin/start 
RUN chmod +x /usr/local/bin/start 

ENTRYPOINT ["/usr/local/bin/start"]
CMD ["mate-session"]

ENV DEBIAN_FRONTEND newt
