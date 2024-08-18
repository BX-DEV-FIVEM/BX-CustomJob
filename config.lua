--[[
$$$$$$$\  $$\   $$\         $$$$$$\  $$\   $$\  $$$$$$\ $$$$$$$$\  $$$$$$\  $$\      $$\    $$$$$\  $$$$$$\  $$$$$$$\  
$$  __$$\ $$ |  $$ |       $$  __$$\ $$ |  $$ |$$  __$$\\__$$  __|$$  __$$\ $$$\    $$$ |   \__$$ |$$  __$$\ $$  __$$\ 
$$ |  $$ |\$$\ $$  |       $$ /  \__|$$ |  $$ |$$ /  \__|  $$ |   $$ /  $$ |$$$$\  $$$$ |      $$ |$$ /  $$ |$$ |  $$ |
$$$$$$$\ | \$$$$  /$$$$$$\ $$ |      $$ |  $$ |\$$$$$$\    $$ |   $$ |  $$ |$$\$$\$$ $$ |      $$ |$$ |  $$ |$$$$$$$\ |
$$  __$$\  $$  $$< \______|$$ |      $$ |  $$ | \____$$\   $$ |   $$ |  $$ |$$ \$$$  $$ |$$\   $$ |$$ |  $$ |$$  __$$\ 
$$ |  $$ |$$  /\$$\        $$ |  $$\ $$ |  $$ |$$\   $$ |  $$ |   $$ |  $$ |$$ |\$  /$$ |$$ |  $$ |$$ |  $$ |$$ |  $$ |
$$$$$$$  |$$ /  $$ |       \$$$$$$  |\$$$$$$  |\$$$$$$  |  $$ |    $$$$$$  |$$ | \_/ $$ |\$$$$$$  | $$$$$$  |$$$$$$$  |
\_______/ \__|  \__|        \______/  \______/  \______/   \__|    \______/ \__|     \__| \______/  \______/ \_______/                                                                                                                                                                                                                                                                                                                                                                
]]--

--- Check installation/ folder for installation --


Config = {}


--[[


 $$$$$$\  $$$$$$$$\ $$$$$$$$\ $$$$$$$$\ $$$$$$\ $$\   $$\  $$$$$$\  
$$  __$$\ $$  _____|\__$$  __|\__$$  __|\_$$  _|$$$\  $$ |$$  __$$\ 
$$ /  \__|$$ |         $$ |      $$ |     $$ |  $$$$\ $$ |$$ /  \__|
\$$$$$$\  $$$$$\       $$ |      $$ |     $$ |  $$ $$\$$ |$$ |$$$$\ 
 \____$$\ $$  __|      $$ |      $$ |     $$ |  $$ \$$$$ |$$ |\_$$ |
$$\   $$ |$$ |         $$ |      $$ |     $$ |  $$ |\$$$ |$$ |  $$ |
\$$$$$$  |$$$$$$$$\    $$ |      $$ |   $$$$$$\ $$ | \$$ |\$$$$$$  |
 \______/ \________|   \__|      \__|   \______|\__|  \__| \______/ 
                                                                    
                                                                    
                                                                                                           
]]--

Config.Notify = 'esx' -- 'ox' / 'okok' / 'esx'

Config.CheckUpdate = true -- checking uptade

Config.jobMenu = 'F6'


Config.Blip = { -- Blip society
	Pos     = { x = 283.2792, y = -977.9730, z = 29.4334}, 
	Sprite  = 106,
	Display = 4,
	Scale   = 0.7,
	Colour  = 2,
}


Config.BossPos = vector3(288.4131, -990.0044, 29.3260) -- rank must be "boss"

Config.JobAnnonce = {  -- Job Announce
     { name = "job_name", label = "JobName", icon = "CHAR_JOSH", iconType = "native", messageLabel = "~g~Announce JobName~w~ " },
}

Config.job_name = "job_name"

Config.job_label = "JobName"

Config.society_name = "society_job_name"

Config.jobMenu = 'F6'




