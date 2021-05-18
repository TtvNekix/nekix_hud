ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('server:system:getHour')
AddEventHandler('server:system:getHour', function()
    local hour = os.date("%H:%M")
    TriggerClientEvent('client:system:getHour', source, hour)
end)