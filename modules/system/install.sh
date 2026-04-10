#!/usr/bin/bash

installApp() {
    local CANONICAL_VER
    if [ "$ROOT_ACCESS" == true ]; then
        mountApp
    else
        notify info "Moving patched $APP_NAME apk to Internal Storage..."
        CANONICAL_VER=${APP_VER//:/}
        mv -f "apps/$APP_NAME/$APP_VER-$SOURCE.apk" "$STORAGE/Patched/$APP_NAME-$CANONICAL_VER-$SOURCE.apk" &> /dev/null
    fi
    unset PKG_NAME APP_NAME APKMIRROR_APP_NAME APP_VER
}