--[[
$$$$$$$\  $$$$$$\ $$\       $$\       $$$$$$\ $$\   $$\  $$$$$$\  
$$  __$$\ \_$$  _|$$ |      $$ |      \_$$  _|$$$\  $$ |$$  __$$\ 
$$ |  $$ |  $$ |  $$ |      $$ |        $$ |  $$$$\ $$ |$$ /  \__|
$$$$$$$\ |  $$ |  $$ |      $$ |        $$ |  $$ $$\$$ |$$ |$$$$\ 
$$  __$$\   $$ |  $$ |      $$ |        $$ |  $$ \$$$$ |$$ |\_$$ |
$$ |  $$ |  $$ |  $$ |      $$ |        $$ |  $$ |\$$$ |$$ |  $$ |
$$$$$$$  |$$$$$$\ $$$$$$$$\ $$$$$$$$\ $$$$$$\ $$ | \$$ |\$$$$$$  |
\_______/ \______|\________|\________|\______|\__|  \__| \______/ 
                                                                                                                                                                                                  
]]--

Config.Billing = true

Config.BillingUseCustomEvent = false -- if false use BX-billing system ( inclued on this script )  / if true edit Config.BillingCustomEvent



-- If Config.BillingUseCustomEvent = false --

-- Check installation.md to add item to use BX-billing system


Config.UseDiscordLogs = true

Config.JobWebhooks = "https://discord.com/api/webhooks/****"
   
Config.IsTheFirstScript = true -- set true for the first BX-CutstomJob, if you dulicate the script, turn off

Config.BillingItem = "billing" -- item to pay bill

Config.MetadataOnItem = true


-- If Config.BillingUseCustomEvent = true --

Config.BillingCustomEvent = function() -- if Config.Billing = true

    print("cc")
	-- EDIT THIS
end



--[[
 $$$$$$\  $$$$$$$\   $$$$$$\  $$$$$$$$\ $$$$$$$$\ 
$$  __$$\ $$  __$$\ $$  __$$\ $$  _____|\__$$  __|
$$ /  \__|$$ |  $$ |$$ /  $$ |$$ |         $$ |   
$$ |      $$$$$$$  |$$$$$$$$ |$$$$$\       $$ |   
$$ |      $$  __$$< $$  __$$ |$$  __|      $$ |   
$$ |  $$\ $$ |  $$ |$$ |  $$ |$$ |         $$ |   
\$$$$$$  |$$ |  $$ |$$ |  $$ |$$ |         $$ |   
 \______/ \__|  \__|\__|  \__|\__|         \__|                                                                                                       
]]--



Config.fridge = vector3(283.2792, -977.9730, 29.4334) -- pos stock

Config.craft1 = vector3(289.4341, -983.7943, 29.4348)-- pos craft 1

Config.craft2 = vector3(286.4610, -983.5110, 29.3953)-- pos craft 2


Config.CraftItems1 = {
    {
        craftItems = {'name_item', 'name_item', 'name_item', 'name_item', 'name_item',},
        rewardItem = 'name_item',
        title = '🍅 name_item',
        description = 'name_item x 5 ',
    },
    {
        craftItems = {'name_item', 'name_item', 'name_item', 'name_item'},
        rewardItem = 'name_item',
        title = '🥫 name_item',
        description = 'name_item x 4',
    },
    {
        craftItems = {'name_item', 'name_item', 'name_item', 'name_item'},
        rewardItem = 'name_item',
        title = '🍞 name_item',
        description = 'name_item + name_item + name_item + name_item',
    },
    -- You can add more 
}

Config.CraftItems2 = {
    {
        craftItems = {'name_item', 'name_item', 'name_item', 'name_item'},
        rewardItem = 'name_item',
        title = '🍕 name_item',
        description = 'name_item + name_item+ name_item + name_item',
    },
    
    -- You can add more 
}



--[[
$$\   $$\  $$$$$$\  $$$$$$$\  $$\    $$\ $$$$$$$$\  $$$$$$\ $$$$$$$$\ 
$$ |  $$ |$$  __$$\ $$  __$$\ $$ |   $$ |$$  _____|$$  __$$\\__$$  __|
$$ |  $$ |$$ /  $$ |$$ |  $$ |$$ |   $$ |$$ |      $$ /  \__|  $$ |   
$$$$$$$$ |$$$$$$$$ |$$$$$$$  |\$$\  $$  |$$$$$\    \$$$$$$\    $$ |   
$$  __$$ |$$  __$$ |$$  __$$<  \$$\$$  / $$  __|    \____$$\   $$ |   
$$ |  $$ |$$ |  $$ |$$ |  $$ |  \$$$  /  $$ |      $$\   $$ |  $$ |   
$$ |  $$ |$$ |  $$ |$$ |  $$ |   \$  /   $$$$$$$$\ \$$$$$$  |  $$ |   
\__|  \__|\__|  \__|\__|  \__|    \_/    \________| \______/   \__|   
                                                                                                                                                                                                                  
]]--


