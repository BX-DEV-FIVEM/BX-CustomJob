local ox_target = exports.ox_target
local vehicle = nil
local model = nil
local dutyStatut = false


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
    table.wipe(PlayerData)
    ESX.PlayerLoaded = false
    ESX.PlayerData = {}
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

--NOTIFY --

function Notify(msg, typenotif)
    if typenotif == nil then
        typenotif = 'info'
    end
    if Config.Notify == 'ox' then
        lib.notify({
            title = "",
            description = msg,
            type = typenotif  
        })
    elseif Config.Notify == 'okok' then
        exports['okokNotify']:Alert("", msg, 5000, typenotif)
    elseif Config.Notify == 'esx' then 
        ESX.ShowNotification(msg)
    end
end

RegisterNetEvent('BX-' .. Config.job_name .. ':Notify')
AddEventHandler('BX-' .. Config.job_name .. ':Notify', function(msg, typenotif)
    Notify(msg, typenotif)
end)





--BOSS MENU--

exports.ox_target:addBoxZone({
    coords = Config.BossPos,
    size = vec3(2, 2, 2),
    rotation = 45,
    options = {
        {
            name = 'Menu '.. Config.job_name,
            event = 'ox_target:debug',
            -- icon = 'fa-solid fa-building',
            label = Strings['boss_menu'],
            groups = Config.job_name,
            distance = Config.DistanceOxTarget,
            onSelect = function(data)
                if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.job_name and ESX.PlayerData.job.grade_name == 'boss' then
                    TriggerEvent('esx_society:openBossMenu', Config.job_name, function(data, menu)
                    end)
                end
            end
        }
    }
})



--- SHOP ---



    local BlipShop = nil

    local function createBlipShop()
        if not Config.BlipShop.visible then
            return
        end

        if BlipShop then
            RemoveBlip(BlipShop)
        end

        BlipShop = AddBlipForCoord(Config.BlipShop.coords)

        SetBlipSprite(BlipShop, Config.BlipShop.sprite)
        SetBlipScale(BlipShop, Config.BlipShop.scale)
        SetBlipColour(BlipShop, Config.BlipShop.color)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.BlipShop.name)
        EndTextCommandSetBlipName(BlipShop)
        SetBlipAsShortRange(BlipShop, true)
    end

    local function updateVisibilityBlipShop()
        if Config.Blip.visible then
            if not BlipShop then
                createBlipShop()
            end
        else
            if BlipShop then
                RemoveBlip(BlipShop)
                BlipShop = nil
            end
        end
    end


  
if Config.ShopOn then   


    function LoadModel(model)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(1)
        end
    end

    Citizen.CreateThread(function()
        LoadModel(Config.PedModel)
        local ped = CreatePed(4, Config.PedModel, Config.PedPosition.x, Config.PedPosition.y, Config.PedPosition.z, Config.PedHeading, false, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)

        exports.ox_target:addBoxZone({
            coords = vec3(Config.PedPosition.x, Config.PedPosition.y, Config.PedPosition.z+1.0),
            size = vec3(1, 1, 2),
            rotation = Config.PedHeading,
            options = {
                {
                    name = 'BX-' .. Config.job_name ..':vendor_ped',
                    event = 'BX-' .. Config.job_name ..':vendor:checkJob',
                    -- -- icon = 'fa-solid fa-shopping-cart',
                    groups = Config.job_name,
                    distance = Config.DistanceOxTarget,
                    label = Strings['buy_object']
                }
            }
        })
    end)

    RegisterNetEvent('BX-' .. Config.job_name ..':vendor:checkJob')
    AddEventHandler('BX-' .. Config.job_name ..':vendor:checkJob', function()
        local playerData = ESX.GetPlayerData()
        if ESX.PlayerData.job.name == Config.job_name then
            if dutyStatut then
            TriggerEvent('BX-' .. Config.job_name ..':vendor:openShopMenu')
            else
                Notify(Strings['no_service'], 'error')
            end
        else
            Notify(Strings['no_job'], 'error')
        end
    end)

    RegisterNetEvent('BX-' .. Config.job_name ..':vendor:openShopMenu')
    AddEventHandler('BX-' .. Config.job_name ..':vendor:openShopMenu', function()
        lib.showContext('BX-' .. Config.job_name .. Strings['shop'])
    end)

    lib.registerContext({
        id = 'BX-' .. Config.job_name .. Strings['shop'],
        title = Strings['shop'],
        options = (function()
            local shopOptions = {}
            for _, item in ipairs(Config.JobPed) do
                table.insert(shopOptions, {
                    title = item.label,
                    description = Strings['price'] .. item.price .. ' 💲',
                    onSelect = function()
                        TriggerServerEvent('BX-' .. Config.job_name ..':vendor:buyItem', item.name, item.price)
                    end
                })
            end
            return shopOptions
        end)()
    })

end




--- RECOLTE --- 



local harvestPointsStatus = {}
local props = {}
local isHarvesting = false
local zoneIds = {}


local BlipHarvestPoints = nil

local function createBlip()
    if not Config.BlipHarvestPoints.visible then
        return
    end

    if BlipHarvestPoints then
        RemoveBlip(BlipHarvestPoints)
    end

    BlipHarvestPoints = AddBlipForCoord(Config.BlipHarvestPoints.coords)

    SetBlipSprite(BlipHarvestPoints, Config.BlipHarvestPoints.sprite)
    SetBlipScale(BlipHarvestPoints, Config.BlipHarvestPoints.scale)
    SetBlipColour(BlipHarvestPoints, Config.BlipHarvestPoints.color)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.BlipHarvestPoints.name)
    EndTextCommandSetBlipName(BlipHarvestPoints)
    SetBlipAsShortRange(BlipHarvestPoints, true)
end

local function updateBlipVisibility()
    if Config.Blip.visible then
        if not BlipHarvestPoints then
            createBlip()
        end
    else
        if BlipHarvestPoints then
            RemoveBlip(BlipHarvestPoints)
            BlipHarvestPoints = nil
        end
    end
