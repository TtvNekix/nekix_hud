ESX = nil
local time = "12:00"
local statusJob, statusHour, statusId, statusPlayer = true
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do Wait(0) end

	ESX.PlayerData = ESX.GetPlayerData()

    if Config.EnableCommands then
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
    end

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerData = xPlayer
  PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  ESX.PlayerData.job = job
end)

RegisterNetEvent('client:system:getHour')
AddEventHandler('client:system:getHour', function(hora)
    time = hora
end)

RegisterNetEvent("esx_status:onTick")
AddEventHandler("esx_status:onTick", function(status)

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
    Citizen.Wait(4000) -- DON'T DELETE IT
    while true and ESX.PlayerData do
        local msec = Config.TickTime
        job = ESX.GetPlayerData().job.label .. " : " .. ESX.GetPlayerData().job.grade_label
        info = {}
        playerPed = PlayerPedId()
        local years, months, days, hours, minutes, seconds = Citizen.InvokeNative(0x50C7A99057A69748, Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt())
        
        if job ~= nil then
            if Config.Stress then
                info = {
                    playerJob = job,
                    playerHour = time,
                    playerId = GetPlayerServerId(PlayerId()),
                    playerHealth = GetEntityHealth(PlayerPedId()),
                    playerHungher = food,
                    playerThirst = thirst,
                    playerStress = true,
                }
            else
                info = {
                    playerJob = job,
                    playerHour = hours .. ":" .. minutes,
                    playerId = GetPlayerServerId(PlayerId()),
                    playerHealth = GetEntityHealth(PlayerPedId()),
                    playerHungher = food,
                    playerThirst = thirst,
                    playerStress = false
                }
            end
        end

        SendNUIMessage(info)
        Citizen.Wait(msec)
    end
end)