Config.BlipHarvestPoints = { --- blip BlipHarvestPoints --- 
    coords = vector3(2490.7817, 4841.7964, 35.5231), 
    sprite = 280,   -- Blip icon 
    scale = 0.7,  -- Blip size
    color = 2,    -- Blip color
    name = "~g~Business ~w~ | Farm",
    visible = true -- Visible or not -- If true( only visible when player are on duty )
}



Config.HarvestTime = 5000  -- Time in ms

Config.TimeToNextHarvest = 10000   -- Time in ms





Config.HarvestPoints = {
    { x = 2494.7446, y = 4833.2573, z = 35.4294, item = 'name_item', label = 'Take name_item', animation = 'WORLD_HUMAN_GARDENER_PLANT', prop = 'sf_prop_sf_apple_01a' }, 
    { x = 2489.7446, y = 4838.2573, z = 35.4294, item = 'name_item', label = 'Take name_item', animation = 'WORLD_HUMAN_GARDENER_PLANT', prop = 'sf_prop_sf_apple_01a' },  
    { x = 2492.7446, y = 4841.2573, z = 35.4294, item = 'name_item', label = 'Take name_item', animation = 'WORLD_HUMAN_GARDENER_PLANT', prop = 'sf_prop_sf_apple_01a' }, 
    { x = 2484.7446, y = 4835.4697, z = 35.4294, item = 'name_item', label = 'Take name_item', animation = 'WORLD_HUMAN_GARDENER_PLANT', prop = 'sf_prop_sf_apple_01a' }, 
    { x = 2499.7446, y = 4841.2573, z = 35.4294, item = 'name_item', label = 'Take name_item', animation = 'PROP_HUMAN_BUM_BIN', prop = 'prop_plant_fern_02a' }, 
    { x = 2494.7446, y = 4848.2573, z = 35.4294, item = 'name_item', label = 'Take name_item', animation = 'PROP_HUMAN_BUM_BIN', prop = 'prop_plant_fern_02a' }, 
    { x = 2492.7446, y = 4843.2573, z = 35.4294, item = 'name_item', label = 'Take name_item', animation = 'PROP_HUMAN_BUM_BIN', prop = 'prop_plant_fern_02a' },

    -- Find prop here : https://forge.plebmasters.de/objects

    -- Find animation here : https://forge.plebmasters.de/animations
   
}


--[[
 $$$$$$\   $$$$$$\  $$$$$$$\   $$$$$$\   $$$$$$\  $$$$$$$$\ 
$$  __$$\ $$  __$$\ $$  __$$\ $$  __$$\ $$  __$$\ $$  _____|
$$ /  \__|$$ /  $$ |$$ |  $$ |$$ /  $$ |$$ /  \__|$$ |      
$$ |$$$$\ $$$$$$$$ |$$$$$$$  |$$$$$$$$ |$$ |$$$$\ $$$$$\    
$$ |\_$$ |$$  __$$ |$$  __$$< $$  __$$ |$$ |\_$$ |$$  __|   
$$ |  $$ |$$ |  $$ |$$ |  $$ |$$ |  $$ |$$ |  $$ |$$ |      
\$$$$$$  |$$ |  $$ |$$ |  $$ |$$ |  $$ |\$$$$$$  |$$$$$$$$\ 
 \______/ \__|  \__|\__|  \__|\__|  \__| \______/ \________|                                                                                                                                                                                   
]]--

Config.target_garage = vector3(298.8515, -994.1096, 29.3037) -- pos garage

Config.garage_ped = vector3(298.8515, -994.1096, 28.3037) -- pos ped garage

Config.PedHeadingG = 171.83

Config.PedStyle = "csb_burgerdrug"

Config.car_pos = vector3(300.9442, -1000.1035, 29.2698) -- pos spawn vehicle

Config.car_posHeading = 210.0

Config.GarageVehicles = {
    { model = 'carname', title = '🛵 Scooter', description = 'Take scooter' },
    { model = 'carname', title = '🚛 Truck', description = 'Take truck' },
    -- Add more
}

Config.CutomVehicleKey = true -- if false no keys.

-- Give Keys
Config.CustomVehicleFunction = function(vehicle, plate, model) -- if Config.CutomVehicleKey = true
    print("Custom event triggered for vehicle: " .. model)
    print("Vehicle plate: " .. plate)
	-- EDIT THIS