end




local function setPointUnavailable(point, time)
    local key = tostring(point.x) .. "_" .. tostring(point.y) .. "_" .. tostring(point.z)
    harvestPointsStatus[key] = { available = false, resetTime = GetGameTimer() + time }
end

local function createProp(point)
    local propName = point.prop
    local prop = CreateObject(GetHashKey(propName), point.x, point.y, point.z, false, true, true)
    SetEntityAsMissionEntity(prop, true, true)
    PlaceObjectOnGroundProperly(prop)
    FreezeEntityPosition(prop, true)
    return prop
end

local function deleteProp(prop)
    if DoesEntityExist(prop) then
        FreezeEntityPosition(prop, false)
        DeleteObject(prop)
        SetEntityAsNoLongerNeeded(prop)
    end
end


local function clearAllPropsAndDisableHarvesting()
    for _, zoneId in ipairs(zoneIds) do
        exports.ox_target:removeZone(zoneId)
    end

    for key, prop in pairs(props) do
        if prop then
            deleteProp(prop)
            props[key] = nil
        end
    end
    
end


local function checkPointAvailability(point)
    local key = tostring(point.x) .. "_" .. tostring(point.y) .. "_" .. tostring(point.z)
    local pointStatus = harvestPointsStatus[key]

    if pointStatus then
        if GetGameTimer() >= pointStatus.resetTime then
            pointStatus.available = true
            return true
        else
            return false
        end
    end

    return true
end

local function startHarvesting(point)
    if isHarvesting or not checkPointAvailability(point) then
        return
    end
    
    isHarvesting = true
    local playerPed = PlayerPedId()
    local key = tostring(point.x) .. "_" .. tostring(point.y) .. "_" .. tostring(point.z)
    TaskStartScenarioInPlace(playerPed, point.animation, 0, true)
    Citizen.Wait(Config.HarvestTime)
    ClearPedTasksImmediately(playerPed)
    TriggerServerEvent('BX-' .. Config.job_name ..':harvest:addItem', point.item)
    setPointUnavailable(point, Config.TimeToNextHarvest)
    if props[key] then
        deleteProp(props[key])
        props[key] = nil
    end
    isHarvesting = false
    Citizen.SetTimeout(Config.TimeToNextHarvest, function()
        if not props[key] then
            props[key] = createProp(point)
        end
    end)

end

local function addHarvestZones()
    for _, point in ipairs(Config.HarvestPoints) do
        local key = tostring(point.x) .. "_" .. tostring(point.y) .. "_" .. tostring(point.z)
        if not harvestPointsStatus[key] then
            harvestPointsStatus[key] = { available = true, resetTime = 0 }
        end
        if not props[key] then
            props[key] = createProp(point)
        end
        local zoneId = exports.ox_target:addBoxZone({
            coords = vec3(point.x, point.y, point.z),
            size = vec3(2, 2, 2), 
            rotation = 45,
            options = {
                {
                    name = point.label,
                    event = 'ox_target:debug',
                    -- icon = 'fa-solid fa-circle-check',
                    label = point.label,
                    groups = Config.job_name,
                    distance = Config.DistanceOxTarget,
                    onSelect = function()
                        if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.job_name then
                            if checkPointAvailability(point) then
                                startHarvesting(point)
                                if props[key] then
                                    deleteProp(props[key])
                                    props[key] = nil
                                end
                            else
                                Notify(Strings['in_reload'], 'error')
                            end
                        else
                            Notify(Strings['no_job'], 'error')
                        end
                    end
                }
            }
        })
        table.insert(zoneIds, zoneId)
    end
end





--Spawn the vehicle--

local function spawnCar(carmodel)
    local car = GetHashKey(carmodel)
    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    vehicle = CreateVehicle(car, Config.car_pos, Config.car_posHeading, true, false) 
    local plate = GetVehicleNumberPlateText(vehicle)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
    model = carmodel

    if Config.CutomVehicleKey then
    Config.CustomVehicleFunction(vehicle, plate, model)
    end
end





--GARAGE MENU--

lib.registerContext({
    id = 'garage ' .. Config.job_name,
    title = Strings['garage'],
    options = (function()
        local vehicleOptions = {}
        for _, vehicle in ipairs(Config.GarageVehicles) do
            table.insert(vehicleOptions, {
                title = vehicle.title,
                description = vehicle.description,
                -- icon = 'fa-solid fa-car',
                onSelect = function()
                    if dutyStatut then
                        if lib.progressCircle({
                            duration = 5000,
                            position = 'bottom',
                            useWhileDead = false,
                            canCancel = true,
                            disable = { car = true },
                            anim = { dict = 'missheistdockssetup1ig_5@talk', clip = 'hey_guys_floyd' },
                        }) then 
                            spawnCar(vehicle.model)
                        else 
                        
                        end
                    else
                        Notify(Strings['no_service'], 'error')
                    end
                end
            })
        end
        table.insert(vehicleOptions, {
            title = Strings['put_in_desc'],
            icon = 'fa-solid fa-arrow-rotate-left',
            onSelect = function()
                local plate = GetVehicleNumberPlateText(vehicle)
                if Config.CutomVehicleKey then
                    Config.CustomVehicleFunctionBack(vehicle, plate, model)
                end
                if lib.progressCircle({
                    duration = 5000,
                    position = 'bottom',
                    useWhileDead = false,
                    canCancel = true,
                    disable = { car = true },
                    anim = { dict = 'missheistdockssetup1ig_5@talk', clip = 'hey_guys_floyd' },
                }) then DeleteVehicle(vehicle) else end
            end
        })

        return vehicleOptions
    end)()
})


  exports.ox_target:addBoxZone({
    coords = Config.target_garage,
    size = vec3(2, 2, 2),
    rotation = 45,
    options = {
        {
            name = 'garage ' .. Config.job_name,
            event = 'ox_target:debug',
            -- icon = 'fa-solid fa-warehouse',
            label = Strings['garage'],
            groups = Config.job_name,
            distance = Config.DistanceOxTarget,
            onSelect = function(data)
                if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.job_name then
                    lib.showContext('garage ' .. Config.job_name)
                end
            end
        }
    }
})


