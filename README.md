# NetzTopo 1.8

Scannt das Netzwerk, erkennt alle Geräte und zeigt, **welches Gerät an welchem Switch-Port hängt**: als Netzplan, Karte und Switch-Ansicht.

## Start

| Version | So geht's |
|---|---|
| **Windows** (`NetzTopo-Windows.zip`) | Entpacken → **`NetzTopo.exe`** doppelklicken |
| **USB-Stick** (`NetzTopo-Portable.zip`) | Auf den Stick entpacken → Windows: `NetzTopo.exe`, Linux: `sh netztopo.sh` |

- Es muss **kein Python** installiert sein und es braucht **keine Admin-Rechte**.
- Alle Daten (Berichte, Einstellungen, Verlauf) liegen im Ordner **`Daten`**.
- Gibt es keine Fenster-Oberfläche, öffnet sich automatisch eine im Browser. Mit `NetzTopo im Browser.bat` erzwingst du das.

**Läuft auf:** Windows 11 / 10 / 8.1 (32 und 64 Bit), Windows 7 SP1 (mit Update KB2999226), Linux x86_64. Auf macOS und Raspberry Pi wird das vorhandene `python3` genutzt.

## Bedienung

1. Netz eintragen, zum Beispiel `192.168.150.0/24`. Dein eigenes Netz wird automatisch erkannt.
2. Bei **SNMP-Communities** die Community eurer Switches eintragen.
3. **Scan starten**. Danach öffnet sich der Bericht im Browser.

**Der Bericht hat diese Reiter:**

| Reiter | Inhalt |
|---|---|
| Übersicht | Datenqualität, nächste Schritte, Auffälligkeiten |
| Netzplan | Internet → Firewall → Switches → Gerätegruppen |
| Karte | alle Geräte frei angeordnet, mit 🧭 „Weg ins Internet“ |
| Schränke & Switches | Frontansicht jedes Switches mit Port-Belegung |
| Tabelle | alle Geräte, durchsuchbar |

## Wichtig für ein genaues Ergebnis

- **SNMP (nur lesen) und LLDP auf allen managed Switches aktivieren.** Ohne SNMP sieht kein Tool, was an welchem Port hängt.
- Jede Zuordnung hat eine **Zuverlässigkeit**:
  - **hoch:** einziges Gerät am Port
  - **mittel:** 2 Geräte am Port
  - **vermutet:** irgendwo dahinter
  - **bestätigt:** vor Ort geprüft
- **Für ~100 % Genauigkeit:** **🖨️ Prüfliste** drucken und vor Ort abhaken. Danach die Ergebnisse in die **Korrekturliste** eintragen (Excel, Spalten `switch`, `port`, `bestaetigt`). Die Datei als `korrekturen.csv` in den NetzTopo-Ordner legen und `--rebuild` ausführen.
- In der Korrekturliste kannst du außerdem Namen, Typen, **Schränke** und **Höheneinheiten** pflegen. Daraus entsteht die Rack-Ansicht.

## Extras

- **Export:** CSV, PNG, draw.io (z. B. für BookStack), Import-Dateien für NetBox oder direkter Abgleich über die API
- **Automatisch scannen:** Windows-Aufgabe, die regelmäßig scannt. Sie baut den Geräteverlauf auf und meldet neue Geräte an Teams.
- **Anonymer Export:** Scan ohne Namen und MAC-Endungen, zum Weitergeben bei Problemen

## Kommandozeile

```
NetzTopo.exe --cli 192.168.150.0/24 --community public
NetzTopo.exe --auto        mit gespeicherten Einstellungen scannen
NetzTopo.exe --rebuild     Bericht aus dem letzten Scan neu erzeugen
NetzTopo.exe --web         Browser-Oberfläche
NetzTopo.exe --help
```

## Hinweise

- Der Scan ist **nur lesend**: Ping, Verbindungstests, SNMP-Abfragen. An Geräten wird nichts verändert.
- Der Virenschutz kann einen Netzwerkscanner melden. Nutze das Tool nur in Netzen, für die du zuständig bist.
- Der NetBox-Token wird pro Benutzer und PC verschlüsselt gespeichert. Auf einem anderen PC musst du ihn neu eintragen.
- Probleme? Die Details stehen in `Daten\netztopo-fehler.log`.
