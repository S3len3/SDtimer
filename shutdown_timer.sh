#!/bin/bash
TIME=$(zenity --entry --title="Shutdown Timer" --text="Enter time (e.g., 2h for hours, 30m for minutes):")
if [ -z "$TIME" ]; then
    zenity --error --text="No time entered. Exiting."
    exit 1
fi
if [[ "$TIME" =~ ^([0-9]+)([hm])$ ]]; then
    VALUE=${BASH_REMATCH[1]}
    UNIT=${BASH_REMATCH[2]}
    if [ "$UNIT" = "h" ]; then
        MINUTES=$((VALUE * 60))
    elif [ "$UNIT" = "m" ]; then
        MINUTES=$VALUE
    fi
else
    zenity --error --text="Invalid format. Use numbers followed by 'h' (hours) or 'm' (minutes), e.g., 2h or 30m."
    exit 1
fi
zenity --question --text="System will shut down in $MINUTES minutes. Proceed?"
if [ $? -eq 0 ]; then
    shutdown -h +"$MINUTES"
    zenity --info --text="Shutdown scheduled in $MINUTES minutes. Cancel with 'shutdown -c' if needed."
else
    zenity --info --text="Shutdown canceled."
    exit 0
fi