--Craft 1 Menu--

lib.registerContext({
    id = Strings['craft1'],
    title = Strings['craft1'],
    options = (function()
        local menuOptions = {}
        for _, item in ipairs(Config.CraftItems1) do
            table.insert(menuOptions, {
                title = item.title,
                description = item.description,
                -- icon = 'fa-solid fa-bullseye',
                onSelect = function()
                    if lib.progressCircle({
                        duration = 7000,
                        position = 'bottom',
                        useWhileDead = false,
                        canCancel = true,
                        disable = { car = true },
                        anim = { dict = 'amb@prop_human_bbq@male@idle_a', clip = 'idle_c' },
                    }) then 
                        TriggerServerEvent('BX-' .. Config.job_name .. ':craftItem', item.craftItems, item.rewardItem)
                    else 
                        Notify(Strings['need_ingrédient'], 'error')
                        
                    end
                end
            })
        end
        return menuOptions
    end)()
})



exports.ox_target:addBoxZone({
    coords = Config.craft1,
    size = vec3(2, 2, 2),
    rotation = 45,
    options = {
        {
            name = Strings['craft_use1'],
            event = 'ox_target:debug',
            -- icon = 'fa-solid fa-bullseye',
            label =  Strings['craft_use1'],
            groups = Config.job_name,
            distance = Config.DistanceOxTarget,
            onSelect = function(data)
                if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.job_name then
                    lib.showContext(Strings['craft1'])
                end
        	end
        }
    },
})


-- Craft 2 Menu --- 


lib.registerContext({
    id = Strings['craft2'],
    title = Strings['craft2'],
    options = (function()
        local menuOptions = {}
        for _, item in ipairs(Config.CraftItems2) do
            table.insert(menuOptions, {
                title = item.title,
                description = item.description,
                -- icon = 'fa-solid fa-bullseye',
                onSelect = function()
                    if lib.progressCircle({
                        duration = 7000,
                        position = 'bottom',
                        useWhileDead = false,
                        canCancel = true,
                        disable = { car = true },
                        anim = { dict = 'amb@prop_human_bbq@male@idle_a', clip = 'idle_c' },
                    }) then 
                        TriggerServerEvent('BX-' .. Config.job_name .. ':craftItem', item.craftItems, item.rewardItem)
                    else 
                        Notify(Strings['need_ingrédient'], 'error')
                    end
                end
            })
        end
        return menuOptions
    end)()
})



exports.ox_target:addBoxZone({
    coords = Config.craft2,
    size = vec3(2, 2, 2),
    rotation = 45,
    options = {
        {
            name = Strings['craft_use2'],
            event = 'ox_target:debug',
            -- icon = 'fa-solid fa-bullseye',
            label =  Strings['craft_use2'],
            groups = Config.job_name,
            distance = Config.DistanceOxTarget,
            onSelect = function(data)
                if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.job_name then
                    lib.showContext(Strings['craft2'])
                end
        	end
        }
    }
})


-- Craft 3 Menu --- 



lib.registerContext({
    id = Strings['craft3'],
    title = Strings['craft3'],
    options = (function()
        local menuOptions = {}
        for _, item in ipairs(Config.CraftItems3) do
            table.insert(menuOptions, {
                title = item.title,
                description = item.description,
                -- icon = 'fa-solid fa-bullseye',
                onSelect = function()
                    if lib.progressCircle({
                        duration = 7000,
                        position = 'bottom',
                        useWhileDead = false,
                        canCancel = true,
                        disable = { car = true },
                        anim = { dict = 'amb@prop_human_bbq@male@idle_a', clip = 'idle_c' },
                    }) then 
                        TriggerServerEvent('BX-' .. Config.job_name .. ':craftItem', item.craftItems, item.rewardItem)
                    else 
                        Notify(Strings['need_ingrédient'], 'error')
                    end
                end
            })
        end
        return menuOptions
    end)()
})



exports.ox_target:addBoxZone({
    coords = Config.craft3,
    size = vec3(2, 2, 2),
    rotation = 45,
    options = {
        {
            name = Strings['craft_use3'],
            event = 'ox_target:debug',
            -- icon = 'fa-solid fa-bullseye',
            label =  Strings['craft_use3'],
            groups = Config.job_name,
            distance = Config.DistanceOxTarget,
            onSelect = function(data)
                if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.job_name then
                    lib.showContext(Strings['craft3'])
                end
        	end
        }
    }
})







--fridge--





exports.ox_target:addBoxZone({
    coords = Config.fridge,
    size = vec3(2, 2, 2),
    rotation = 45,
    options = {
        {
            name = Config.job_name,
            event = 'ox_target:debug',
            -- icon = 'fa-solid fa-dice-d6',
            label = Strings['fridge'],
            groups = Config.job_name,
            distance = Config.DistanceOxTarget,
            onSelect = function(data)
                if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.job_name then
                    exports.ox_inventory:openInventory('stash', 'stock_' .. Config.job_name)
                end
        	end
        }
    }
})





--Ped 

DecorRegister("Yay", 4)
pedHash = Config.PedStyle
zone = Config.garage_ped 
Heading = Config.PedHeadingG
Ped = nil

Citizen.CreateThread(function()

LoadModel(pedHash)
Ped = CreatePed(2, GetHashKey(pedHash), zone, Heading, 0, 0)
DecorSetInt(Ped, "Yay", 5431)
FreezeEntityPosition(Ped, 1)
TaskStartScenarioInPlace(Ped, "WORLD_HUMAN_CLIPBOARD", 0, false)
SetEntityInvincible(Ped, true)
SetBlockingOfNonTemporaryEvents(Ped, 1)
end)

function LoadModel(model)
while not HasModelLoaded(model) do
    RequestModel(model)
    Wait(1)
