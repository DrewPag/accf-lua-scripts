local bugAddrs = {0x902DE0B0, 0x902DF130, 0x902E01B0, 0x902E1230, 0x902E22B0, 0x902E3330, 0x902E43B0, 0x902E5430, 0x902E64B0, 0x902E7530, 0x902E85B0, 0x902E9630}
local ttlAddrs = {0x902DE0B4, 0x902DF134, 0x902E01B4, 0x902E1234, 0x902E22B4, 0x902E3334, 0x902E43B4, 0x902E5434, 0x902E64B4, 0x902E7534, 0x902E85B4, 0x902E9634}

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
        local ttlSeconds = -1

        local bugRelFlag = 0x74
        local bugRelFlagValue = ReadValue32(bugFlagAddr)
        local ttlMs = ReadValue32(ttlAddrs[i])

        if bugRelFlagValue == bugRelFlag then
            if bugId <= 64 then
                name = bugNames[bugId+1]
                ttlSeconds = math.floor(ttlMs / 60)
            else
                name = "N/A"
                ttlSeconds = -1
            end
        else
            WriteValue32(bugAddr, 65)
            name = "N/A"
            ttlSeconds = -1
        end
        text = text .. "Bug " .. i .. ": " .. name .. "\nTTL: " .. ttlSeconds .. "\n\n"

    end

    SetScreenText(text)	
end