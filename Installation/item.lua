--[[ 
$$$$$$\ $$$$$$$$\ $$$$$$$$\ $$\      $$\ 
\_$$  _|\__$$  __|$$  _____|$$$\    $$$ |
  $$ |     $$ |   $$ |      $$$$\  $$$$ |
  $$ |     $$ |   $$$$$\    $$\$$\$$ $$ |
  $$ |     $$ |   $$  __|   $$ \$$$  $$ |
  $$ |     $$ |   $$ |      $$ |\$  /$$ |
$$$$$$\    $$ |   $$$$$$$$\ $$ | \_/ $$ |
\______|   \__|   \________|\__|     \__|                                                                                




--- Here's how to add items to your server --




 $$$$$$\  $$\   $$\        $$$$$$\ $$\   $$\ $$\    $$\ $$$$$$$$\ $$\   $$\ $$$$$$$$\  $$$$$$\  $$$$$$$\ $$\     $$\ 
$$  __$$\ $$ |  $$ |       \_$$  _|$$$\  $$ |$$ |   $$ |$$  _____|$$$\  $$ |\__$$  __|$$  __$$\ $$  __$$\\$$\   $$  |
$$ /  $$ |\$$\ $$  |         $$ |  $$$$\ $$ |$$ |   $$ |$$ |      $$$$\ $$ |   $$ |   $$ /  $$ |$$ |  $$ |\$$\ $$  / 
$$ |  $$ | \$$$$  /          $$ |  $$ $$\$$ |\$$\  $$  |$$$$$\    $$ $$\$$ |   $$ |   $$ |  $$ |$$$$$$$  | \$$$$  /  
$$ |  $$ | $$  $$<           $$ |  $$ \$$$$ | \$$\$$  / $$  __|   $$ \$$$$ |   $$ |   $$ |  $$ |$$  __$$<   \$$  /   
$$ |  $$ |$$  /\$$\          $$ |  $$ |\$$$ |  \$$$  /  $$ |      $$ |\$$$ |   $$ |   $$ |  $$ |$$ |  $$ |   $$ |    
 $$$$$$  |$$ /  $$ |       $$$$$$\ $$ | \$$ |   \$  /   $$$$$$$$\ $$ | \$$ |   $$ |    $$$$$$  |$$ |  $$ |   $$ |    
 \______/ \__|  \__|$$$$$$\\______|\__|  \__|    \_/    \________|\__|  \__|   \__|    \______/ \__|  \__|   \__|    
                    \______|                                                                                                                                                                                                      

					
]]--

-- IF you use Ox inventory add item like this :

-- Add to ox_inventory/data/items.lua all item you want like this and rename name_item .. as you want

['name_item'] = { --- For no consomable item
label = 'name_item',
weight = 1,
stack = true,
close = true,
description = nil,
consume = 0,
}, 


['name_drink'] = { -- For drink
label = 'name_drink',
weight = 500,
client = {
	status = { thirst = 200000 },
	anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
	prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
	usetime = 2500,
	cancel = true,
	notification = 'You drank some **** '
}
},

['name_food'] = { -- For food
label = 'name_food',
weight = 220,
client = {
	status = { hunger = 200000 },
	anim = 'eating',
	prop = 'burger',
	usetime = 2500,
	notification = 'You ate a delicious ***'
},
},









-- If use bx-billing system :

-- add to ox_inventory/modules/items/client.lua : 



local BillingResource = exports["BX-CustomJob"]

Item('billing', function(data, slot)
BillingResource:useBillingItem(data)
end)


-- Add to ox_inventory/data/items.lua : 


--  WARNING : If you duplicate the script, do this only once

['billing'] = {
	label = 'name_item',
	weight = 1,
	stack = true,
	close = true,
	description = nil,
}, 







--[[

$$$$$$\   $$$$$$\  $$\       
$$  __$$\ $$  __$$\ $$ |      
$$ /  \__|$$ /  $$ |$$ |      
\$$$$$$\  $$ |  $$ |$$ |      
\____$$\ $$ |  $$ |$$ |      
$$\   $$ |$$ $$\$$ |$$ |      
\$$$$$$  |\$$$$$$ / $$$$$$$$\ 
\______/  \___$$$\ \________|
	   \___|          
]]--

-- If you want to add in sql
-- Add to item table all item you want like this :


INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
('name_item', 'name_item', 1, 0, 1);