end
end

--display blip--
Citizen.CreateThread(function()

    local blip = AddBlipForCoord(Config.Blip.Pos.x, Config.Blip.Pos.y, Config.Blip.Pos.z)
  
    SetBlipSprite (blip, Config.Blip.Sprite)
    SetBlipDisplay(blip, Config.Blip.Display)
    SetBlipScale  (blip, Config.Blip.Scale)
    SetBlipColour (blip, Config.Blip.Colour)
    SetBlipAsShortRange(blip, true)
  
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Strings['Society_Name'])
    EndTextCommandSetBlipName(blip)
    
  
end)



---------- Menu JOb

AddEventHandler('BX-' .. Config.job_name .. ':openJobMenu', function()
    openJobMenu()
end)


RegisterCommand(Config.job_name .. '_JobMenu', function()
    openJobMenu()
end)

openJobMenu = function()
	if ESX.PlayerData.job.name == Config.job_name then
		local Options = {

			{
				title = Strings['menu_name1'],
				description = Strings['menu_desc1'],
				-- icon = 'fa-solid fa-bullhorn',
				arrow = false,
				event = 'BX-' .. Config.job_name .. 'Annonce',
			},
            {
				title = Strings['menu_name5'],
				description = Strings['menu_desc5'],
				-- icon = 'fa-solid fa-briefcase',
				arrow = false,
				event = 'BX-' .. Config.job_name .. ':openJobDuty',
			},
		}
        if Config.Billing then
			table.insert(Options, {
				title = Strings['menu_name4'],
				description = Strings['menu_desc4'],
				-- icon = 'fa-solid fa-file-invoice-dollar',
				arrow = false,
				event = 'BX-' .. Config.job_name .. ':Facture',
			})
		end
        if Config.TakeObject then
			table.insert(Options, {
                    title = Strings['hand'],
                    -- icon = 'fa-solid fa-suitcase',
                    arrow = false,
                    event = 'BX-' .. Config.job_name .. ':takeobject',
			})
		end
        if Config.PlaceObject then
			table.insert(Options, {
                    title = Strings['menu_name3'],
                    description = Strings['menu_desc3'],
                    -- icon = 'fa-solid fa-boxes-stacked',
                    arrow = false,
                    event = 'BX-' .. Config.job_name .. 'object',
			})
		end
		lib.registerContext({
			id = Config.job_name .. '_menu',
			title = 'Menu ' .. Config.job_name,
			options = Options
		})
		lib.showContext(Config.job_name .. '_menu')
	end
end


RegisterKeyMapping(Config.job_name .. '_JobMenu', 'Job Menu', 'keyboard', Config.jobMenu)


--- Billing 





AddEventHandler('BX-' .. Config.job_name .. ':Facture', function()
    if Config.BillingUseCustomEvent then
    Config.BillingCustomEvent()
    else
        TriggerEvent('BX-' .. Config.job_name .. ':spawnPropTPE')
        createBill()
    end
end)







function createBill()
    local closestPerson = lib.getClosestPlayer(GetEntityCoords(cache.ped), 3, false)
    local job = ESX.PlayerData.job.name
    local access = false
    local senderSociety = 'society_' .. job
    access = true
    if not access then return end
     if not closestPerson then 
        TriggerEvent('BX-' .. Config.job_name .. ':removeProp') 
        Notify(Config.BillingTranslation.noPlayer)
        return
    end

    local input = lib.inputDialog(Config.BillingTranslation.billingTitle, {
        { type = "input",    label = Config.BillingTranslation.reason, placeholder = "..." },
        { type = "number",   label = Config.BillingTranslation.amount, default = 1 },
        { type = "checkbox", label = Config.BillingTranslation.sign },
    })

    if not input then 
        TriggerEvent('BX-' .. Config.job_name .. ':removeProp') 
        return
    end

    local reason = input[1]
    local amount = input[2]
    local conferm = input[3]

    if not reason then  
        Notify(Config.BillingTranslation.noReason) 
        TriggerEvent('BX-' .. Config.job_name .. ':removeProp') 
        return
    end
    if not amount or amount < 1 then  
        Notify(Config.BillingTranslation.noAmount) 
        TriggerEvent('BX-' .. Config.job_name .. ':removeProp')
        return
     end
    if not conferm then  
        Notify(Config.BillingTranslation.noSign) 
        TriggerEvent('BX-' .. Config.job_name .. ':removeProp') 
        return
    end

    local infoBox = lib.alertDialog({
        header = Config.BillingTranslation.confermBill,
        content = Config.BillingTranslation.amount ..
            ": $" .. amount .. "  \n" .. Config.BillingTranslation.reason .. ": " .. reason .. "  \n" ..
            Config.BillingTranslation.sign .. ": *𝙊𝙠*",
        centered = false,
        cancel = true
    })

    if infoBox ~= "confirm" then 
        Notify(Config.BillingTranslation.billCanceled) 
        TriggerEvent('BX-' .. Config.job_name .. ':removeProp') 
        return
    end

    if lib.progressBar({
            duration = 2000,
            label = Config.BillingTranslation.creatingBill,
            useWhileDead = false,
            allowCuffed = false,
            allowFalling = false,
            canCancel = false,
            disable = {
                car = true,
            },
            
        })
    then
        TriggerServerEvent("BX-" .. Config.job_name .. ":giveBillingItem", GetPlayerServerId(closestPerson), reason, job, amount)
        Notify(Config.BillingTranslation.billCreated .. amount)
        TriggerEvent('BX-' .. Config.job_name .. ':removeProp')
    else
        TriggerEvent('BX-' .. Config.job_name .. ':removeProp')
        Notify(Config.BillingTranslation.billCanceled)
    end
end



