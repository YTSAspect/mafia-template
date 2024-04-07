Config = {}

Config.Language = "en"
Config.TargetExport = "qb-target" -- Just rename. Please use qb-target base. Check client/target.lua
Config.UsePhoneMail = true
Config.GangName = "cartel" -- If you want use gang 
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

Config.Cartel = {
    ['Blip'] = {
        coords = vector3(0.0, -0.0, 0.0),
        sprite = 348,
        display = 4,
        scale = 0.7,
        color = 1,
        shortrange = true,
        blipName = "Cartel"
    },
    ['DeliveryBlipSettings'] = {
        sprite = 225,
        scale = 0.6,
        shortrange = true,
        colour = 3,
        blipName = "Delivery Point",
    },
    ['BossLocation'] = {
        coords= vector3(0.5329, -0.8687, 0.91),
        length = 1.0,
        width = 1.0,
        heading = 250.01,
        debugPoly = false,
        minZ = 73.50,
        maxZ = 75.50,

    },
    ['WeaponCraftLocation'] = {
        coords =  vector3(0.79, -0.20, 0.21),
        length = 1.6,
        width = 1.6,
        heading = 45.0,
        debugPoly = false,
        minZ = 73.50,
        maxZ = 75.50,
    },
    ["StashLocation"] = {
        coords= vector3(0.2059, -0.0434, 0.8452),
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
        coords = vector3(0.26, -0.22, 0.44),
        radius = 3.5,
        debugPoly = false,
        useZ = true,
    },
    ['DeliveryVehicleSpawnLocation'] = {
        coords = vector4(0.7484, -0.1863, 0.3531, 0.6172),
    },
    ["VehicleRentCoords"] = {
        spawnCoords = vector4(-1259.20, 842.72, 191.47, 71),
        coords = vector3(0.5891, 0.9015, 0.8377),
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
    ["x5e53"] = "BMW X5 E53",
    ["rs6"] = "RS6",
    ["sanchez"] = "Sanchez",
}

Config.Weapons = {
--[[    ["WEAPON_APPISTOL"] = {
        weaponName = "AP_PISTOL",
        weaponSpawn = "WEAPON_APPISTOL",
        item = {first= 'metalscrap',
                second= 'iron'},
        costs = {first= 12,
                second= 7},
    },
    ["WEAPON_PISTOL"] = {
        weaponName = "PISTOL",
        weaponSpawn = "WEAPON_PISTOL",
        item = {first= 'metalscrap',
                second= 'iron'},
        costs = {first= 8,
                second= 5},
    },]]--
}

