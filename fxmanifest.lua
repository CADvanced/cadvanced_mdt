fx_version "adamant"
games {"gta5"}

name "CADvanced MDT"
description "CADvanced MDT, a FiveM resource that provides integration between CADvanced (https://cadvanced.app) and FiveM in the form of an in-game MDT."
version "2.1.9"

ui_page "ui/build/index.html"
ui_page_preload "yes"

files {
    "ui/build/index.html",
    "ui/build/bundle.js",
    "ui/build/css/reset.css",
    "ui/build/css/main.css",
    "ui/build/sounds/roger.ogg",
    "ui/build/sounds/panic.ogg",
    "ui/build/sounds/dtmf/1.ogg",
    "ui/build/sounds/dtmf/2.ogg",
    "ui/build/sounds/dtmf/3.ogg",
    "ui/build/sounds/dtmf/4.ogg",
    "ui/build/sounds/dtmf/5.ogg",
    "ui/build/sounds/dtmf/6.ogg",
    "ui/build/sounds/dtmf/7.ogg",
    "ui/build/sounds/dtmf/8.ogg",
    "ui/build/sounds/dtmf/9.ogg",
    "ui/build/sounds/dtmf/0.ogg",
    "ui/build/sounds/ringing_uk.ogg",
    "ui/build/sounds/ringing_us.ogg",
    "ui/build/sounds/busy_uk.ogg",
    "ui/build/sounds/busy_us.ogg"
}

client_scripts {
    "client/*.lua"
}

server_scripts {
    "server/lib/debug.lua",
    "server/lib/state.lua",
    "server/lib/util.lua",
    "server/lib/router.lua",
    "server/main.lua",
    "mdt_config.lua",
    "version.lua",
    "modules/api.lua",
    "modules/config.lua"
}