function useBillingItem(data)
    exports.ox_inventory:useItem(data, function(data)
        local metadata = data.metadata

        if metadata.status == Config.BillingTranslation.notPaid then
            local amount = metadata.amount
            local content =
                Config.BillingTranslation.createdFrom ..
                metadata.from ..
                Config.BillingTranslation.fSociety ..
                metadata.society ..
                Config.BillingTranslation.fAmount ..
                amount ..
                Config.BillingTranslation.fReason ..
                metadata.reason ..
                Config.BillingTranslation.fDate ..
                metadata.date

            local alert = lib.alertDialog({
                header = Config.BillingTranslation.bill,
                content = content,
                centered = false,
                cancel = true
            })

            if alert == "confirm" then
                if lib.progressBar({
                        duration = 2000,
                        label = Config.BillingTranslation.checkingDetails,
                        useWhileDead = false,
                        allowCuffed = false,
                        allowFalling = false,
                        canCancel = false,
                        disable = {
                            mouse = true,
                        },
                        anim = {
                            dict = 'missfam4',
                             clip = 'base'
                        },
                         prop = {
                         model = `p_amb_clipboard_01`,
                            pos = vec3(0.03, 0.03, 0.02),
                            rot = vec3(0.0, 0.0, -1.5)
                        },
                    }) then
                    local input = lib.inputDialog(Config.BillingTranslation.paymentMethod, {
                        {
                            type = 'select',
                            label = Config.BillingTranslation.selectMethod,
                            options = {
                                { value = 'money', label = Config.BillingTranslation.payCash },
                                { value = 'bank',  label = Config.BillingTranslation.payBank },
                            }
                        },
                    })

                    if not input then return end

                    local method = input[1]

                    if not method then return Notify(Config.BillingTranslation.noMethod) end

                    local lastConfermation = lib.alertDialog({
                        header = Config.BillingTranslation.bill,
                        content = Config.BillingTranslation.conferPayment .. amount,
                        centered = false,
                        cancel = true
                    })

                    if lastConfermation == "confirm" then
                        TriggerServerEvent("BX-" .. Config.job_name .. ":payBill", method, data)
                    end
                end
            else
                Notify(Config.BillingTranslation.wrong)
            end
        else
            Notify(Config.BillingTranslation.alreadyPaid)
        end
    end)
end

function displayMetadata()
    exports.ox_inventory:displayMetadata({
        reason  = Config.BillingTranslation.mreason,
        society = Config.BillingTranslation.msociety,
        from    = Config.BillingTranslation.mfrom,
        amount  = Config.BillingTranslation.mamount,
        date    = Config.BillingTranslation.mdate,
        status  = Config.BillingTranslation.mstatus,
        paidon  = Config.BillingTranslation.mPaidDate,
    })
end

if Config.IsTheFirstScript then

    exports('useBillingItem', useBillingItem) 

end


RegisterNetEvent('BX-' .. Config.job_name .. ':spawnPropTPE', function()
    local ped = cache.ped
    local coords = GetEntityCoords(ped)
    lib.requestModel('bzzz_prop_payment_terminal', 300)
    lib.requestAnimDict('cellphone@', 100)
    payTerminal = CreateObject(`bzzz_prop_payment_terminal`, coords.x, coords.y, coords.z, true, true, false)
    AttachEntityToEntity(payTerminal, ped, GetPedBoneIndex(ped, 57005), 0.18, 0.01, 0.0, -54.0, 220.0, 43.0, false, false, false, false, 1, true)
    TaskPlayAnim(ped, 'cellphone@', 'cellphone_text_read_base', 8.0, 1.0, -1, 49, 0, false, false, false)
end)

RegisterNetEvent('BX-' .. Config.job_name .. ':removeProp', function()
    local ped = cache.ped
    DeleteEntity(payTerminal)
    ClearPedTasks(ped)
end)








--- Annonce Menu


AddEventHandler('BX-' .. Config.job_name .. 'Annonce', function()
    createAnnouncementMenu()
end)




function createAnnouncementMenu()
    local playerJob = ESX.PlayerData.job.name
    local isJobAllowed = false

    for _, job in ipairs(Config.JobAnnonce) do
        if playerJob == job.name then 
            isJobAllowed = true
            break
        end
    end
    local input = lib.inputDialog("Annonce " .. playerJob, { 
        { type = "input", label = Strings['anounce'], placeholder = Strings['anounce_desc'], required = true },
    })

    if not input then
        lib.closeInputDialog()
        return
    end
    local textEntered = input[1]
    local jobDetails = nil
    for _, job in ipairs(Config.JobAnnonce) do
        if playerJob == job.name then
            jobDetails = job
            break
        end
    end

    if jobDetails then
        local label = jobDetails.label
        local icon = jobDetails.icon
        local messageLabel = jobDetails.messageLabel
        TriggerServerEvent('BX-' .. Config.job_name ..':passer_annonce', label, messageLabel, textEntered, icon)
    end

    lib.closeInputDialog()
end



--- Mission 


local BlipMissionPoint = nil

    local function createBlipMissionPoint()
        if not Config.BlipMissionPoint.visible then
            return
        end

        if BlipMissionPoint then
            RemoveBlip(BlipMissionPoint)
        end

        BlipMissionPoint = AddBlipForCoord(Config.BlipMissionPoint.coords)

        SetBlipSprite(BlipMissionPoint, Config.BlipMissionPoint.sprite)
        SetBlipScale(BlipMissionPoint, Config.BlipMissionPoint.scale)
        SetBlipColour(BlipMissionPoint, Config.BlipMissionPoint.color)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.BlipMissionPoint.name)
        EndTextCommandSetBlipName(BlipMissionPoint)
        SetBlipAsShortRange(BlipMissionPoint, true)
    end

    local function updateVisibilityBlipMissionPoint()
        if Config.BlipMissionPoint.visible then
            if not BlipMissionPoint then
                createBlipMissionPoint()
            end
        else
            if BlipMissionPoint then
                RemoveBlip(BlipMissionPoint)
                BlipMissionPoint = nil
            end
        end
    end



AddEventHandler('BX-' .. Config.job_name .. ':openJobMission', function()
    if dutyStatut then
    openJobMission()
    else
        Notify(Strings['no_service'], 'error')
    end
end)




