#!/bin/bash
# knxdmxd starten ohne Debug
/usr/bin/knxdmxd -c /etc/knxdmxd/knxdmxd.conf -u ip:$IPEIBD -p /var/run/knxdmxd.pid -r $IPE131 > /dev/null 2>&1 &
# knxdmxd starten mit Debug
#/usr/bin/knxdmxd -c /etc/knxdmxd/knxdmxd.conf -u ip:$IPEIBD -p /var/run/knxdmxd.pid -r $IPE131
status=$?
# Prüfen ob gestartet, sonst den Container beenden.
if [ $status -ne 0 ];then
	echo "Failed to start knxdmxd"
	exit 0
else
 echo "knxdmxd gestartet"
fi
# Prüfintervall ob PIDfile vorhanden sonst Container beenden
while sleep 600; do
	if [ -e /var/run/knxdmxd.pid ]; then
		echo "PID OK"
	else
		echo "exit 0"
		exit 0
	fi
done
