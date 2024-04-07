LANG = Locale.Languages[Config.Language]

-----#######CUSTOM OR OLD QBCORE FRAMEWORK START #####
PlayerData = {}

local QBCore = Config.UsingGetCoreCallback


RegisterNetEvent(Config.UsingFrameworkOnLoad, function()
    PlayerData = QBCore.Functions.GetPlayerData()
	isLoggedIn = true
end)

RegisterNetEvent(Config.UsingFrameworkOnJob, function(job)
    PlayerData.job = job
end)

RegisterNetEvent(Config.UsingFrameworkOnGang, function(GangInfo)
	PlayerData.gang = GangInfo
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        PlayerData = QBCore.Functions.GetPlayerData()
    end
end)



RegisterNetEvent("qb-cartel:public:LocationSelectSend",function(locationSelect)
    SetTimeout(2000, function()
        TriggerServerEvent(Config.PhoneSendMail, {
            sender =  LANG["PHONE_MAIL_SENDER"],
            subject = LANG["PHONE_MAIL_SUBJECT"],
            message = LANG["PHONE_MAIL_MESSAGE"],
            button = {
                enabled = true,
                buttonEvent = "qb-cartel:client:SetLocation",
                buttonData = locationSelect
            }
        })
    end)
end)




-----#######CUSTOM OR OLD QBCORE FRAMEWORK END #####



--If you other qb-target(bt-target,qtarget etc.) source. Edit code.

CreateThread(function()
    exports[Config.TargetExport]:AddBoxZone("CartelGeneral", Config.Cartel["BossLocation"].coords, Config.Cartel["BossLocation"].length, Config.Cartel["BossLocation"].width, {
        name="CartelGeneral",
        heading=Config.Cartel["BossLocation"].heading,
        debugPoly=Config.Cartel["BossLocation"].debugPoly,
        minZ=Config.Cartel["BossLocation"].minZ,
        maxZ=Config.Cartel["BossLocation"].maxZ
        }, {
            options = {
                {
                    event = "qb-cartel:client:CartelJob",
                    icon = "fas fa-laptop",
                    label = LANG["JOB_START"],
                    gang = Config.GangName
                },
                {
                    event = Config.GangTrigger,
                    icon = "fas fa-laptop",
                    label = LANG["BOSS_LABEL"],
                    gang = Config.GangName
                },
            },
            distance = 1.5
        })
    exports[Config.TargetExport]:AddBoxZone("CartelCraft", Config.Cartel["WeaponCraftLocation"].coords,Config.Cartel["WeaponCraftLocation"].length, Config.Cartel["WeaponCraftLocation"].width, {
        name="CartelCraft",
        heading=Config.Cartel["WeaponCraftLocation"].heading,
        debugPoly=Config.Cartel["WeaponCraftLocation"].debugPoly,
        minZ=Config.Cartel["WeaponCraftLocation"].minZ,
        maxZ=Config.Cartel["WeaponCraftLocation"].maxZ
        }, {
            options = {
                {
                    event = "qb-cartel:client:CraftMenu",
                    icon = "fas fa-laptop",
                    label = LANG["CRAFT_MENU"],
                    gang = Config.GangName
                },
            },
            distance = 1.5
        })        
    exports[Config.TargetExport]:AddBoxZone("CartelStash", Config.Cartel["StashLocation"].coords,Config.Cartel["StashLocation"].length, Config.Cartel["StashLocation"].width, {
        name="CartelStash",
        heading=Config.Cartel["StashLocation"].heading,
        debugPoly=Config.Cartel["StashLocation"].debugPoly,
        minZ=Config.Cartel["StashLocation"].minZ,
        maxZ=Config.Cartel["StashLocation"].maxZ
        }, {
            options = {
                {
                    event = "qb-cartel:client:CartelStash",
                    icon = "fas fa-laptop",
                    label = LANG["STORAGE_LABEL"],
                    gang = Config.GangName
                },
            },
            distance = 1.5
        })      
end)
