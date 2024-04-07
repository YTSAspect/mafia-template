
local jobVehicle = nil
local randomNumber = nil
local deliveryCreated = false
local FinishZoneCreated = false
local jobStarted = false
local finishState = false


local QBCore = Config.UsingGetCoreCallback

LANG = Locale.Languages[Config.Language]

local function CreateRandomNumber()
    local number = math.random(1,#Config.Cartel['DeliveryZones'])
    return number
end

local function CheckPlayers(vehicle)
    for i = -1, 5,1 do
        seat = GetPedInVehicleSeat(vehicle,i)
        if seat ~= 0 then
            TaskLeaveVehicle(seat,vehicle,0)
            SetVehicleDoorsLocked(vehicle)
            Wait(1500)
            QBCore.Functions.DeleteVehicle(vehicle)
        end
   end
end

local function OpenVehicleMenu()
    local vehicleMenu = {
        {
            header = LANG["VEHICLE_MENU_HEADER"],
            isMenuHeader = true
        }
    }
    for k,v in pairs(Config.Vehicles) do
        vehicleMenu[#vehicleMenu+1] = {
            header = v,
            txt = ""..LANG["VEHICLE_MENU_HEADER_TXT"]..""..v.."",
            params = {
                event = "qb-cartel:client:VehicleMenuSpawn",
                args = {
                    headername = v,
                    spawnName = k
                }
            }
        }                              
    end
    vehicleMenu[#vehicleMenu+1] = {
        header = LANG["MENU_CLOSE"],
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(vehicleMenu)
end

local function CraftMenu()
    local craftMenu = {
        {
            header = LANG["MENU_HEADER"],
            isMenuHeader = true
        }
    }
    local Weapons = Config.Weapons
    for weapon, label in pairs(Weapons) do
        craftMenu[#craftMenu+1] = {
            header = label.weaponName,
            txt = ""..LANG["REQUIREMENTS"]..""..QBCore.Shared.Items[label.item.first]["label"].." x"..label.costs.first..", "..QBCore.Shared.Items[label.item.second]["label"].." x" ..label.costs.second.."",
            params = {
                event = "qb-cartel:client:CraftWeapons",
                args = {
                    weapons = label.weaponSpawn,
					weaponName = label.weaponName,
					weaponItem = label.item,
					weaponCost = label.costs
                }
            }
        }
    end
    craftMenu[#craftMenu+1] = {
        header = LANG["MENU_CLOSE"],
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }
    }
    exports['qb-menu']:openMenu(craftMenu)
end

local function GeneralMenu()
    local GeneralMenu = {
        {
            header = LANG["GENERAL_MENU_HEADER"],
            isMenuHeader = true
        },
		{
			header = ""..LANG["JOB_START"].."",
			txt = ""..LANG["GENERAL_MENU_DELIVERY"].."",
			params = {
				event = "qb-cartel:CartelJob",
			}
		},
		{
			header = ""..LANG["BOSS_LABEL"].."",
			txt = ""..LANG["GENERAL_MENU_MANAGEMENT"].."",
			params = {
				event = Config.GangTrigger,
			}
		}, 
		{
			header = LANG["MENU_CLOSE"],
			txt = "",
			params = {
				event = "qb-menu:client:closeMenu"
			}
		},
		
    }

    exports['qb-menu']:openMenu(GeneralMenu)
end


local function BlipCreate(locationx,locationy,locationz)
	if not finishState then 
		DeliveryBlip = AddBlipForCoord(vector3(locationx,locationy,locationz))
		SetBlipSprite(DeliveryBlip, Config.Cartel['DeliveryBlipSettings'].sprite)
		SetBlipColour(DeliveryBlip, Config.Cartel['DeliveryBlipSettings'].colour)
		SetBlipScale(DeliveryBlip, Config.Cartel['DeliveryBlipSettings'].scale)
		SetBlipAsShortRange(DeliveryBlip,Config.Cartel['DeliveryBlipSettings'].shortrange)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Cartel['DeliveryBlipSettings'].blipName)
		EndTextCommandSetBlipName(DeliveryBlip)
		SetNewWaypoint(locationx, locationy)
	else 
		FinishBlip = AddBlipForCoord(vector3(locationx,locationy,locationz))
		SetBlipSprite(FinishBlip, Config.Cartel['DeliveryBlipSettings'].sprite)
		SetBlipColour(FinishBlip, Config.Cartel['DeliveryBlipSettings'].colour)
		SetBlipScale(FinishBlip, Config.Cartel['DeliveryBlipSettings'].scale)
		SetBlipAsShortRange(FinishBlip,Config.Cartel['DeliveryBlipSettings'].shortrange)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Cartel Delivery Finish")
		EndTextCommandSetBlipName(FinishBlip)
		SetNewWaypoint(locationx, locationy)
	end

