local ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) 
    ESX = obj 
end)


RegisterServerEvent('enp-papelera:itemloot')
AddEventHandler('enp-papelera:itemloot', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local random = math.random(1, 3)
    xPlayer.addInventoryItem(item, random)
    TriggerClientEvent("esx:showNotification", xPlayer.source, 'Has encontrado ~y~' .. random .. 'x ~b~' .. ESX.GetItemLabel(item))
end)

RegisterServerEvent('enp-papelera:Weaponloot')
AddEventHandler('enp-papelera:Weaponloot', function(randomWeapon)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("esx:showNotification", xPlayer.source, 'Has encontrado ~y~' ..ESX.GetWeaponLabel(randomWeapon))
end)

RegisterServerEvent('esx_zombiesystem:moneyloot')
AddEventHandler('esx_zombiesystem:moneyloot', function()
    local xPlayer = ESX.GetPlayerFromId(source)
	local random = math.random(1, 20)
    xPlayer.addMoney(random)
    --TriggerClientEvent("pNotify:SendNotification", -1, {text = "Has encontrado $" .. random .. " dolars", type = "info", layout = "topRight", theme = "sunset", timeout = math.random(2500, 2500)}) 
    TriggerClientEvent("esx:showNotification", xPlayer.source, 'Has encontrado ~g~$' .. random .. ' €')
end)