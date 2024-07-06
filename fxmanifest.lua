fx_version "cerulean"
author "perrituber"

game "gta5"

lua54 'yes'

client_scripts {
    'Client/*.lua',
}

shared_scripts {
    '@ox_lib/init.lua', 
    'shared.lua'
}

ui_page ("nui/ui.html")

files {'**/**/**/**/**/**/*.*'}