end

local function BlipRemove(blipName)
    RemoveBlip(blipName)
end

local function setMapBlip(x, y)
    SetNewWaypoint(x, y) 
end

local VehicleDeliveryZone = {
	{
        header = LANG["DELIVERY_COMP_TEXT"],
        txt = "",
        params = {
            event = "qb-cartel:client:DeliveryComp"
        }
    },
    {
        header = LANG["MENU_CLOSE"],
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }
    }
}


local DeliveryFinishZone = {
	{
        header = LANG["VEHICLE_FINISH_TXT"],
        txt = "",
        params = {
            event = "qb-cartel:client:DeliveryFinish"
        }
    },
    {
        header = LANG["MENU_CLOSE"],
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }
    }
}


local VehicleGarageMenu = {
	{
        header = LANG["VEHICLE_MENU_TXT"],
        txt = "",
        params = {
            event = "qb-cartel:client:TakeOutGarage"
        }
    },
	{
        header = LANG["VEHICLE_MENU_TXT_STORAGE"],
        txt = "",
        params = {
            event = "qb-cartel:client:TakeInGarage"
        }
    },
    {
        header = LANG["MENU_CLOSE"],
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }
    }
}


local function DeliveryCreateZone()
	deliveryCreated = true
	local carHash = GetHashKey(Config.DeliveryCar)
	DeliveryZone = CircleZone:Create(Config.Cartel['DeliveryZones'][randomNumber].coords, Config.Cartel['DeliveryZones'][randomNumber].radius, {
		name="delivery_zone"..randomNumber.."",
		debugPoly=Config.Cartel['DeliveryZones'][randomNumber].debugPoly,
		useZ = Config.Cartel['DeliveryZones'][randomNumber].useZ,
	})
	DeliveryZone:onPlayerInOut(function(isPointInside)
		if isPointInside then
			jobVehicle, distance = QBCore.Functions.GetClosestVehicle(Config.Cartel['DeliveryZones'][randomNumber].coords, true)
			if distance < 5 then 
				if GetEntityModel(jobVehicle) == carHash then 
					if IsVehicleSeatFree(jobVehicle, -1) == 1 and not IsPedInAnyVehicle(PlayerPedId(), false) then
                        if PlayerData.gang.name == Config.GangName then 
						    exports['qb-menu']:showHeader(VehicleDeliveryZone)
                        end
					end
				end
			end
		else
			exports['qb-menu']:closeMenu()
		end
	end)
end

local function FinishZoneCreate()
	FinishZoneCreated = true
	local carHash = GetHashKey(Config.DeliveryCar)
	FinishZone = CircleZone:Create(Config.Cartel['DeliveryFinishZone'].coords,Config.Cartel['DeliveryFinishZone'].radius, {
		name="finish_zone"..Config.Cartel['DeliveryFinishZone'].coords.."",
		debugPoly=Config.Cartel['DeliveryFinishZone'].debugPoly,
		useZ = Config.Cartel['DeliveryFinishZone'].useZ,
	})
	FinishZone:onPlayerInOut(function(isPointInside)
		if isPointInside then
			jobVehicle, distance = QBCore.Functions.GetClosestVehicle(Config.Cartel['DeliveryFinishZone'].coords, true)
			if distance < 5 then 
				if GetEntityModel(jobVehicle) == carHash then 
                    if PlayerData.job.name == Config.JobName or PlayerData.gang.name == Config.GangName then
					    exports['qb-menu']:showHeader(DeliveryFinishZone)
                    end
				end
			end
		else
			exports['qb-menu']:closeMenu()
		end
	end)
end





CreateThread(function()
	while true do
		if PlayerData.gang.name == Config.GangName then
			if jobStarted and not deliveryCreated then
				DeliveryCreateZone()
			elseif finishState and not FinishZoneCreated then
				FinishZoneCreate()
			end
		end
		Wait(1000)
	end
end)


