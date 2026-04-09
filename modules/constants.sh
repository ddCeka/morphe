#!/usr/bin/bash

SRC="$HOME/.local/morphe"
source "$SRC/config/.info"

STORAGE="$HOME/app"

ARCH=$(getprop ro.product.cpu.abi)
DPI=$(getprop ro.sf.lcd_density)

USER_AGENT="Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36"

DIALOG=(dialog --backtitle "Morphe ${VERSION}" --no-shadow --begin 2 0)

CURL=(curl -sL --fail-early --connect-timeout 2 --max-time 5 -H 'Cache-Control: no-cache')

WGET=(wget -qc --show-progress --user-agent="$USER_AGENT")

NAVIGATION_HINT="Navigate with [↑] [↓] [←] [→]"
SELECTION_HINT="press [SPACE] to Select, press [ENTER] to Confirm"