#!/bin/bash
# knxd starten
#/usr/bin/knxd /etc/knxd/knxd.ini
/usr/bin/knxd --daemon --pid-file=/var/run/knxd.pid --trace=0x0 --error=0x9 --eibaddr=$EIBADDR --client-addrs=$CLIENTADDRS --GroupCache=2000 --listen-tcp=6720 --layer2=ipt:$IPKNXGW
status_knx=$?
# knxdmxd starten ohne Debug als Deamon
/usr/bin/knxdmxd -d -c /etc/knxdmxd/knxdmxd.conf -u ip:127.0.0.1 -p /var/run/knxdmxd.pid -r $IPDMXE131
# knxdmxd starten mit Debug
#/usr/bin/knxdmxd -c /etc/knxdmxd/knxdmxd.conf -u ip:$IPEIBD -p /var/run/knxdmxd.pid -r $IPE131
status_dmx=$?
# Prüfen ob knxd gestartet, sonst den Container beenden.
if [ $status_knx -ne 0 ];then
	echo "Failed to start knxd"
	exit 0
else
 echo "knxd gestartet"
fi
# Prüfen ob knxdmxd gestartet, sonst den Container beenden.
if [ $status_dmx -ne 0 ];then
	echo "Failed to start knxdmxd"
	exit 0
else
 echo "knxdmxd gestartet"
fi
# Prüfintervall ob PIDfile vorhanden sonst Container beenden
while sleep 600; do
	if [ -e /var/run/knxd.pid ]; then
		:
	else
		echo "exit 0 : knxd.pid nicht vorhanden"
		exit 0
	fi
	if [ -e /var/run/knxdmxd.pid ]; then
		:
	else
		echo "exit 0 : knxdmxd.pid nicht vorhanden"
		exit 0
	fi
done
