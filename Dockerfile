FROM ubuntu:rolling
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y 
#check if needed
#RUN apt-add-repository -y ppa:ubuntu-mate-dev/xenial-mate
RUN apt-get update -y
#RUN apt full-upgrade -y
#RUN apt-get dist-upgrade -y
RUN apt-get install -y bash wget curl unzip p7zip python python3 python-pip python3-pip xubuntu-desktop zsh openvpn sudo xrdp tigervnc-standalone-server inetutils-ping
# common downloads
#RUN wget https://raw.githubusercontent.com/sormuras/bach/master/install-jdk.sh;chmod +x install-jdk.sh
#RUN curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb"
#RUN wget -O swamp https://github.com/felixb/swamp/releases/latest/download/swamp_amd64;chmod +x swamp
#RUN wget -O ideaIU-2019.2.1.tar.gz https://download.jetbrains.com/idea/ideaIU-2019.2.1.tar.gz;tar -xfz ideaIU-2019.2.1.tar.gz

# common installs
#RUN dpkg -i session-manager-plugin.deb

EXPOSE 3389

RUN adduser xrdp ssl-cert

# Allow all users to connect via RDP.
RUN xrdp-keygen xrdp auto

# Install Java.
#RUN ./install-jdk.sh -f 12 --target ./jdk12
#ENV PATH="${PATH}:./jdk12/bin"
# install AWS
#RUN python3 -m pip install awscli

RUN useradd opal
RUN echo 'opal:opalpwd' | chpasswd

RUN mkdir -p /home/opal

RUN echo "gnome-session">/home/opal/.xsession
RUN echo "Xcursor.core: 1">/home/opal/.Xresources

CMD /etc/init.d/xrdp start;ping -i 99 127.0.0.1

# Set the locale
#RUN locale-gen de_DE.UTF-8
#ENV LANG de_DE.UTF-8
#ENV LANGUAGE de_DE:de
#ENV LC_ALL de_DE.UTF-8
#RUN update-locale LANG=de_DE.UTF-8
#RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime && dpkg-reconfigure -f noninteractive tzdata