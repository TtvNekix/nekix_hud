ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        function checkVersion(error, latestVersion, headers)
			local currentVersion = Config.Version     
            local name = "[^4nek_hud^7]"
            Citizen.Wait(2000)
            
			if tonumber(currentVersion) < tonumber(latestVersion) then
				print(name .. " ^1is outdated.\nCurrent version: ^8" .. currentVersion .. "\nNewest version: ^2" .. latestVersion .. "\n^3Update^7: https://github.com/TtvNekix/nekix_hud")
			else
				print(name .. " is updated.")
			end
		end
	
		PerformHttpRequest("https://raw.githubusercontent.com/TtvNekix/hudcheckerversion/main/version", checkVersion, "GET")
    end
end)