end

-- Delete Keys
Config.CustomVehicleFunctionBack = function(vehicle, plate, model) -- if Config.CutomVehicleKey = true
    if plate then


	print("Custom event triggered for vehicle: " .. model)
    print("Vehicle plate: " .. plate)


    else
    end

	-- EDIT THIS
end




--[[
 $$$$$$\  $$\   $$\ $$$$$$$$\ $$$$$$$$\ $$$$$$\ $$$$$$$$\ 
$$  __$$\ $$ |  $$ |\__$$  __|$$  _____|\_$$  _|\__$$  __|
$$ /  $$ |$$ |  $$ |   $$ |   $$ |        $$ |     $$ |   
$$ |  $$ |$$ |  $$ |   $$ |   $$$$$\      $$ |     $$ |   
$$ |  $$ |$$ |  $$ |   $$ |   $$  __|     $$ |     $$ |   
$$ |  $$ |$$ |  $$ |   $$ |   $$ |        $$ |     $$ |   
 $$$$$$  |\$$$$$$  |   $$ |   $$ |      $$$$$$\    $$ |   
 \______/  \______/    \__|   \__|      \______|   \__|   
                                                                                                                                                                              
]]--


Config.CustomCloth = "standalone" -- If "custom" you must edit Config.CustomClothEvent / If "standalone" edit Config.JobOutfit  / IF "off" no JobOutfit

Config.ClothRoom = vector3(291.2554, -990.8323, 29.9411)

Config.CustomOutfitEvent = function() -- if CustomCloth = "custom"

    print("cc")
	-- EDIT THIS
end


Config.JobOutfit = { -- if CustomCloth = "standalone"
    [0] = { -- Grade 1
        ["tshirt_1"] = 1, ["tshirt_2"] = 0, ["shoes_1"] = 11,
        ["torso_1"] = 4, ["torso_2"] = 0, ["pants_1"] = 23,
        ["pants_2"] = 0, ["shoes_2"] = 12, ["decals_1"] = 60,
        ["decals_2"] = 0, ["sex"] = 0
    },
    [1] = { -- Grade 2
        ["tshirt_1"] = 1, ["tshirt_2"] = 0, ["shoes_1"] = 11,
        ["torso_1"] = 4, ["torso_2"] = 0, ["pants_1"] = 23,
        ["pants_2"] = 0, ["shoes_2"] = 12, ["decals_1"] = 60,
        ["decals_2"] = 0, ["sex"] = 0
    },
    [2] = { -- Grade 3
        ["tshirt_1"] = 1, ["tshirt_2"] = 0, ["shoes_1"] = 11,
        ["torso_1"] = 4, ["torso_2"] = 0, ["pants_1"] = 23,
        ["pants_2"] = 0, ["shoes_2"] = 12, ["decals_1"] = 60,
        ["decals_2"] = 0, ["sex"] = 0
    },
    [3] = { -- Grade 4
        ["tshirt_1"] = 1, ["tshirt_2"] = 0, ["shoes_1"] = 11,
        ["torso_1"] = 4, ["torso_2"] = 0, ["pants_1"] = 23,
        ["pants_2"] = 0, ["shoes_2"] = 12, ["decals_1"] = 60,
        ["decals_2"] = 0, ["sex"] = 0
    },
    [4] = { -- Grade 5
        ["tshirt_1"] = 51, ["tshirt_2"] = 0, ["shoes_1"] = 11,
        ["torso_1"] = 50, ["torso_2"] = 0, ["pants_1"] = 60,
        ["pants_2"] = 0, ["shoes_2"] = 12, ["decals_1"] = 20,
        ["decals_2"] = 0, ["sex"] = 0
    }
    -- Ajoutez d'autres grades si nécessaire
}




--[[
 $$$$$$\  $$\   $$\  $$$$$$\  $$$$$$$\  
$$  __$$\ $$ |  $$ |$$  __$$\ $$  __$$\ 
$$ /  \__|$$ |  $$ |$$ /  $$ |$$ |  $$ |
\$$$$$$\  $$$$$$$$ |$$ |  $$ |$$$$$$$  |
 \____$$\ $$  __$$ |$$ |  $$ |$$  ____/ 
$$\   $$ |$$ |  $$ |$$ |  $$ |$$ |      
\$$$$$$  |$$ |  $$ | $$$$$$  |$$ |      
 \______/ \__|  \__| \______/ \__|      
]]--




