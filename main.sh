#!/usr/bin/bash

CONFIG_DIR="config"

main() {

    setEnv SOURCE "Morphe" init "$CONFIG_DIR/.config"
    setEnv LIGHT_THEME "off" init "$CONFIG_DIR/.config"
    setEnv PREFER_SPLIT_APK "off" init "$CONFIG_DIR/.config"
    setEnv USE_PRE_RELEASE "off" init "$CONFIG_DIR/.config"
    setEnv LAUNCH_APP_AFTER_MOUNT "off" init "$CONFIG_DIR/.config"
    setEnv ALLOW_APP_VERSION_DOWNGRADE "on" init "$CONFIG_DIR/.config"
    source "$CONFIG_DIR/.config"

    mkdir -p "assets" "apps" "logs" "$STORAGE" "$STORAGE/Patched"

    [ "$ROOT_ACCESS" == true ] && MENU_ENTRY=(7 "Unmount Patched app")

    [ "$LIGHT_THEME" == "on" ] && THEME="LIGHT" || THEME="DARK"
    export DIALOGRC="$CONFIG_DIR/.DIALOGRC_$THEME"

    while true; do
        MAIN=$(
            "${DIALOG[@]}" \
                --title '| Main Menu |' \
                --ok-label 'Select' \
                --cancel-label 'Exit' \
                --menu "$NAVIGATION_HINT" -1 -1 0 1 "Patch App" 2 "Update Assets" 3 "Change Source" 4 "Settings" 5 "Delete Assets" 6 "Delete Apps" "${MENU_ENTRY[@]}" \
                2>&1 > /dev/tty
        ) || break
        case "$MAIN" in
            1)
                initiateWorkflow
                ;;
            2)
                fetchAssetsInfo || break
                fetchAssets
                ;;
            3)
                changeSource
                ;;
            4)
                configure
                ;;
            5)
                deleteAssets
                ;;
            6)
                deleteApps
                ;;
            7)
                umountApp
                ;;
        esac
    done
}

tput civis
ROOT_ACCESS="$1"

for MODULE in $(find modules -type f -name "*.sh"); do
    source "$MODULE"
done

trap terminate SIGTERM SIGINT SIGABRT
main || terminate 1
terminate "$?"
