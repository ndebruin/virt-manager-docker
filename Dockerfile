FROM debian:bullseye

RUN apt update

# install openbox
RUN apt install openbox -y --no-install-recommends

COPY .xinitrc /root/
COPY autostart /root/.config/openbox/

# install virt-manager
RUN apt install virt-manager -y --no-install-recommends

#install tigervnc and x11
RUN apt install xinit --no-install-recommends -y
RUN apt install tigervnc-standalone-server --no-install-recommends -y
RUN mkdir /root/.vnc
COPY passwd /root/.vnc/
RUN chown root:root /root/.vnc/passwd
RUN chmod 600 /root/.vnc/passwd

#install novnc
RUN apt install git -y
RUN git clone https://github.com/novnc/noVNC.git


#copy startup script
COPY entrypoint.sh ./

EXPOSE 6080

RUN apt clean

CMD [ "/entrypoint.sh" ]