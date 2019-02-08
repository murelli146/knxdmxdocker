# Beschreibung knxdmxdocker

Verbindet die KNX Gruppenadressen mit DMX Universen und Kanälen.

## knxdmxd
Der knxdmxd verbindet den KNX mit dem DMX Bus über das E1.31 Protokoll.
Der knxdmxd lässt sich über die knxdmxd.conf wie ein normaler Dimmaktor für jeden Kanal in allen Universen einstellen.
Über Szenen können mehreren DMX-Kanälen Werte zuweisen und über eine Gruppenadresse aufgerufen werden.
Mit den Cuelists können Effekte eingestellt werden, romantisches Farbwechseln, Discobeleuchtung usw.

Dimmer Objekte:

  * Switch DPT1
  * Value DPT5
  * Dimmer DPT3
  * Status_Switch DPT1
  * Status_Value DPT5

Parameter:

  * Einschalthelligkeit „0-255“
  * Fading in sec. z.B. „0.5“ auch möglich fade in und out eigen zu definieren
  * Dimmzeit in sec. sehr cooles Feature, nach dem Einschalten wird das Licht langsam herauf bzw. herunter gedimmt.
  * Faktor Damit lassen sich z.B. RGB Stripes aufeinander abstimmen.

Der knxdmxd wurde von [J-N-K](https://github.com/J-N-K/knxdmxd)  entwickelt. 
Das Projekt wurde leider 2015 eingestellt und von mir 2019 für Debian 9 kompiliert und in dieses Image eingebaut. 
Bei mir sind ca. 60 Kanäle seit 2012 in Betrieb, die ich wie normale KNX Dimmer handhabe. 
Als Hardware setze ich die [E1.31 Bridge](https://www.doityourselfchristmas.com/wiki/index.php?title=E1.31_Bridge) ein.
Mittlerweile gibt es E1.31 Bridgen auch in Deutschland zum kauf. 
z.B. Der [OctoNode](https://www.ulrichradig.de/home/index.php/dmx/8-kanal-art-net) für 8 DMX Universen mit je 512 Kanälen (36 Updates / Sekunde). 

---

## Image erstellen

```
git clone https://github.com/murelli146/knxdmxdocker.git
cd knxdmxdocker
docker build -t knxdmxdocker .

```

## Container erstellen
***Volume für Konfig erstellen
`docker build -t knxdmxdocker .`
***Container erstellen
`docker run -d -v knxdmxd-conf:/etc/knxdmxd --name=knxdmxdocker --log-opt max-size=2m --log-opt max-file=3 --restart unless-stopped --network=macvlan0 --ip=192.168.179.235 --hostname=knxdmxd knxdmxdocker`

|Beschreibung:| |
| --- | --- |
|docker run \												|                                                     |
|-d \														| Run container in background and print container ID  |
|-v knxdmxd-conf:/etc/knxdmxd \								| Bind mount a volume                                 |
|--name=knxdmxdocker \										| Assign a name to the container                      |
|--log-opt max-size=2m --log-opt max-file=3 \				| Log driver options                                  |
|--restart unless-stopped \									| Restart policy to apply when a container exits      |
|--network=macvlan0 \										| Connect a container to a network                    |
|--ip=192.168.179.235 \										| IPv4 address (e.g., 172.30.100.104)                 |
|--hostname=knxdmxd /										| Container host name                                 |
|knxdmxdocker 									| Image                                               |

---

