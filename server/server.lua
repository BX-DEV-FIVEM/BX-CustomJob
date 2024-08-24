ESX = exports["es_extended"]:getSharedObject()
local ox_inventory = exports.ox_inventory

TriggerEvent('esx_society:registerSociety', Config.job_name, Config.job_label, Config.society_name, Config.society_name, Config.society_name, {
    type = 'public'
})


exports.ox_inventory:RegisterStash("stock_" .. Config.job_name, "Stock", 100, 100000, false, Config.job_name)


RegisterServerEvent('BX-' .. Config.job_name .. ':craftItem')
AddEventHandler('BX-' .. Config.job_name .. ':craftItem', function(craftItems, rewardItem)
    local xPlayer = ESX.GetPlayerFromId(source)
    local hasAllItems = true
    for _, item in ipairs(craftItems) do
        if xPlayer.getInventoryItem(item).count < 1 then
            hasAllItems = false
            break
        end
    end
    if hasAllItems then
        for _, item in ipairs(craftItems) do
            xPlayer.removeInventoryItem(item, 1)
        end
        xPlayer.addInventoryItem(rewardItem, 1)
    else
        TriggerClientEvent('BX-' .. Config.job_name .. ':Notify', source, Strings['need_ingrédient'], 'error')
     
    end
end)




if Config.Mission then
		ESX.RegisterServerCallback('BX-' .. Config.job_name .. 'delivery:completeExchange', function(source, cb)
			local xPlayer = ESX.GetPlayerFromId(source)
			local item = xPlayer.getInventoryItem(Config.MissionItem)
			if item.count > 0 then
				xPlayer.removeInventoryItem(Config.MissionItem, 1)
				local companyPart = Config.RewardMoney * (Config.CompanyRewardPercentage / 100)
				local playerPart = Config.RewardMoney - companyPart
				xPlayer.addMoney(playerPart)
				if xPlayer.job and xPlayer.job.name then
					local accountName = xPlayer.job.name .. '_money'
					local societyName = xPlayer.getJob().name
					TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. societyName, function(account)
						societyAccount = account
					end)
					if societyAccount then
						societyAccount.addMoney(companyPart)
					else
					end
				else
				end	
				cb(true)
			else
				cb(false)
			end
		end)
		RegisterNetEvent('BX-' .. Config.job_name .. 'delivery:exchangeItem')
		AddEventHandler('BX-' .. Config.job_name .. 'delivery:exchangeItem', function()
			local _source = source
			TriggerClientEvent('BX-' .. Config.job_name .. 'delivery:exchangeItem', _source)
		end)
end



RegisterServerEvent('BX-' .. Config.job_name ..':passer_annonce')
AddEventHandler('BX-' .. Config.job_name ..':passer_annonce', function(label, messageLabel, textEntered, icon)
    local source = source 
    TriggerClientEvent('esx:showAdvancedNotification', -1, label, messageLabel, textEntered, icon, 8)    
          
        
end)



RegisterServerEvent('BX-' .. Config.job_name .. ':playerOnDuty')
AddEventHandler('BX-' .. Config.job_name .. ':playerOnDuty', function(playerName)
    local players = GetPlayers()
    for _, playerId in ipairs(players) do
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer ~= nil and xPlayer.job.name == Config.job_name then
                
            TriggerClientEvent('BX-' .. Config.job_name .. ':notifyOnDuty', playerId, playerName)
        end
    end
end)


RegisterServerEvent('BX-' .. Config.job_name .. ':playerOnDutyOff')
AddEventHandler('BX-' .. Config.job_name .. ':playerOnDutyOff', function(playerName)
    local players = GetPlayers()
    for _, playerId in ipairs(players) do
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer ~= nil and xPlayer.job.name == Config.job_name then
            TriggerClientEvent('BX-' .. Config.job_name .. ':playerOnDutyOff', playerId, playerName)
        end
    end
end)



--- SHOP ---

RegisterServerEvent('BX-' .. Config.job_name ..':vendor:buyItem')
AddEventHandler('BX-' .. Config.job_name ..':vendor:buyItem', function(itemName, itemPrice)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() >= itemPrice then
        xPlayer.removeMoney(itemPrice)
        xPlayer.addInventoryItem(itemName, 1)
    else
        TriggerClientEvent('BX-' .. Config.job_name .. ':Notify', source, Strings['no_money'], 'error')
    end
end)

--- RECOLTE --- 

RegisterNetEvent('BX-' .. Config.job_name ..':harvest:addItem')
AddEventHandler('BX-' .. Config.job_name ..':harvest:addItem', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(item, 1)
end)






-- Vetement

RegisterNetEvent('BX-' .. Config.job_name ..':getWorkOutfits')
AddEventHandler('BX-' .. Config.job_name ..':getWorkOutfits', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local grade = xPlayer.job.grade

    local outfits = {}
    for g, outfit in pairs(Config.JobOutfit) do
        if g <= grade then
            table.insert(outfits, {grade = g, outfit = outfit})
        end
    end

    TriggerClientEvent('BX-' .. Config.job_name ..':showWorkOutfits', source, outfits)
end)




RegisterNetEvent('BX-' .. Config.job_name ..':changeOutfit')
AddEventHandler('BX-' .. Config.job_name ..':changeOutfit', function(outfitType, grade)
    local xPlayer = ESX.GetPlayerFromId(source)

    if outfitType == 'work' then
        local outfit = Config.JobOutfit[grade]
        if outfit then
            TriggerClientEvent('BX-' .. Config.job_name ..':applyOutfit', source, outfit)
        else
            print('No outfit defined for grade: ' .. grade)
        end
    elseif outfitType == 'civil' then
        MySQL.Async.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        }, function(result)
            if result[1] and result[1].skin then
                local skin = json.decode(result[1].skin)
                TriggerClientEvent('BX-' .. Config.job_name ..':applyOutfit', source, skin)
            else
                print('No skin found for player: ' .. xPlayer.identifier)
            end
        end)
    end