openJobMission = function()
	if ESX.PlayerData.job.name == Config.job_name then
		local Options = {

			{
				title = Strings['start'],
				icon = 'fa-solid fa-toggle-on',
				
                onSelect = function()
                    if lib.progressCircle({
                        duration = 5000,
                        position = 'bottom',
                        useWhileDead = false,
                        canCancel = true,
                        disable = { car = true },
                        anim = { dict = 'missheistdockssetup1ig_5@talk', clip = 'hey_guys_floyd' },
                    }) then 
                        TriggerEvent('BX-' .. Config.job_name .. ':missionOn')
                    else 
                end
            end
                
                
                
			},
            {
				title = Strings['stop'],
				icon = 'fa-solid fa-toggle-off',
                onSelect = function()
                    if lib.progressCircle({
                        duration = 5000,
                        position = 'bottom',
                        useWhileDead = false,
                        canCancel = true,
                        disable = { car = true },
                        anim = { dict = 'missheistdockssetup1ig_5@talk', clip = 'hey_guys_floyd' },
                    }) then 
                        TriggerEvent('BX-' .. Config.job_name .. ':missionOff')
                    else 
                end
            end
			}
		}
		
		lib.registerContext({
			id = Config.job_name .. '_mission',
			title = 'Mission ' .. Config.job_name,
			options = Options
		})
		lib.showContext(Config.job_name .. '_mission')
	end
end



--- Duty 


AddEventHandler('BX-' .. Config.job_name .. ':openJobDuty', function()
    openJobDuty()
end)




openJobDuty = function()
	if ESX.PlayerData.job.name == Config.job_name then
		local Options = {
            {
				title = Strings['back'],
				icon = 'arrow-left',
				event = 'BX-' .. Config.job_name .. ':openJobMenu',
			},
			{
				title = Strings['duty_on'],
				icon = 'fa-solid fa-toggle-on',
				event = 'BX-' .. Config.job_name .. ':DutyOn',
			},
            {
				title = Strings['duty_off'],
				icon = 'fa-solid fa-toggle-off',
				event = 'BX-' .. Config.job_name .. ':DutyOff',
			}
		}
		
		lib.registerContext({
			id = Config.job_name .. '_duty',
			title =  Config.job_name,
			options = Options
		})
		lib.showContext(Config.job_name .. '_duty')
	end
end


AddEventHandler('BX-' .. Config.job_name .. ':DutyOn', function()
    dutyStatut = true
    createBlipShop()
    createBlipMissionPoint()
    createBlip()
    addHarvestZones()
    TriggerServerEvent('BX-' .. Config.job_name .. ':playerOnDuty', GetPlayerName(PlayerId()))
end)


AddEventHandler('BX-' .. Config.job_name .. ':DutyOff', function()
    dutyStatut = false
    StopDeliveryMission()
    updateBlipVisibility()
    updateVisibilityBlipShop()
    updateVisibilityBlipMissionPoint()
    clearAllPropsAndDisableHarvesting()
    TriggerServerEvent('BX-' .. Config.job_name .. ':playerOnDutyOff', GetPlayerName(PlayerId()))
end)



RegisterNetEvent('BX-' .. Config.job_name .. ':notifyOnDuty')
AddEventHandler('BX-' .. Config.job_name .. ':notifyOnDuty', function(playerName)
   -- ESX.ShowNotification(playerName .. Strings['start_duty'])
    Notify(playerName .. Strings['start_duty'], 'success')
end)


RegisterNetEvent('BX-' .. Config.job_name .. ':playerOnDutyOff')
AddEventHandler('BX-' .. Config.job_name .. ':playerOnDutyOff', function(playerName)
   -- ESX.ShowNotification(playerName .. Strings['quit_duty'])
    Notify(playerName .. Strings['quit_duty'], 'warning')
end)



--- Place Object


AddEventHandler('BX-' .. Config.job_name .. 'object', function()
    placeObjectsMenu(vehicle)
end)


placeObjectsMenu = function()
    local options = {
        {
            title = Strings['back'],
            icon = 'arrow-left',
            event = 'BX-' .. Config.job_name .. ':openJobMenu',
        },
    }
    for i=1, #Config.Props do 
        local data = Config.Props[i]
            data.arrow = false
            data.event = "BX-" .. Config.job_name .. ":spawnProp"
            data.args = i
            options[#options + 1] = data
    end
    lib.registerContext({
        id = 'BX-' .. Config.job_name .. '_object_menu',
        title = Strings['place_object'],
        options = options
    })
    lib.showContext('BX-' .. Config.job_name .. '_object_menu')
end

AddEventHandler('BX-' .. Config.job_name .. ':takeobject', function()
    Config.TakeObjectCustomEvent()
end)

AddEventHandler('BX-' .. Config.job_name .. ':placeObjects', function()
    placeObjectsMenu()
end)


AddEventHandler('BX-' .. Config.job_name .. ':spawnProp', function(index)
    local prop = Config.Props[index]
    local playerPed = PlayerPedId()
    local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)
    print(prop.model)
    ESX.Game.SpawnObject(prop.model, objectCoords, function(obj)
        SetEntityHeading(obj, GetEntityHeading(playerPed))
        PlaceObjectOnGroundProperly(obj)
        FreezeEntityPosition(obj, true)
    end)
end)


