fx_version 'cerulean'
lua54 'yes'
game 'gta5'

client_script 'client/client.lua'

server_scripts {
    'server/server.lua',
    '@oxmysql/lib/MySQL.lua'
}


shared_script {
    'shared/Config.lua',
    '@es_extended/imports.lua',
    '@ox_lib/init.lua'
    }