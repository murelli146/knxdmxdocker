#!/bin/sh
#########################################################
#	knxdocker                                           #
#		Date		: 26.03.2019                        #
#		Version		: 1.00                              #
#		Autor		: (c)2017 Gernot Klobucaric         #
#		Kontakt		: forum.timberwolf.io               #
#		Member		: murelli146                        #
#########################################################

/usr/bin/knxd /etc/knxd/knxd.ini
status=$?
# Prüfen ob gestartet, sonst den Container beenden.
if [ $status -ne 0 ];then
	echo "Failed to start knxd"
	exit 0
else
 echo "knxd gestartet"
fi
# Prüfintervall ob PIDfile vorhanden sonst Container beenden
while sleep 600; do
	if [ -e /var/run/knxd.pid ]; then
		:
	else
		echo "exit 0 : knxd.pid nicht vorhanden"
		exit 0
	fi
done