Config.ShopOn = true

Config.BlipShop = { --- blip BlipShop --- 
    coords = vector3(-2966.3254, 391.5275, 15.0433), 
    sprite = 52,   -- Blip icon 
    scale = 0.7,  -- Blip size
    color = 2,    -- Blip color
    name = "~g~Business ~w~ | Shop",
    visible = true -- Visible or not -- If true( only visible when player are on duty )
}



Config.PedPosition = { x = -2966.13, y = 391.32, z = 14.0 } -- NPC pos 
Config.PedHeading = 89.50 -- NPC heading
Config.PedModel = 'a_m_m_business_01' -- NPC model



Config.JobPed = {
    { label = "name_item", name = "name_item", price = 2 },
    { label = "name_item", name = "name_item", price = 5 },
    { label = "name_item", name = "name_item", price = 5 },
    { label = "name_item", name = "name_item", price = 7 },
    { label = "name_item", name = "name_item", price = 7 }
}







--[[
$$\      $$\ $$$$$$\  $$$$$$\   $$$$$$\  $$$$$$\  $$$$$$\  $$\   $$\  $$$$$$\  
$$$\    $$$ |\_$$  _|$$  __$$\ $$  __$$\ \_$$  _|$$  __$$\ $$$\  $$ |$$  __$$\ 
$$$$\  $$$$ |  $$ |  $$ /  \__|$$ /  \__|  $$ |  $$ /  $$ |$$$$\ $$ |$$ /  \__|
$$\$$\$$ $$ |  $$ |  \$$$$$$\  \$$$$$$\    $$ |  $$ |  $$ |$$ $$\$$ |\$$$$$$\  
$$ \$$$  $$ |  $$ |   \____$$\  \____$$\   $$ |  $$ |  $$ |$$ \$$$$ | \____$$\ 
$$ |\$  /$$ |  $$ |  $$\   $$ |$$\   $$ |  $$ |  $$ |  $$ |$$ |\$$$ |$$\   $$ |
$$ | \_/ $$ |$$$$$$\ \$$$$$$  |\$$$$$$  |$$$$$$\  $$$$$$  |$$ | \$$ |\$$$$$$  |
\__|     \__|\______| \______/  \______/ \______| \______/ \__|  \__| \______/ 
]]--

Config.Mission = true


Config.BlipMissionPoint = { --- blip BlipHarvestPoints --- 
    coords = vector3(284.1525, -976.2911, 29.4334),  
    sprite = 616,   -- Blip icon 
    scale = 0.5,  -- Blip size
    color = 2,    -- Blip color
    name = "~g~Business ~w~ | Mission",
    visible = false -- Visible or not -- If true( only visible when player are on duty )
}


Config.MissionPedPosition = { x = 284.1525, y = -976.2911, z = 28.3849 } -- NPC pos
Config.MissionPedHeading = 352.0 -- NPC heading
Config.MissionPedModel = 'a_m_m_business_01' -- NPC model

Config.MissionItem = 'name_item' -- Item to sell
Config.RewardMoney = 50 -- Reward Money
Config.CompanyRewardPercentage = 10 -- % for the society


Config.NPCPositions = {
    {x = 251.1446, y = -1004.38, z = 29.37, h = 100.0}, 
    {x = 271.62, y = -1141.17, z = 29.37, h = 100.0},
    {x = 386.86, y = -1112.85, z = 29.37, h = 100.0}, 
    -- Add more positions
}



--[[
 $$$$$$\  $$$$$$$\  $$$$$$$\  $$$$$$\ $$$$$$$$\ $$$$$$\  $$$$$$\  $$\   $$\  $$$$$$\  $$\       
$$  __$$\ $$  __$$\ $$  __$$\ \_$$  _|\__$$  __|\_$$  _|$$  __$$\ $$$\  $$ |$$  __$$\ $$ |      
$$ /  $$ |$$ |  $$ |$$ |  $$ |  $$ |     $$ |     $$ |  $$ /  $$ |$$$$\ $$ |$$ /  $$ |$$ |      
$$$$$$$$ |$$ |  $$ |$$ |  $$ |  $$ |     $$ |     $$ |  $$ |  $$ |$$ $$\$$ |$$$$$$$$ |$$ |      
$$  __$$ |$$ |  $$ |$$ |  $$ |  $$ |     $$ |     $$ |  $$ |  $$ |$$ \$$$$ |$$  __$$ |$$ |      
$$ |  $$ |$$ |  $$ |$$ |  $$ |  $$ |     $$ |     $$ |  $$ |  $$ |$$ |\$$$ |$$ |  $$ |$$ |      
$$ |  $$ |$$$$$$$  |$$$$$$$  |$$$$$$\    $$ |   $$$$$$\  $$$$$$  |$$ | \$$ |$$ |  $$ |$$$$$$$$\ 
\__|  \__|\_______/ \_______/ \______|   \__|   \______| \______/ \__|  \__|\__|  \__|\________|                                                                                              
]]--




