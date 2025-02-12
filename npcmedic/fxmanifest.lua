fx_version 'cerulean'
game 'gta5'

author 'Hipera'
description 'NPC medic script'
version '1.0.0'

lua54 'yes'

client_scripts {
    '@ox_lib/init.lua',
    'client.lua',
}

dependencies {
    'ox_lib',
    'ox_target',
    'ox_inventory',
}
