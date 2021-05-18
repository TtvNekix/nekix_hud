# nekix_hud

Hi everyone and welcome to my new script and my first HUD.


To use the HUD you must replace in the client / main.lua of the esx_status, in line 72 the code

<code> TriggerEvent('esx_status:onTick', GetStatusData(true)) </code> 

by

<code> TriggerEvent('nek_hud:onTick', GetStatusData(true)) </code>
