#!/usr/bin/bash

getInstalledVersion() {
    if [ "$ROOT_ACCESS" == true ] && su -c "pm list packages | grep -q $PKG_NAME"; then
        INSTALLED_VERSION=$(su -c dumpsys package "$PKG_NAME" | sed -n '/versionName/s/.*=//p' | sed -n '1p')
    fi
}
