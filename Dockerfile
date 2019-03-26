FROM debian:latest
MAINTAINER Gernot Klobucaric <murelli146>
COPY root / 
ENV IPEIBD 192.168.179.62
ENV IPE131 192.168.179.214
ENTRYPOINT ["sh","/etc/knxdmxd/run.sh"]
