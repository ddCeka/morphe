#!/usr/bin/bash

deleteApps() {
    if "${DIALOG[@]}" \
        --title '| Delete Assets |' \
        --defaultno \
        --yesno "Please confirm to delete the apps.\nIt will delete the downloaded apps." -1 -1; then
        rm -rf "apps" &> /dev/null
        rm -rf "logs" &> /dev/null
    fi
}
