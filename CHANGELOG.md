# Änderungen

## 2.1 – Werkzeuge
- **Ausfall-Simulator**: was fällt mit aus, wenn Switch/Hypervisor/Firewall ausfällt? Rangliste der kritischsten Punkte.
- **Sicherheits-Check** mit Note A–E (Telnet, FTP, VNC, HTTP-Verwaltung, Standard-SNMP, Zertifikate, alte SSH-Versionen,
  fehlende Netztrennung, UPnP am Router) und **Engpass-Finder** (langsame Uplinks, Server an 100 Mbit).
- **IP-Plan**: Belegungs-Raster je Netz, größte freie Bereiche, nächste freie IPs.
- **Notfallblatt**, **Kabel-Etiketten**, **Sicherheitsbericht** zum Drucken; **Hochfahr-Reihenfolge** nach Stromausfall.
- **Live-Überwachung** und **Wake-on-LAN** in der Browser-Oberfläche.
- **Profi-Suche** (`typ:`, `port:`, `ip:` mit Bereich/CIDR, `hersteller:`, `switch:`, `unsicher`, `toner` …).
- **Das Netz in Klartext**: automatische Zusammenfassung.
- Export um Sicherheit, Ausfallrisiko und IP-Plan erweitert.

## 2.0
- **Universeller Export** statt NetBox-Anbindung: Excel (.xlsx), CSV (Excel und international), JSON, GraphML –
  importierbar in Excel, Inventar-/CMDB-Software, Datenbanken, Wikis und Diagramm-Tools.
- Für die Allgemeinheit aufbereitet: neutrale Beispieldaten, öffentliche README, MIT-Lizenz.

## 1.8 – läuft überall
- Python-3.8-kompatibel (Windows 7), Browser-Oberfläche (`--web`), portable USB-Version, robustes Start-Skript.
- Programmdatei als reines ASCII (behebt Lesefehler unter Windows).

## 1.7 – Begehung
- Prüfliste zum Drucken, Bestätigen/Korrigieren über die Korrekturliste, dokumentierte Mini-Switches, Umsteck-Wächter.

## 1.6 – Zuverlässigkeit
- Ehrliche Stufen hoch/mittel/vermutet, Netzwerk-Simulator (400 Zufallsnetze), Eingangsprüfung, Chaos- und Fuzz-Tests.

## 1.5
- Übersicht mit Datenqualitäts-Score, Plausibilitätsprüfung, Belege pro Gerät, „Weg ins Internet“.

## 1.4
- Netzplan-Ansicht, vereinfachte Karte, verdeckte Switches, UPnP/SSDP, TLS-Zertifikate, Proxy-ARP-Erkennung.

## 1.3
- Switch-Detektiv, Kabel-Gesundheit, PoE, Seriennummern, Tonerstände, draw.io-Export, Alarm-Webhook.

## 1.0–1.2
- Scanner (Ping, ARP, Ports, NetBIOS, SNMP/LLDP/CDP/MAC-Tabellen), Topologie-Bericht, Korrekturliste, Schrank-Ansicht, Geräteverlauf.
