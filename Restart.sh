#!/bin/bash
###################################################################
#Script Name:LSS-Bot Restarter Input
#Description:Script für die Überwachung vom MSC-Bot
###################################################################
#Variablen:
anzahl=1
runtime="Erster Start"
#Farben:
NORMAL='\033[1;0m'
BLUE='\033[1;34m'
GREEN='\033[1;32m'
RED='\033[1;31m'
#Standarttexte:
zend="Zyklus beendet"
#Endlosschleife
read -p "Soll der Bot nach ende der Laufzeit beendet werden? [y/n]: " yn
case $yn in
    [Yy]* )
            while true
                do
                    echo -e "Wir befinden uns in Durchlauf $RED$anzahl$NORMAL "
                    let "anzahl=anzahl+1"
                    echo "3600 = 1 Stunde; 86400 = 1 Tag; 604800 = 1 Woche"
                    echo -e "Letzte Eingabe: $BLUE$runtime$NORMAL "
                    read -p "Wie lange soll der Bot laufen?: " runtimenew
                    echo -e "Der Bot Läuft für $GREEN$runtimenew$NORMAL Sekunden "
                    runtime=$runtimenew
                    endtime=$(( $(date +%s) + runtime ))
                    timestamp=$(date +%H:%M:%S)
                    timestampend=$(date -d @$endtime )
                    while [[ $(date +%s) -lt $endtime ]]
                        do
                        ProccessWatcher=$(screen -ls | screen -ls | sed -rn 's/([[:digit:]]+)(.Service.Mission-Chief.+)/\1/p' | xargs);
                        ProccessWatcher="$ProccessWatcher" | xargs;
                        if [[ -z "$ProccessWatcher" ]];
                            then screen -dmS "Service.Mission-Chief" bash -c 'cd ./home/timan/LSSBot; dotnet BotNix.App.dll; /usr/bin/exec bash';
                        fi
                        if [[ $(pstree "$ProccessWatcher") != *"dotnet"* ]];
                            then
                            screen -X -S "Service.Mission-Chief" kill
                            screen -dmS "Service.Mission-Chief" bash -c 'cd ./home/timan/LSSBot; dotnet BotNix.App.dll; /usr/bin/exec bash';
                        fi
                        timestamp=$(date +%H:%M:%S)
                        echo -e "Latest check: $GREEN$timestamp$NORMAL "
                        echo "Run until: $timestampend "
                        sleep 60
                    done
                    screen -X -S "Service.Mission-Chief" kill
                    echo -e "$RED$zend$NORMAL"
                    echo ""
                    echo ""
                done
                ;;
    [Nn]* )
            while true
                do
                    echo -e "Wir befinden uns in Durchlauf $RED$anzahl$NORMAL "
                    let "anzahl=anzahl+1"
                    echo "3600 = 1 Stunde; 86400 = 1 Tag; 604800 = 1 Woche"
                    echo -e "Letzte Eingabe: $BLUE$runtime$NORMAL "
                    read -p "Wie lange soll der Bot laufen?: " runtimenew
                    echo -e "Der Bot Läuft für $GREEN$runtimenew$NORMAL Sekunden "
                    runtime=$runtimenew
                    endtime=$(( $(date +%s) + runtime ))
                    timestamp=$(date +%H:%M:%S)
                    timestampend=$(date -d @$endtime )
                    while [[ $(date +%s) -lt $endtime ]]
                        do
                        ProccessWatcher=$(screen -ls | screen -ls | sed -rn 's/([[:digit:]]+)(.Service.Mission-Chief.+)/\1/p' | xargs);
                        ProccessWatcher="$ProccessWatcher" | xargs;
                        if [[ -z "$ProccessWatcher" ]];
                            then screen -dmS "Service.Mission-Chief" bash -c 'cd ./home/timan/LSSBot; dotnet BotNix.App.dll; /usr/bin/exec bash';
                        fi
                        if [[ $(pstree "$ProccessWatcher") != *"dotnet"* ]];
                            then
                            screen -X -S "Service.Mission-Chief" kill
                            screen -dmS "Service.Mission-Chief" bash -c 'cd ./home/timan/LSSBot; dotnet BotNix.App.dll; /usr/bin/exec bash';
                        fi
                        timestamp=$(date +%H:%M:%S)
                        echo -e "Latest check: $GREEN$timestamp$NORMAL "
                        echo "Run until: $timestampend "
                        sleep 60
                    done
                    echo -e "$RED$zend$NORMAL"
                    echo ""
                    echo ""
                done
                ;;
    * ) echo "Du musst eine Auswahl treffen";;
    esac