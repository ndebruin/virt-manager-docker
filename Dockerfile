FROM debian:bullseye

RUN apt update

# install 
RUN apt install openbox -y --no-install-recommends

COPY .xinitrc ./
COPY autostart ./.config/openbox/

# install virt-manager
RUN apt install virt-manager -y --no-install-recommends

#install tigervnc
RUN apt install wget -y
RUN wget -qO- https://sourceforge.net/projects/tigervnc/files/stable/1.11.0/tigervnc-1.11.0.x86_64.tar.gz | tar xz --strip 1 -C /
RUN mkdir ~/.vnc

#install novnc
RUN apt install git -y
RUN git clone https://github.com/novnc/noVNC.git


#copy startup script
COPY entrypoint.sh ./

RUN chmod 777 entrypoint.sh

EXPOSE 6080

RUN apt clean

ENTRYPOINT [ "./entrypoint.sh" ]