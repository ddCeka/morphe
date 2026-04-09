#!/usr/bin/bash

installApp() {
    local CANONICAL_VER
    notify info "Moving patched $APP_NAME apk to Internal Storage..."
    CANONICAL_VER=${APP_VER//:/}
    mv -f "apps/$APP_NAME/$APP_VER-$SOURCE.apk" "$STORAGE/$APP_NAME-$SOURCE-$CANONICAL_VER.apk"

    unset PKG_NAME APP_NAME APKMIRROR_APP_NAME APP_VER
}
