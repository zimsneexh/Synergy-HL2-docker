FROM debian:10 AS synergyimage
RUN apt update && apt-get install -y wine
RUN dpkg --add-architecture i386
RUN apt update
RUN apt-get -y install wine32 libwine libwine:i386 fonts-wine
RUN apt-get install -y lib32gcc1 curl xvfb screen procps winbind x11vnc
RUN rm -rf /steamcmd
RUN mkdir steamcmd && cd steamcmd && curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD /start.sh
EXPOSE 27015/tcp
EXPOSE 27015/udp
EXPOSE 5900/udp
EXPOSE 5900/tcp
