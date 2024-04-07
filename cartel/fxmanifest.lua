fx_version 'bodacious'
game 'gta5'

author 'Quarentin'
description 'qb-cartel - Quarentin'
version '1.0.4'


client_scripts {
	'config.lua',
	'locale/locale.lua',
	'@PolyZone/client.lua',
	'@PolyZone/CircleZone.lua',
	'client/*.lua'
}

server_scripts {
	'config.lua',
	'locale/locale.lua',
	'server/*.lua'
}

escrow_ignore {
	'config.lua',  -- Only ignore one file
	'client/public.lua',
	'locale/locale.lua',
	'gabzconfig.lua',
}

lua54 'yes'