local jobStatus = false
local vehicleStatus = false


local QBCore = Config.UsingGetCoreCallback


LANG = Locale.Languages[Config.Language]

RegisterServerEvent("qb-cartel:server:CraftWeapons",function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local firstItem = Player.Functions.GetItemByName(data.weaponItem.first)
    local secondItem = Player.Functions.GetItemByName(data.weaponItem.second)
    local firstCost = data.weaponCost.first
    local secondCost = data.weaponCost.second
    local weaponSpawnName = data.weapons
    local weaponName = data.weaponName


    if firstItem ~= nil then 
        if firstItem.amount >= firstCost then
            if secondItem ~=nil then 
                if secondItem.amount >= secondCost then
                    Player.Functions.RemoveItem(data.weaponItem.first,firstCost)
                    Player.Functions.RemoveItem(data.weaponItem.second,secondCost)
                    Player.Functions.AddItem(weaponSpawnName, 1)
                    TriggerClientEvent(Config.ServerNotify, src, ""..LANG["CRAFT_SUCCESS"]..""..weaponName.."")
                else
                    TriggerClientEvent(Config.ServerNotify, src, ""..LANG["SERVER_ITEM_AMOUNT"]..""..secondItem.label.."")
                end
            else
                TriggerClientEvent(Config.ServerNotify, src, ""..LANG["SERVER_ITEM_ANY"]..""..secondItem.label.."")
            end
        else
            TriggerClientEvent(Config.ServerNotify, src, ""..LANG["SERVER_ITEM_AMOUNT"]..""..firstItem.label.."")
        end
    else
        TriggerClientEvent(Config.ServerNotify, src, ""..LANG["SERVER_ITEM_ANY"]..""..data.weaponItem.first.."")
    end
end)

--- Araç Teslimat Noktasına teslim edildikten sonra.
RegisterServerEvent('qb-cartel:server:DeliveryCompleted', function()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local RewardItemsSelectRandom = math.random(Config.DeliveryRewardItemsRandom.Min ,Config.DeliveryRewardItemsRandom.Max)
    local RewardCountRandom = math.random(Config.DeliveryRewardMinMax.Min, Config.DeliveryRewardMinMax.Max)
    local Items = Config.DeliveryRewardItems[tonumber(RewardItemsSelectRandom)]
    if Items ~= nil then
        Player.Functions.AddItem(Items,RewardCountRandom)
        TriggerClientEvent(Config.ServerNotify, src, ""..LANG["ADD_ITEM_COMPANY_NOTIFY"]..""..Items.." x"..RewardCountRandom.."")
    else
        TriggerClientEvent(Config.ServerNotify, src, ""..LANG["ADD_ITEM_COMPANY_EMPTY"].."","error")
    end
    if Config.Daily then 
        jobStatus = true
        vehicleStatus = true
    else
        vehicleStatus = false 
        jobStatus = false
    end
end)

RegisterServerEvent('qb-cartel:server:DeliveryStart', function()
    jobStatus = true
end)

-- Araç base'e teslim edildikten sonra.
RegisterServerEvent('qb-cartel:server:DeliveryFinish', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerEvent("qb-gangmenu:server:addAccountMoney",Config.GangName,Config.DeliveryFinishMoney)
    TriggerClientEvent(Config.ServerNotify, src, ""..Config.DeliveryFinishMoney..""..LANG["ADD_CASH_COMPANY_NOTIFY"].."")
    Player.Functions.AddItem(Config.DeliveryFinishRewardItem, Config.DeliveryFinishRewardCount)
    TriggerClientEvent(Config.ServerNotify, src, ""..LANG["ADD_ITEM_COMPANY_NOTIFY"].." "..Config.DeliveryFinishRewardItem.." x"..Config.DeliveryFinishRewardCount.."","success")
end)


QBCore.Functions.CreateCallback('qb-cartel:server:TimeCheck', function(source, cb)
	local ts = os.time()
	local time = {hour = os.date('%H', ts)}
	cb({time.hour}, jobStatus)
end)

QBCore.Functions.CreateCallback('qb-cartel:server:vehicleStatus', function(source, cb)
	cb(vehicleStatus)
end)

print("qb-cartel V1.4 - Author: Quarentin")
