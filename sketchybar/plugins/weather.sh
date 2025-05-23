#!/usr/bin/env zsh

IP=$(curl -s https://ipinfo.io/ip)
LOCATION_JSON=$(curl -s https://ipinfo.io/$IP/json)

LOCATION="Huntsville"
REGION="AL"
# Build an escaped string for wttr.in (“+” in place of spaces or commas)
LOCATION_ESCAPED="${LOCATION// /+}+${REGION// /+}"

# Fetch weather JSON for Huntsville, AL
WEATHER_JSON=$(curl -s "https://wttr.in/${LOCATION_ESCAPED}?format=j1")

# Fallback if wttr.in didn’t return anything
if [ -z "$WEATHER_JSON" ]; then
  sketchybar --set $NAME label="$LOCATION"
  sketchybar --set $NAME.moon icon=
  return
fi

TEMPERATURE=$(echo $WEATHER_JSON | jq '.current_condition[0].temp_C' | tr -d '"')
WEATHER_DESCRIPTION=$(echo $WEATHER_JSON | jq '.current_condition[0].weatherDesc[0].value' | tr -d '"' | sed 's/\(.\{25\}\).*/\1.../')
MOON_PHASE=$(echo $WEATHER_JSON | jq '.weather[0].astronomy[0].moon_phase' | tr -d '"')

case ${MOON_PHASE} in
"New Moon")
    ICON=
    ;;
"Waxing Crescent")
    ICON=
    ;;
"First Quarter")
    ICON=
    ;;
"Waxing Gibbous")
    ICON=
    ;;
"Full Moon")
    ICON=
    ;;
"Waning Gibbous")
    ICON=
    ;;
"Last Quarter")
    ICON=
    ;;
"Waning Crescent")
    ICON=
    ;;
esac

sketchybar --set $NAME label="$LOCATION  $TEMPERATURE℃ $WEATHER_DESCRIPTION"
sketchybar --set $NAME.moon icon=$ICON
