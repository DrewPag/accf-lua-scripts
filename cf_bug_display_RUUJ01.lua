local bugAddrs = {0x902DE0B0, 0x902DF130, 0x902E01B0, 0x902E1230, 0x902E22B0, 0x902E3330, 0x902E43B0, 0x902E5430, 0x902E64B0, 0x902E7530, 0x902E85B0, 0x902E9630}

local bugNames = {"Common Butterfly", "Yellow Butterfly", "Tiger Butterfly", "Peacock Butterfly",
        "Monarch Butterfly", "Emperor Butterfly", "Agrias Butterfly", "Raja Brooke", "Birdwing", "Moth", "Oak Silk Moth", "Honeybee",
        "Bee", "Long Locust", "Migratory Locust", "Mantis", "Orchid Mantis", "Brown Cicada", "Robust Cicada", "Walker Cicada",
        "Evening Cicada", "Lantern Fly", "Red Dragonfly", "Darner Dragonfly", "Banded Dragonfly", "Giant Petaltail", "Ant",
        "Pondskater", "Diving Beetle", "Snail", "Cricket", "Bell Cricket", "Grasshopper", "Mole Cricket", "Walking Leaf",
        "Walkingstick", "Bagworm", "Ladybug", "Violin Beetle", "Longhorn Beetle", "Dung Beetle", "Firefly", "Fruit Beetle",
        "Scarab Beetle", "Jewel Beetle", "Miyama Stag", "Saw Stag", "Giant Stag", "Rainbow Stag", "Cyclommatus", "Golden Stag",
        "Dynastid Beetle", "Atlas Beetle", "Elephant Beetle", "Hercules Beetle", "Goliath Beetle", "Flea", "Pill Bug", "Mosquito",
        "Fly", "Centipede", "Spider", "Tarantula", "Scorpion"}

local bugFlagAddr = 0x80ed9880

local bugId

function onScriptStart()
	SetScreenText("Hello")
end

function onScriptCancel()

end

function onScriptUpdate()

    local text = ""

    for i, bugAddr in pairs(bugAddrs) do
        bugId = ReadValue32(bugAddr)
        local name = "255 not filled"

        local bugRelFlag = 0x74
        local bugRelFlagValue = ReadValue32(bugFlagAddr)

        if bugRelFlagValue == bugRelFlag then
            if bugId <= 64 then
                name = bugNames[bugId+1]
            else
                name = "N/A"
            end
        else
            WriteValue32(bugAddr, 65)
            name = "N/A"
        end
    
        text = text .. "Bug " .. i .. ": " .. name .. "\n"

    end

    SetScreenText(text)	
end