Config.TakeObject = true -- Can take object


Config.TakeObjectCustomEvent = function() -- if Config.TakeObject = true

    ExecuteCommand("e carrypizza")
	-- EDIT THIS
end




Config.PlaceObject = true -- Can place object


Config.Props = { -- IF Config.PlaceObject = true  / Find prop here : https://forge.plebmasters.de/objects

    {
        title = '🗃️ Table', -- Label
        description = '', -- Description (optional)
        model = `prop_table_01` 
    },
    {
        title = '🗃️ Chair',
        description = '',
        model = `v_res_trev_framechair`
    },
    {
        title = '🗃️ Light',
        description = '',
        model = `prop_streetlight_07b`
    },
    {
        title = '🗃️ Pizza',
        description = '',
        model = `v_res_tt_pizzaplate`
    },

}




--[[
$$$$$$$$\ $$$$$$$\   $$$$$$\  $$\   $$\  $$$$$$\  $$\        $$$$$$\ $$$$$$$$\ $$$$$$\  $$$$$$\  $$\   $$\ 
\__$$  __|$$  __$$\ $$  __$$\ $$$\  $$ |$$  __$$\ $$ |      $$  __$$\\__$$  __|\_$$  _|$$  __$$\ $$$\  $$ |
   $$ |   $$ |  $$ |$$ /  $$ |$$$$\ $$ |$$ /  \__|$$ |      $$ /  $$ |  $$ |     $$ |  $$ /  $$ |$$$$\ $$ |
   $$ |   $$$$$$$  |$$$$$$$$ |$$ $$\$$ |\$$$$$$\  $$ |      $$$$$$$$ |  $$ |     $$ |  $$ |  $$ |$$ $$\$$ |
   $$ |   $$  __$$< $$  __$$ |$$ \$$$$ | \____$$\ $$ |      $$  __$$ |  $$ |     $$ |  $$ |  $$ |$$ \$$$$ |
   $$ |   $$ |  $$ |$$ |  $$ |$$ |\$$$ |$$\   $$ |$$ |      $$ |  $$ |  $$ |     $$ |  $$ |  $$ |$$ |\$$$ |
   $$ |   $$ |  $$ |$$ |  $$ |$$ | \$$ |\$$$$$$  |$$$$$$$$\ $$ |  $$ |  $$ |   $$$$$$\  $$$$$$  |$$ | \$$ |
   \__|   \__|  \__|\__|  \__|\__|  \__| \______/ \________|\__|  \__|  \__|   \______| \______/ \__|  \__|
]]--



