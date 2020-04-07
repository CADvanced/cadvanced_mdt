fx_version "adamant"
games {"gta5"}

name "CADvanced MDT"
description "CADvanced MDT, a FiveM resource that provides integration between CADvanced (https://cadvanced.app) and FiveM in the form of an in-game MDT."
version "2.0.2"

ui_page "ui/build/index.html"

files {
    "ui/build/index.html",
    "ui/build/bundle.js",
    "ui/build/css/reset.css",
    "ui/build/css/main.css",
    "ui/build/sounds/roger.ogg"
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
