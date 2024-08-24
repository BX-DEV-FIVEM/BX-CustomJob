fx_version 'adamant'
game 'gta5'
lua54 'yes'

name 'BX-CustomJob'
author 'BX-DEV'
description 'Custom Job For ESX / OX'
version 'V.1.3'
url 'https://github.com/xB3NDO'


shared_scripts {
    'config.lua',
    '@ox_lib/init.lua', -- OX
    '@es_extended/imports.lua' -- ESX
}

client_scripts {
    'config.lua',
    'client/client.lua'
    
}

server_scripts {
    '@mysql-async/lib/MySQL.lua', -- SQL
    'config.lua',
    'server/server.lua',
    'server/version.lua'
}


dependency 'es_extended'


-- data_file 'DLC_ITYP_REQUEST' 'stream/bzzz_prop_payment_terminal.ytyp'
