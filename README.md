
# Mein GitHub-Repository

Dieses Repository enthält drei Shell-Skripte zur Installation und Verwaltung eines Bots auf einem Raspberry Pi, der mit .NET 8 läuft.

## Dateien

### 1. `install_dotnet8.sh`
Ein Skript zur Installation von .NET 8 auf Raspbian. Es führt die folgenden Schritte aus:
- Aktualisiert Systempakete und installiert benötigte Abhängigkeiten.
- Lädt das .NET SDK 8.0 für ARM64 herunter und installiert es.
- Konfiguriert die Umgebungsvariablen für DOTNET_ROOT und PATH.
- Überprüft die Installation von .NET.

Verwendung:
```bash
chmod +x install_dotnet8.sh
./install_dotnet8.sh
```

### 2. `Restart.sh`
Ein Skript zur Überwachung und Neustart des LSS-Bots in einer Endlosschleife. Es prüft regelmäßig, ob der Bot aktiv ist, und startet ihn bei Bedarf neu.

- Fragt die Laufzeit ab und startet den Bot für die angegebene Dauer.
- Verwendet `screen`, um den Bot in einer eigenen Sitzung auszuführen und gegebenenfalls neu zu starten.

Verwendung:
```bash
./Restart.sh
```

### 3. `startRestart.sh`
Ein Skript, das eine neue `screen`-Sitzung für den LSS-Bot erstellt und das Skript `Restarter.sh` darin startet. Es überprüft, ob eine vorhandene Sitzung existiert, beendet diese gegebenenfalls und startet eine neue Sitzung.

Verwendung:
```bash
./startRestart.sh
```

## Voraussetzungen

- Ein Raspberry Pi mit Raspbian und Internetzugang.
- Berechtigung zum Ausführen von Skripten (`chmod +x <scriptname>.sh`).

## Lizenz
Dieses Projekt ist unter der MIT-Lizenz lizenziert.
