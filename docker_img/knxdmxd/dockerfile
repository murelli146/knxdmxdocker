FROM debian
COPY root / 
RUN /usr/bin/knxdmxd -d -c /etc/knxdmxd.conf -u ip:192.168.179.62 -p /var/run/knxdmxd.pid >> knxdmxd.log