Strings = { 
    

    ['Society_Name'] = '~g~Business ~w~ | ',

    -- MENU -- 
    ['boss_menu'] = '👑 Boss Menu',
    ['mission'] = '💥 Start a mission',
    ['buy_object'] = '🏪 Shop wholesaler',
    ['fridge'] = '❄️ Fridge',
    ['craft_use1'] = '🧂 Make food',
    ['craft_use2'] = '🍕 Make food',
    ['delivery'] = '📦 Delivery the food',
    ['garage'] = '🚗 Garage',
    ['menu_name1'] = '📢 Announcement',
    ['menu_name3'] = '🪑 Object',
    ['menu_name4'] = '🧾 Invoice',
    ['menu_name5'] = '🎫 Duty',
    ['outfit_job'] = '🦺 Job Outfit ',
    ['outfit_job_w'] = '🦺 See Job Outfit',
    ['outfit_job_c'] = '👕 Civilian',
    ['hand'] = '📦 Take an object',
    
    
    

    --- Notification 
    ['anounce'] = 'Announcement',
    ['anounce_desc'] = 'Make an announcement',
    ['craft_ok'] = 'Product made',
    ['buy'] = 'Product purchased',
    ['no_money'] = 'You don\'t have enough money.',
    ['in_reload'] = 'This point is reloading, please wait.',
    ['no_item'] = 'You don\'t have the required item.',
    ['mission_cancel'] = 'Delivery mission canceled.',
    ['no_job'] = 'You don\'t have the required job.',
    ['in_mission'] = 'You are already on a delivery mission.',
    ['no_in_mission'] = 'You are not on a delivery mission.',
    ['need_ingrédient'] = 'Not enough ingredients',
    ['no_service'] = 'You must be on duty',

    --- Menu Job --
    ['shop_name'] = 'Wholesaler',
    ['put_in'] = 'Store Vehicle',
    ['put_in_desc'] = 'Store your last vehicle',
    ['apply'] = 'Apply',
    ['back'] = 'Back',
    ['menu_desc1'] = 'Announcement panel',
    ['menu_name2'] = 'Delivery',
    ['menu_desc2'] = 'Start deliveries',
    ['menu_desc3'] = 'Place panel',
    ['menu_desc4'] = 'Create an invoice',
    ['menu_desc5'] = 'Go on duty',
    ['duty_on'] = 'ON',
    ['duty_off'] = 'OFF',
    ['quit_duty'] = ' left',
    ['start_duty'] = ' is now on duty. ',
    ['price'] = 'Price : ',
    ['shop'] = 'Shop',

    --- Prop ---
    ['place_object'] = 'Place an object',
    ['take_prop'] = '[G] - Pick up, [E] - Place.',
    ['move_prop'] = '[E] - Move the object, [G] - Pick up.',

    --- other
    ['craft_menu1'] = 'craft menu',
    ['craft1'] = ' Make food',
    ['craft2'] = ' Make pizza',
    ['delivery_notification'] = 'Customer found, head to the delivery point.',
    ['delivery_complete'] = 'Delivery completed, proceed to the next point.',
    ['start'] = 'Start Mission',
    ['stop'] = 'Stop Mission',
    
    
    
    ['sell_price'] = 'Sell Price',
    ['amount_input'] = 'Amount',
    ['inventory'] = 'Inventory',
    ['success'] = 'Success',
    ['item_stocked_desc'] = 'You stocked an item for $%s!',
}


--- Billing system , If Config.BillingUseCustomEvent = true

Config.BillingTranslation = {
    mreason      = ">> Reason",
    msociety     = ">> Society",
    mfrom        = ">> From",
    mamount      = ">> Amount",
    mdate        = ">> Creation Date",
    mstatus      = ">> Status",
    mPaidDate    = ">> Paid On",

    billingTitle = "Create Invoice",
    reason       = "Reason",
    amount       = "Amount",
    sign         = "Signature",

    confermBill  = "Confirm Billing Details",
    creatingBill = "Creating Invoice",
    billCreated  = "Invoice created for ",
    billCanceled = "[Error] Invoice creation canceled",
    noSign       = "[Error] Please sign the invoice",
    noReason     = "[Error] Please provide a reason",
    noAmount     = "[Error] Please enter a valid amount",
    noPlayer     = "[Error] No player nearby",

    noMoney      = "[Error] You do not have enough money",
    xnoMoney     = "The client does not have enough money",
    billPaid     = "The invoice has been paid for $",

    notPaid      = "Not Paid",
    bill         = "Invoice",

    createdFrom  = "Created by: ",
    fSociety     = "  \n  Society: ",
    fAmount      = "  \n Amount: ",
    fReason      = "  \n  Reason: ",
    fDate        = "  \n  *Date: *",

    checkingDetails = "Checking Details",
    paymentMethod   = "Payment Method",
    selectMethod    = "Select Method",
    payCash         = "Pay Cash",
    payBank         = "Pay by Bank Transfer",
    noMethod        = "Please select a payment method",
    conferPayment   = "Confirm payment of $",
    wrong           = "Something went wrong!?",
    paid            = "Paid",
    alreadyPaid     = "This invoice is already paid",
    
    
    createbilldiscord     = "BX-BILLING",
    createbilldiscord2    = "Log",
    created_by     = "created by",
    paidBill       = "Paid the bill of $",
    billfor        = "for",
    createbill     = "Create a bill of $",
    
    url = "https://discord.com/invite/Rnezhz8DVZ",
    png = "https://forum.cfx.re/user_avatar/forum.cfx.re/bx-dev/144/4289709_2.png",
}