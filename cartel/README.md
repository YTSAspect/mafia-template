# Installation

## STEP 1

- vOpen qb-core > Shared.lua 
- Add code. It should look like this one here.
- If you want it as a job you should add it to this QBCoreJobs.
```
QBShared.Gangs = {
	["none"] = {
		label = "No Gang",
		grades = {
            ['0'] = {
                name = "Unaffiliated"
            },
        },
	},
	["lostmc"] = {
		label = "The Lost MC",
		bossmenu = vector3(0, 0, 0),
		grades = {
            ['0'] = {
                name = "Recruit"
            },
			['1'] = {
                name = "Enforcer"
            },
			['2'] = {
                name = "Shot Caller"
            },
			['3'] = {
                name = "Boss",
				isboss = true
            },
        },
	},
}
```

## STEP 2 
 - If you are using GabzLostMC, you need to make a small change in the fxmanifest file.
    Open qb-mcclub > fxmanifest.lua
    Change 'config.lua' part > 	'gabzconfig.lua'

```
    client_scripts {
        'gabzconfig.lua',
        '@PolyZone/client.lua',
        '@PolyZone/CircleZone.lua',
        'client/target.lua',
        'client/main.lua'
    }

    server_scripts {
        'gabzconfig.lua',
        'server/main.lua'
    }

    escrow_ignore {
        'config.lua',  -- Only ignore one file
        'client/target.lua',
        'gabzconfig.lua',
    }

    lua54 'yes'
```

## IMPORTANT
 - If you using Lastest version QBCore you don't need to read or do this. You do not need to read this step and beyond.

## STEP 3 Custom Framework or Old QBCore
 - Lets do this.

 - We need to make the changes we make here properly. It can be a little confusing.

 - First of all, if we import our Framework with an import.lua to our fxmanifest file.
 - 1-) Remove shared_scripts parts comment line
   Looks like this. (Breeze MLO)

```
--- OPTIONAL 
shared_scripts {
    '@qb-core/import.lua', --- Change this if you different.
    'config.lua',
}

client_scripts {
	'config.lua',
	'@PolyZone/client.lua',
	'@PolyZone/CircleZone.lua',
	'client/target.lua',
	'client/main.lua'
}

server_scripts {
	'config.lua',
	'server/main.lua'
}

escrow_ignore {
	'config.lua',  -- Only ignore one file
	'client/target.lua',
	'gabzconfig.lua',
}

lua54 'yes'

 ```
 - 2-) Open Config.File 
 - 3-) Change this `Config.UsingImportCore` set true
 - 4-) Change this `Config.UsingFramework` your custom framework callback. Ex: LoremCore set LoremCore
 - 5-) Fill in the other required fields according to yourself.
 - 6-) I opened most of the codes in the target-lua section. Here you can do it in the edits. The values ​​here are within the scope of the global value for the script, please do not change them to local.


 - If you are using `GetSharedObject` instead of `GetCoreObject` change this `Config.UsingGetCoreCallback`


 








