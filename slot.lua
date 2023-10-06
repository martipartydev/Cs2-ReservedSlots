print("Resserved slots!")

local reservedlist
local kv = LoadKeyValues("scripts/configs/reserved.ini")
local slots = 28 --Non Resserved Slots| You can change this | Example: If the server is 32 slots in this case: you will have 4 resserved slots|

function Adverts_LoadAdvertsConfig()
    print("list start")
    
	
	if kv ~= nil then
        reservedlist = {}
        for k, v in pairs(kv) do
            table.insert(reservedlist, v)
            print("Added: " .. v)
        end

		return reservedlist
	else
		print("Couldn't load config file (scripts/configs/reserved.ini). Adverts script wasn't started.")
		return {}
	end
end


function CheckReserved(event)
    local player = Entities:FindAllByClassname("player")
    local players = 0
    for _ in pairs(player) do
        players = players + 1
    end 
    if GetMapName() ~= "<empty>" then 
        DeepPrintTable(event)
            if (players > slots) then
                for _, id in ipairs(reservedlist) do
                if (id ~= event.networkid) then
                    SendToServerConsole("kickid " .. event.userid .. "You need Slot access!")
                end
            end
        end
    end
end



function Activate()
    Adverts_LoadAdvertsConfig()
    ListenToGameEvent("player_connect", CheckReserved, nil)
end

Activate()