CreateThread(function()
    local movingProp = false
    function isEntityProp(ent)
        local model = GetEntityModel(ent)
        for i=1, #Config.Props do 
            if model == Config.Props[i].model then 
                return true, i
            end
        end
    end
    function RequestNetworkControl(entity)
        NetworkRequestControlOfEntity(entity)
        local timeout = 2000
        while timeout > 0 and not NetworkHasControlOfEntity(entity) do
            Wait(100)
            timeout = timeout - 100
        end
        SetEntityAsMissionEntity(entity, true, true)
        local timeout = 2000
        while timeout > 0 and not IsEntityAMissionEntity(entity) do
            Wait(100)
            timeout = timeout - 100
        end
        return NetworkHasControlOfEntity(entity)
    end
    while true do 
        local wait = 2500
        local ped = cache.ped
        local pcoords = GetEntityCoords(ped)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.job_name then
            if (not movingProp) then 
                local objPool = GetGamePool('CObject')
                for i = 1, #objPool do
                    local ent = objPool[i]
                    local prop, index = isEntityProp(ent)
                    if (prop) then 
                        local dist = #(GetEntityCoords(ent) - pcoords)
                        if dist < 1.75 and not IsPedInAnyVehicle(ped, false) then 
                            wait = 0
                            ESX.ShowHelpNotification(Strings['move_prop'])
                            if IsControlJustPressed(1, 51) then 
                                RequestNetworkControl(ent)
                                movingProp = ent
                                local c, r = vec3(0.0, 1.0, -1.0), vec3(0.0, 0.0, 0.0)
                                AttachEntityToEntity(movingProp, ped, ped, c.x, c.y, c.z, r.x, r.y, r.z, false, false, false, false, 2, true)
                                break
                            elseif IsControlJustPressed(1, 47) then
                                RequestNetworkControl(ent)
                                DeleteObject(ent)
                                break
                            end
                        end
                    end
                end
            else
                wait = 0
                ESX.ShowHelpNotification(Strings['take_prop'])
                if IsControlJustPressed(1, 51) then 
                    RequestNetworkControl(movingProp)
                    DetachEntity(movingProp)
                    PlaceObjectOnGroundProperly(movingProp)
                    FreezeEntityPosition(movingProp, true)
                    movingProp = nil
                end
            end
        end
        Wait(wait)
    end
end)





--VETEMENT--

AddEventHandler('BX-' .. Config.job_name .. ':Outfit', function()
    Config.CustomOutfitEvent()
end)



if Config.CustomCloth == "standalone" or Config.CustomCloth == "custom" then




    


    exports.ox_target:addBoxZone({
        coords = Config.ClothRoom,
        size = vec3(2, 2, 2),
        rotation = 45,
        options = {
            {
                name = Strings['outfit_job'].. Config.job_name,
                event = 'ox_target:debug',
                -- icon = 'fa-solid fa-cars',
                label = Strings['outfit_job'],
                groups = Config.job_name,
                distance = Config.DistanceOxTarget,
                onSelect = function(data)
                    if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.job_name then
                        if Config.CustomCloth == "standalone" then
                        lib.showContext(Config.job_name .. Strings['outfit_job'])
                        elseif Config.CustomCloth == "custom" then
                            TriggerEvent('BX-' .. Config.job_name .. ':Outfit')
                        end

                    end
                end
            }
        }
    })

    lib.registerContext({
        id = Config.job_name ..Strings['outfit_job'],
        title = Strings['outfit_job'],
        options = {
            {
                title = Strings['outfit_job_c'],
                -- icon = 'shirt',
                onSelect = function()
                    ESX.TriggerServerCallback('BX-' .. Config.job_name .. ':getPlayerSkin', function(skin)
                        if skin then
                            TriggerEvent('BX-' .. Config.job_name .. ':applyOutfit', skin)
                        else
                            print('No skin data found.')
                        end
                    end)
                end,
            },
            {
                title = Strings['outfit_job_w'],
                -- icon = 'vest',
                onSelect = function()
                    TriggerServerEvent('BX-' .. Config.job_name ..':getWorkOutfits')
                end,
            }
        }
    })


    RegisterNetEvent('BX-' .. Config.job_name ..':showWorkOutfits')
    AddEventHandler('BX-' .. Config.job_name ..':showWorkOutfits', function(outfits)
        local options = {
            {
                title = Strings['back'],
                icon = 'arrow-left',
                onSelect = function()
                    lib.showContext(Config.job_name .. Strings['outfit_job'])
                end,
            }
        }

        for _, outfitData in ipairs(outfits) do
            table.insert(options, {
                title = Strings['outfit_job'] .. outfitData.grade,
                description = Strings['apply'],
                -- icon = 'vest',
                onSelect = function()
                    TriggerServerEvent('BX-' .. Config.job_name ..':changeOutfit', 'work', outfitData.grade)
                end,
            })
        end

        lib.registerContext({
            id = Config.job_name ..'WorkOutfits',
            title = Strings['outfit_job'],
            options = options
        })

        lib.showContext(Config.job_name ..'WorkOutfits')
    end)



    RegisterNetEvent('BX-' .. Config.job_name .. ':applyOutfit')
AddEventHandler('BX-' .. Config.job_name .. ':applyOutfit', function(outfit)
    local playerPed = PlayerPedId()

    SetPedComponentVariation(playerPed, 8, outfit["tshirt_1"], outfit["tshirt_2"], 0) -- Tshirt
    SetPedComponentVariation(playerPed, 3, outfit["torso_1"], outfit["torso_2"], 0) -- Torso
    SetPedComponentVariation(playerPed, 4, outfit["pants_1"], outfit["pants_2"], 0) -- Pants
    SetPedComponentVariation(playerPed, 6, outfit["shoes_1"], outfit["shoes_2"], 0) -- Shoes

    if outfit["decals_1"] and outfit["decals_2"] then
        SetPedDecoration(playerPed, outfit["decals_1"], outfit["decals_2"]) -- Décals
    end

    if outfit["helmet_1"] and outfit["helmet_2"] then
        SetPedPropIndex(playerPed, 0, outfit["helmet_1"], outfit["helmet_2"], true) -- Helmet
    end

    if outfit["glasses_1"] and outfit["glasses_2"] then
        SetPedPropIndex(playerPed, 1, outfit["glasses_1"], outfit["glasses_2"], true) -- Glasses
    end

end)


end







----- MISSION ---- 