end)



ESX.RegisterServerCallback('BX-' .. Config.job_name .. ':getPlayerSkin', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(result)
        if result[1] and result[1].skin then
            cb(json.decode(result[1].skin))
        else
            cb(nil)
        end
    end)
end)





---- Billing 




ESX = exports["es_extended"]:getSharedObject()


RegisterNetEvent("BX-" .. Config.job_name .. ":giveBillingItem", function(player, reason, society, amount)
    giveItem(source, player, reason, society, amount)
end)

RegisterNetEvent("BX-" .. Config.job_name .. ":payBill", function(method, data)
    payBill(source, method, data)
end)




local ox_inventory = exports.ox_inventory

function payBill(source, method, data)
    local xPlayer = ESX.GetPlayerFromId(source)
    local bankMoney = xPlayer.getAccount("bank").money
    local money = ox_inventory:Search(source, 'count', { 'money' })
    if method == "money" then
        if money >= data.metadata.amount then
            ox_inventory:RemoveItem(source, 'money', data.metadata.amount)

            
                ox_inventory:RemoveItem(source, Config.BillingItem, 1, nil, data.slot)
            

            TriggerEvent('esx_addonaccount:getSharedAccount', "society_" .. data.metadata.society, function(account)
                account.addMoney(data.metadata.amount)
            end)

            TriggerClientEvent('BX-' .. Config.job_name .. ':Notify', source, Config.BillingTranslation.billPaid .. data.metadata.amount)
            TriggerClientEvent('BX-' .. Config.job_name .. ':Notify', data.metadata.xplayer,
                Config.BillingTranslation.billPaid .. data.metadata.amount)
            if Config.UseDiscordLogs then
            log(
            GetPlayerName(source) .. "  " .. Config.BillingTranslation.paidBill .. "  " .. data.metadata.amount .."  ".. Config.BillingTranslation.created_by  .."  ".. 	GetPlayerName(data.metadata.xplayer),
            data.metadata.society, 5763719) 
        end
            
            
        else
            TriggerClientEvent('BX-' .. Config.job_name .. ':Notify', source, Config.BillingTranslation.noMoney)
            TriggerClientEvent('BX-' .. Config.job_name .. ':Notify', data.metadata.xplayer, Config.BillingTranslation.xnoMoney)
        end
        
        
    elseif method == "bank" then
        if bankMoney >= data.metadata.amount then
            xPlayer.removeAccountMoney("bank", data.metadata.amount)

           
                ox_inventory:RemoveItem(source, Config.BillingItem, 1, nil, data.slot)
            
            TriggerEvent('esx_addonaccount:getSharedAccount', "society_" .. data.metadata.society, function(account)
                account.addMoney(data.metadata.amount)
            end)

            TriggerClientEvent('BX-' .. Config.job_name .. ':Notify', source, Config.BillingTranslation.billPaid .. data.metadata.amount)
            TriggerClientEvent('BX-' .. Config.job_name .. ':Notify', data.metadata.xplayer,
                Config.BillingTranslation.billPaid .. data.metadata.amount)

		if Config.UseDiscordLogs then
            log(
            GetPlayerName(source) .. "  " .. Config.BillingTranslation.paidBill .. "  " .. data.metadata.amount .."  ".. Config.BillingTranslation.created_by  .."  ".. 	GetPlayerName(data.metadata.xplayer),
            data.metadata.society, 5763719) 
               

        else
            TriggerClientEvent('BX-' .. Config.job_name .. ':Notify', source, Config.BillingTranslation.noMoney)
            TriggerClientEvent('BX-' .. Config.job_name .. ':Notify', data.metadata.xplayer, Config.BillingTranslation.xnoMoney)
        end

        end
    end
end

function giveItem(source, player, reason, society, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = xPlayer.getName()
    local job = xPlayer.getJob().name
    local forcePay = false
    

            ox_inventory:AddItem(player, Config.BillingItem, 1, {
                reason = reason, society = society, status = Config.BillingTranslation.notPaid, amount = amount, from = name,
                date = os.date("%x %X"), xplayer = source, description = "\n " .. Config.BillingTranslation.createdFrom .. "  " .. name .. "\n    " ..
                "\n " .. Config.BillingTranslation.fReason .. "  " .. reason .. "\n    " ..
                "\n " .. Config.BillingTranslation.fAmount .. "  " .. amount
            })


        if Config.UseDiscordLogs then
            log(
                GetPlayerName(source) ..  "  " .. Config.BillingTranslation.createbill ..  "  " .. amount ..  "  " .. Config.BillingTranslation.billfor ..  "  ".. GetPlayerName(player),
                job,
                5763719
            )
        end
end




function log(description, job, color)
    local webhook = Config.JobWebhooks
    if not webhook then return end 

    PerformHttpRequest(webhook, function() end, "POST", json.encode({
        embeds = {
            {
                author = {
                    name = Config.BillingTranslation.createbilldiscord,
                    url = Config.BillingTranslation.url,
                    icon_url = Config.BillingTranslation.png
                },
                title = Config.BillingTranslation.createbilldiscord2,
                description = description,
                color = color
            }
        }
    }), { ["Content-Type"] = "application/json" })
end



