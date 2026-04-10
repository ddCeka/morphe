#!/usr/bin/bash

configure() {
    local CONFIG_OPTS UPDATED_CONFIG THEME
    local PREV_USE_PRE_RELEASE="$USE_PRE_RELEASE"
    CONFIG_OPTS=(
        "LIGHT_THEME" "Light Theme" "$LIGHT_THEME"
        "PREFER_SPLIT_APK" "Prefer Split APK" "$PREFER_SPLIT_APK"
        "USE_PRE_RELEASE" "Use Pre-release" "$USE_PRE_RELEASE"
        "LAUNCH_APP_AFTER_MOUNT" "Launch App After Mount" "$LAUNCH_APP_AFTER_MOUNT"
        "ALLOW_APP_VERSION_DOWNGRADE" "Allow App Version Downgrade" "$ALLOW_APP_VERSION_DOWNGRADE"
    )

    readarray -t UPDATED_CONFIG < <(
        "${DIALOG[@]}" \
            --title '| Settings |' \
            --no-tags \
            --separate-output \
            --no-cancel \
            --ok-label 'Save' \
            --checklist "$NAVIGATION_HINT\n$SELECTION_HINT" -1 -1 -1 \
            "${CONFIG_OPTS[@]}" \
            2>&1 > /dev/tty
    )

    sed -i "s|='on'|='off'|" "$CONFIG_DIR/.config"

    for CONFIG_OPT in "${UPDATED_CONFIG[@]}"; do
        setEnv "$CONFIG_OPT" on update "$CONFIG_DIR/.config"
    done

    source "$CONFIG_DIR/.config"

    if [ "$PREV_USE_PRE_RELEASE" != "$USE_PRE_RELEASE" ]; then
        rm -f assets/*/.data assets/*-cli.data &> /dev/null
    fi

    [ "$LIGHT_THEME" == "on" ] && THEME="LIGHT" || THEME="DARK"
    export DIALOGRC="$CONFIG_DIR/.DIALOGRC_$THEME"
}