--[[CreateThread(function()
	GarageZone = CircleZone:Create(Config.Cartel['VehicleRentCoords'].coords,Config.Cartel['VehicleRentCoords'].radius, {
		name="garage_zone",
		debugPoly=Config.Cartel['VehicleRentCoords'].debugPoly,
		useZ = Config.Cartel['VehicleRentCoords'].useZ,
	})
	GarageZone:onPlayerInOut(function(isPointInside)
		if isPointInside then
            if PlayerData.gang.name == Config.GangName then
                exports['qb-menu']:showHeader(VehicleGarageMenu)
            end
		else
			exports['qb-menu']:closeMenu()
		end
	end)
end)]]


RegisterNetEvent("qb-cartel:client:DeliveryComp",function()
	QBCore.Functions.Progressbar("RobberyVehicle", LANG["COLLECT_CAR"], math.random(Config.ProgressbarTime, Config.ProgressbarTime1), false, true, { 
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "missexile3",
		anim = "ex03_dingy_search_case_base_michael",
		flags = 49,
	}, {}, {}, function() -- Done
		QBCore.Functions.TriggerCallback("qb-cartel:server:vehicleStatus", function(tim)
			if not tim then
				TriggerServerEvent('qb-cartel:server:DeliveryCompleted')
				QBCore.Functions.Notify(LANG["DELIVERY_COMP_SUCCESS"], "success")
				TriggerEvent("qb-cartel:client:DeliveryCompSetStatus")
			else
				QBCore.Functions.Notify(LANG["DELIVERY_COMP_ERROR"], "error")
			end
		end)
	end, function() -- Cancel
		FreezeEntityPosition(jobVehicle, false)
		FreezeEntityPosition(playerPed, false)
	end)
end)

RegisterNetEvent("qb-cartel:client:DeliveryCompSetStatus",function()
	jobStarted = false
	finishState = true
	DeliveryZone:destroy()
	BlipRemove(DeliveryBlip)
	TriggerEvent("qb-cartel:client:ReturnBaseBlip")
end)

RegisterNetEvent("qb-cartel:client:DeliveryFinish",function()
	local carHash = GetHashKey(Config.DeliveryCar)
	if IsPedInAnyVehicle(PlayerPedId(), false) and GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false)) == carHash then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
		if IsPedInAnyVehicle(PlayerPedId(), false) then 
			CheckPlayers(vehicle)
		else
			QBCore.Functions.DeleteVehicle(vehicle)
		end
		DeliveryCompleted = false
		finishState = false
		FinishZone:destroy()
		BlipRemove(FinishBlip)
		TriggerServerEvent("qb-cartel:server:DeliveryFinish")

	else
		QBCore.Functions.Notify(LANG["VEHICLE_NOT_DELIVERY_CAR"])
	end							
end)

RegisterNetEvent("qb-cartel:client:CartelStash",function()
	TriggerEvent("inventory:client:SetCurrentStash", ""..Config.GangName.."Stash")
	TriggerServerEvent("inventory:server:OpenInventory", "stash", ""..Config.GangName.."Stash", {
		maxweight = 4000000,
		slots = 500,
	})
end)

RegisterNetEvent("qb-cartel:client:SetLocation",function(locationSelect)
	BlipCreate(locationSelect.x, locationSelect.y, locationSelect.z)
end)


RegisterNetEvent("qb-cartel:client:CraftMenu",function()
	CraftMenu()
end)


RegisterNetEvent("qb-cartel:client:TakeOutGarage",function()
	TriggerEvent("qb-cartel:client:VehicleMenu")
end)

RegisterNetEvent("qb-cartel:client:TakeInGarage",function()
	TriggerEvent("qb-cartel:client:TakeIn")
end)

RegisterNetEvent("qb-cartel:client:VehicleMenu",function()
	OpenVehicleMenu()
end)
RegisterNetEvent("qb-cartel:client:TakeIn",function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
	jobVehicle, distance = QBCore.Functions.GetClosestVehicle(Config.Cartel['VehicleRentCoords'].coords, true)
	if IsPedInAnyVehicle(PlayerPedId(), false)  then
		CheckPlayers(vehicle)
	else 
		QBCore.Functions.DeleteVehicle(jobVehicle)
	end

end)




RegisterNetEvent("qb-cartel:client:VehicleMenuSpawn",function(data)
	local model = data.spawnName
    local coords = {
        x = Config.Cartel['VehicleRentCoords'].spawnCoords.x,
        y = Config.Cartel['VehicleRentCoords'].spawnCoords.y,
        z = Config.Cartel['VehicleRentCoords'].spawnCoords.z,
        w = Config.Cartel['VehicleRentCoords'].spawnCoords.w,
    }
    QBCore.Functions.SpawnVehicle(model, function(veh)
        SetVehicleNumberPlateText(veh, "CRTL"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.w)
        exports[Config.LegacyFuelExports]:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)
end)


