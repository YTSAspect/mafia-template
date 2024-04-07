--[[Config = {}

--#####GABZ CONFİG #######

Config.Language = "en"
Config.TargetExport = "qb-target" -- Just rename. Please use qb-target base. Check client/target.lua
Config.UsePhoneMail = false
Config.GangName = "lostmc" -- If you want use gang 
Config.ProgressbarTime = 10000
Config.ProgressbarTime1 = 15000
Config.Daily = true --- If you daily 1 set true. 

Config.UsingGetCoreCallback = exports['qb-core']:GetCoreObject()  --- If you not using fxmanifest import.lua  
Config.UsingFrameworkOnLoad = "QBCore:Client:OnPlayerLoaded"
Config.UsingFrameworkOnJob = "QBCore:Client:OnJobUpdate"
Config.UsingFrameworkOnGang = "QBCore:Client:OnGangUpdate"
Config.LegacyFuelExports = 'LegacyFuel'
Config.ServerNotify = "QBCore:Notify"
Config.PhoneSendMail = "qb-phone:server:sendNewMail"
Config.GangTrigger = "qb-gangmenu:client:openMenu"




--- The reward he'll get when he gets back to the base.
Config.DeliveryFinishMoney = 5000
Config.DeliveryFinishRewardItem = "iron"
Config.DeliveryFinishRewardCount = 5

--A prize item that will be given randomly. It's just completed the delivery. Not Finish.
Config.DeliveryRewardItems = {
    "iron",
    "plastic",  
}
--Random selection of items. If you want there to be a chance that the item will not come out, make it larger than the number of items.
Config.DeliveryRewardItemsRandom = {
    Min=1,
    Max=5
}
--The number of items to be given randomly. Ex : Max 5 min 1 
Config.DeliveryRewardMinMax = {
    Min = 1,
    Max = 5
}

Config.DeliveryCar = "slamvan2"

--All Coords

Config.Lost = {
    ['Blip'] = {
        coords = vector3(973.99, -117.05, 74.35),
        sprite = 348,
        display = 4,
        scale = 0.7,
        color = 1,
        shortrange = true,
        blipName = "Lost MC"
    },
    ['DeliveryBlipSettings'] = {
        sprite = 225,
        scale = 0.6,
        shortrange = true,
        colour = 3,
        blipName = "Delivery Point",
    },
    ['BossLocation'] = {
        coords= vector3(988.6967, -135.609, 73.85),
        length = 1.0,
        width = 1.0,
        heading = 60.06,
        debugPoly = false,
        minZ = 73.50,
        maxZ = 74.50,

    },
    ['WeaponCraftLocation'] = {
        coords = vector3(1002.68, -129.41, 74.27),
        length = 1.6,
        width = 1.6,
        heading = 60.16,
        debugPoly = false,
        minZ = 73.50,
        maxZ = 75.50,
    },
    ["StashLocation"] = {
        coords= vector3(977.72, -104.65, 74.85),
        length = 1.0,
        width = 1.0,
        heading = 220,
        debugPoly = false,
        minZ = 74.00,
        maxZ = 75.55,
    },
    ['DeliveryZones'] = {
        [1] = {
            coords =vector3(1990.92, 3055.87, 47.22),
            radius =3.5 ,
            debugPoly= false, 
            useZ = true,
        },
        [2] = {
            coords = vector3(1543.08, 6334.4, 24.08),
            radius =3.5 ,
            debugPoly= false, 
            useZ = true,
        },
        [3] = {
            coords = vector3(-2170.37, 4280.69, 49.01),
            radius =3.5 ,
            debugPoly= false, 
            useZ = true,
        }
    },
    ['DeliveryFinishZone'] = {
        coords = vector3(982.77, -134.84, 74.06),
        radius = 3.5,
        debugPoly = false,
        useZ = true,
    },
    ['DeliveryVehicleSpawnLocation'] = {
        coords = vector4(982.77, -134.84, 74.06, 330.34),
    },
    ["VehicleRentCoords"] = {
        spawnCoords = vector4(992.59, -124.58, 74.06, 358.09),
        coords = vector3(992.59, -124.58, 74.06),
        radius = 2.5,
        debugPoly = false,
        useZ = true,
    },
    ['TimeSettings'] = {
        start = 01,
        finish = 20
    },
}

-- Rent Vehicle Car
Config.Vehicles = {
    ["zombiea"] = "Zombie Bobber",
    ["zombieb"] = "Zombie Chopper",
    ["gburrito"] = "Gang Burrito",
}

Config.Weapons = {
    ["WEAPON_APPISTOL"] = {
        weaponName = "AP_PISTOL",
        weaponSpawn = "WEAPON_APPISTOL",
        item = {first= 'metalscrap',
                second= 'iron'},
        costs = {first= 2,
                second= 5},
    },
    ["WEAPON_PISTOL"] = {
        weaponName = "PISTOL",
        weaponSpawn = "WEAPON_PISTOL",
        item = {first= 'metalscrap',
                second= 'iron'},
        costs = {first= 2,
                second= 3},
    },
}

]]--