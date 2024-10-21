#!/bin/bash

# Name der neuen screen-Sitzung
SESSION_NAME="Restart"

# Skript, das in der neuen screen-Sitzung ausgeführt werden soll
SCRIPT="/home/$USER/LSSBot/Restarter.sh"

# Prüfe, ob die Session schon existiert
if screen -list | grep -q "$SESSION_NAME"; then
  echo "Screen-Sitzung $SESSION_NAME existiert bereits. Beende sie..."
  # Beende die existierende Sitzung
  screen -S $SESSION_NAME -X quit
  screen -dmS $SESSION_NAME bash -c "$SCRIPT; exec bash"
  screen -rx $SESSION_NAME
fi

# Starte eine neue screen-Sitzung und führe das Skript darin aus
screen -dmS $SESSION_NAME bash -c "$SCRIPT; exec bash"
sleep 60
screen -rx $SESSION_NAME