RegisterNetEvent("qb-cartel:client:CraftWeapons",function(data)
	TriggerServerEvent("qb-cartel:server:CraftWeapons",data)
end)

RegisterNetEvent("qb-cartel:client:CartelJob",function()
	if Config.Daily then 
		QBCore.Functions.TriggerCallback("qb-cartel:server:TimeCheck", function(data, state)
			if (tonumber(data[1]) >= tonumber(Config.Cartel['TimeSettings'].start) and tonumber(data[1]) < tonumber(Config.Cartel['TimeSettings'].finish)) then
				if not state then
					randomNumber = CreateRandomNumber()
					TriggerServerEvent('qb-cartel:server:DeliveryStart') 
					local location = Config.Cartel['DeliveryZones'][randomNumber].coords
					QBCore.Functions.SpawnVehicle(Config.DeliveryCar, function(veh)
						exports[Config.LegacyFuelExports]:SetFuel(veh, 100.0)
						TaskWarpPedIntoVehicle(playerPed, veh, -1)
						SetEntityAsMissionEntity(veh, true, true)
						SetEntityHeading(veh, Config.Cartel['DeliveryVehicleSpawnLocation'].coords.w)
						TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
						SetVehicleEngineOn(veh, true, true)
						if Config.UsePhoneMail then 
							TriggerEvent("qb-cartel:public:LocationSelectSend",location)
						else
							BlipCreate(location.x, location.y, location.z)
						end
						QBCore.Functions.Notify(LANG["JOB_START_START"])
						jobStarted = true
					end, {x = Config.Cartel['DeliveryVehicleSpawnLocation'].coords.x ,y = Config.Cartel['DeliveryVehicleSpawnLocation'].coords.y, z = Config.Cartel['DeliveryVehicleSpawnLocation'].coords.z}, true)
				else
					QBCore.Functions.Notify(LANG["JOB_ALREADY_START"], "error")
				end
			else
				QBCore.Functions.Notify(LANG["JOB_START_TIME"], "error")
			end
		end)
	else
		QBCore.Functions.TriggerCallback("qb-cartel:server:TimeCheck", function(data, state)
			if not state then
				randomNumber = CreateRandomNumber()
				TriggerServerEvent('qb-cartel:server:DeliveryStart') 
				local location = Config.Cartel['DeliveryZones'][randomNumber].coords
				QBCore.Functions.SpawnVehicle(Config.DeliveryCar, function(veh)
					exports[Config.LegacyFuelExports]:SetFuel(veh, 100.0)
					TaskWarpPedIntoVehicle(playerPed, veh, -1)
					SetEntityAsMissionEntity(veh, true, true)
					SetEntityHeading(veh, Config.Cartel['DeliveryVehicleSpawnLocation'].coords.w)
					TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
					SetVehicleEngineOn(veh, true, true)
					if Config.UsePhoneMail then 
						TriggerEvent("qb-cartel:public:LocationSelectSend",location)
					else
						BlipCreate(location.x, location.y, location.z)
					end
					QBCore.Functions.Notify(LANG["JOB_START_START"])
					jobStarted = true
				end, {x = Config.Cartel['DeliveryVehicleSpawnLocation'].coords.x ,y = Config.Cartel['DeliveryVehicleSpawnLocation'].coords.y, z = Config.Cartel['DeliveryVehicleSpawnLocation'].coords.z}, true)
			else
				QBCore.Functions.Notify(LANG["JOB_ALREADY_START"], "error")
			end
		end)
	end
end)



--[[
RegisterNetEvent("qb-cartel:client:ReturnBaseBlip",function()
	local location = Config.Cartel['DeliveryFinishZone'].coords
	BlipCreate(location.x, location.y, location.z)
end)



--- Cartel MC Main Blip
CreateThread(function()
	local blip = AddBlipForCoord(Config.Cartel['Blip'].coords)
	SetBlipSprite(blip, Config.Cartel['Blip'].sprite)
	SetBlipScale(blip,Config.Cartel['Blip'].scale)
	SetBlipAsShortRange(blip,Config.Cartel['Blip'].shortrange)
    SetBlipColour(blip,Config.Cartel['Blip'].colour)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Cartel['Blip'].blipName)
    EndTextCommandSetBlipName(blip)
end)]]--


AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        PlayerData = QBCore.Functions.GetPlayerData()
    end
end)
