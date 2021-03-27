FROM debian:latest

COPY knxd_0.14.29-5_amd64.deb /
COPY knxd-tools_0.14.29-5_amd64.deb /

RUN apt-get update 
RUN apt-get -y install libev4 libusb-1.0-0 init-system-helpers lsb-base
RUN dpkg -i knxd_*.deb knxd-tools_*.deb

COPY root / 

EXPOSE 3672 6720

ENV IPKNXGW 192.168.179.62
ENV IPDMXE131 192.168.179.214
ENV EIBADDR 1.1.200
ENV CLIENTADDRS 1.1.201:5
ENTRYPOINT ["sh","/etc/knxdmxd/run.sh"]
