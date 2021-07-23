ESX                           = nil

local cachedBins = {}


Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj 
        end)

        Citizen.Wait(5)
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(100)

    while true do
        
        local sleepThread = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        for i = 1, #Config.BinsAvailable do
            local entity = GetClosestObjectOfType(playerCoords, 1.0, GetHashKey(Config.BinsAvailable[i]), false, false, false)
            local binCoords = GetEntityCoords(entity)
            
            if DoesEntityExist(entity) then
                ESX.ShowFloatingHelpNotification('Pulsa ~y~E~w~ para buscar', vector3(binCoords.x, binCoords.y, binCoords.z + 1.0))
                sleepThread = 5
                if IsControlJustReleased(0, 38) then
                    if not cachedBins[entity]  then
                        cachedBins[entity] = true
                        OpenTrashCan(entity)
                    else
                        ESX.ShowNotification("¡Ya buscaste en este contenedor!")
                    end  
                    break
                    ESX.ShowFloatingHelpNotification('Pulsa ~y~E~w~ para buscar', vector3(binCoords.x, binCoords.y, binCoords.z + 1.0))
                end

            end
        end
        Citizen.Wait(sleepThread)
    end
end)

OpenTrashCan = function(entity)
    local pyid = PlayerPedId()
    TaskStartScenarioInPlace(pyid, "PROP_HUMAN_BUM_BIN", 0, true)
    TriggerEvent("esx_notificaciones:TermiShowProgressBar", 10100, "Buscando en la papelera...")
    Citizen.Wait(10000)
    randomChance = math.random(1, 100)
    randomWeapon = Config.ItemWeaponsObject[math.random(1, #Config.ItemWeaponsObject)]
    randomItem = Config.ItemLootObject[math.random(1, #Config.ItemLootObject)]

    if randomChance > 0 and randomChance < Config.ProbabilityWeaponLootObject then
        local randomAmmo = math.random(1, 30)
        GiveWeaponToPed(GetPlayerPed(-1), randomWeapon, randomAmmo, true, false)
        TriggerServerEvent('enp-papelera:Weaponloot', randomWeapon)
    elseif randomChance >=  Config.ProbabilityItemLootObject then
        TriggerServerEvent('enp-papelera:itemloot', randomItem)
    elseif randomChance >= Config.ProbabilityItemLootObject and randomChance < 100 then
        ESX.ShowNotification('No has encontrado nada')
    end
    ClearPedTasks(pyid)
end