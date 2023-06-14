fx_version 'cerulean'
game 'gta5'

author 'Nagodo'
description 'Move objects'

shared_scripts {
    'shared/config.lua'
}

client_scripts {
    'client/target.lua',
    'client/keymapping.lua',
    'client/main.lua',
}

server_script {	
    'server/main.lua',
}

escrow_ignore {
    'shared/config.lua',
    'client/target.lua',
    'client/keymapping.lua'
}

lua54 'yes'