if Config.Mission then





    function LoadModel(model)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(1)
        end
    end

    Citizen.CreateThread(function()
        LoadModel(Config.MissionPedModel)
        local ped = CreatePed(4, Config.MissionPedModel, Config.MissionPedPosition.x, Config.MissionPedPosition.y, Config.MissionPedPosition.z, Config.MissionPedHeading, false, true)
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, false)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)

        exports.ox_target:addBoxZone({
            coords = vec3(Config.MissionPedPosition.x, Config.MissionPedPosition.y, Config.MissionPedPosition.z+1.0),
            size = vec3(1, 1, 2),
            rotation = Config.MissionPedHeading,
            options = {
                {
                    name = 'BX-' .. Config.job_name ..':Mission',
                    event = 'BX-' .. Config.job_name .. ':openJobMission',
                    -- icon = 'fa-solid fa-shopping-cart',
                    groups = Config.job_name,
                    distance = Config.DistanceOxTarget,
                    label = Strings['mission']
                    
                }
            }
        })
    end)





    local currentDeliveryPoint = nil
    local currentPed = nil
    local onDeliveryMission = false
    function StartDeliveryMission()
        if onDeliveryMission then
            Notify(Strings['in_mission'], 'error')
            return
        end

        onDeliveryMission = true
        SetNextDeliveryPoint()
    end

    function StopDeliveryMission()
        if currentDeliveryPoint then
            Notify(Strings['mission_cancel'], 'error')
            RemoveBlip(currentDeliveryPoint)
            currentDeliveryPoint = nil
        end
        if currentPed then
            DeleteEntity(currentPed)
            currentPed = nil
        end
        onDeliveryMission = false
    end


    local lastPositionIndex = nil 

    function SetNextDeliveryPoint()
        if currentDeliveryPoint then
            RemoveBlip(currentDeliveryPoint)
        end

        if currentPed then
            DeleteEntity(currentPed)
            currentPed = nil
        end
        local posIndex
        repeat
            posIndex = math.random(#Config.NPCPositions)
        until #Config.NPCPositions == 1 or posIndex ~= lastPositionIndex
        lastPositionIndex = posIndex 

        local deliveryCoords = Config.NPCPositions[posIndex]

        currentDeliveryPoint = AddBlipForCoord(deliveryCoords.x, deliveryCoords.y, deliveryCoords.z)
        SetBlipRoute(currentDeliveryPoint, true)

        Notify(Strings['delivery_notification'], 'info')
        CreateDeliveryNPC(deliveryCoords) 
    end


    function CreateDeliveryNPC(coords)
        local pedModel = `a_m_y_business_01`
        RequestModel(pedModel)

        while not HasModelLoaded(pedModel) do
            Wait(0)
        end

        currentPed = CreatePed(4, pedModel, coords.x, coords.y, coords.z-1.0, coords.z, false, true)
        TaskStartScenarioInPlace(currentPed, "CODE_HUMAN_CROSS_ROAD_WAIT", 0, false) -- CODE_HUMAN_CROSS_ROAD_WAIT / WORLD_HUMAN_STAND_IMPATIENT
        --TaskPlayAnim(currentPed, animDict1, 'pickupwait', 8.0, -8.0, 2000, 32, 0, false, false, false) 
        FreezeEntityPosition(currentPed, true)
        SetEntityAsMissionEntity(currentPed, true, true)
        SetBlockingOfNonTemporaryEvents(currentPed, true)
        
        exports.ox_target:addBoxZone({
            name = Strings['delivery'],
            coords = vector3(coords.x, coords.y, coords.z+0.55),
            size = vector3(2, 2, 2),
            rotation = 45,
            options = {
                {
                    name = Strings['delivery'],
                    event = 'delivery:exchangeItem',
                    -- icon = 'fa-solid fa-box',
                    label = Strings['delivery'],
                    groups = Config.job_name,
                    distance = Config.DistanceOxTarget,
                    onSelect = function(data)
                        if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.job_name then
                            TriggerServerEvent('BX-' .. Config.job_name .. 'delivery:exchangeItem')
                        end
                    end
                }
            }
        })
    end

    RegisterNetEvent('BX-' .. Config.job_name .. 'delivery:exchangeItem')
    AddEventHandler('BX-' .. Config.job_name .. 'delivery:exchangeItem', function()
        
        if onDeliveryMission then
            ESX.TriggerServerCallback('BX-' .. Config.job_name .. 'delivery:completeExchange', function(success)
                if success then
                    if currentPed and DoesEntityExist(currentPed) then
                        local playerPed = PlayerPedId()
                        local pedCoords = GetEntityCoords(currentPed)
                        local animDict = 'mp_common'
                        RequestAnimDict(animDict)
                        while not HasAnimDictLoaded(animDict) do
                            Wait(100) 
                        end
                        FreezeEntityPosition(currentPed, false)
                        TaskPlayAnim(currentPed, animDict, 'givetake2_a', 8.0, -8.0, -1, 32, 0, false, false, false)
                        TaskPlayAnim(playerPed, animDict, 'givetake2_a', 8.0, -8.0, 2000, 32, 0, false, false, false)
                        Citizen.Wait(2000)
                        ClearPedTasksImmediately(playerPed)
                        ClearPedTasksImmediately(currentPed)
                        exports.ox_target:removeZone(Strings['delivery'])
                        Notify(Strings['delivery_complete'], 'success')
                        RemoveBlip(currentDeliveryPoint)
                        local wanderRadius = 100.0 
                       TaskWanderInArea(currentPed, pedCoords, wanderRadius, 0, 0)
                        Wait(10000)

                        DeleteEntity(currentPed)
                        currentPed = nil
                    end
                    SetNextDeliveryPoint()
                else
                    Notify(Strings['no_item'], 'error')
                end
            end)
        else
            Notify(Strings['no_in_mission'], 'error')
        end
    end)

   

    AddEventHandler('BX-' .. Config.job_name .. ':missionOn', function()
        StartDeliveryMission()
    end)

    AddEventHandler('BX-' .. Config.job_name .. ':missionOff', function()
        StopDeliveryMission()
    end)


end



