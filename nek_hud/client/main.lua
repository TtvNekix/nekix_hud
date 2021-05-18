ESX = nil
local time = "12:00"
local statusJob, statusHour, statusId, statusPlayer = true

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('client:system:getHour')
AddEventHandler('client:system:getHour', function(hora)
    time = hora
end)

RegisterNetEvent("nek_hud:onTick")
AddEventHandler("nek_hud:onTick", function(status)

    TriggerEvent('esx_status:getStatus', 'hunger', function(status)
        food = status.val / 10000
    end)
    TriggerEvent('esx_status:getStatus', 'thirst', function(status)
        thirst = status.val / 10000
    end)
    if Config.Stress then
        stress = 0
        TriggerEvent('esx_status:getStatus', 'stress', function(status)
            stress = status.val / 10000
        end)
    end
end)

Citizen.CreateThread(function()
    while true do
        local info = {}
        
        if Config.Stress then
            info = {
                playerJob = ESX.GetPlayerData().job.label .. " : " .. ESX.GetPlayerData().job.grade_label,
                playerHour = time,
                playerId = GetPlayerServerId(PlayerId()),
                playerHealth = GetEntityHealth(PlayerPedId()),
                playerHungher = food,
                playerThirst = thirst,
                playerStress = stress,
            }
        else
            info = {
                playerJob = ESX.GetPlayerData().job.label .. " : " .. ESX.GetPlayerData().job.grade_label,
                playerHour = time,
                playerId = GetPlayerServerId(PlayerId()),
                playerHealth = GetEntityHealth(PlayerPedId()),
                playerHungher = food,
                playerThirst = thirst,
                playerStress = false
            }
        end
        
        SendNUIMessage(info)
        TriggerServerEvent('server:system:getHour')
        Citizen.Wait(Config.TickTime)
    end
end)

RegisterCommand('hudjob', function()
    statusJob = not statusJob
    SendNUIMessage({jobValue = statusJob})
end)

RegisterCommand('hudhour', function()
    statusHour = not statusHour
    SendNUIMessage({hourValue = statusHour})
end)

RegisterCommand('hudplayer', function()
    statusPlayer = not statusPlayer
    SendNUIMessage({playerValue = statusPlayer})
end)
