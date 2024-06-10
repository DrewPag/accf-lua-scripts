local fishAddrs = {0x90532308, 0x905333a8, 0x90534448, 0x905354e8, 0x90536588, 0x90537628, 0x905386c8, 0x90539768}
local ttlAddrs = {0x9053230C, 0x905333aC, 0x9053444C, 0x905354eC, 0x9053658C, 0x9053762C, 0x905386cC, 0x9053976C}

local fishNames = {"Bitterling","Pale Chub","Crucian Carp","Dace","Barbel Steed","Carp","Koi","Goldfish","Popeyed Goldfish","Killifish","Crawfish","Frog","Freshwater Goby","Loach","Catfish",
                    "Eel","Giant Snakehead","Bluegill","Yellow Perch","Black Bass","Pike", "Pond Smelt","Sweetfish","Cherry Salmon","Char","Rainbow Trout","Stringfish","Salmon","King Salmon",
                    "Guppy","Angelfish","Neon Tetra", "Piranha","Arowana","Dorado","Gar","Arapaima","Sea Butterfly","Jellyfish","Seahorse","Clownfish","Surgeonfish", "Butterflyfish",
                    "Napoleonfish", "Zebra Turkeyfish","Puffer Fish", "Horse Mackerel", "Barred Knifejaw","Sea Bass","Red Snapper","Dab","Olive Flounder","Squid","Octopus", "Lobster",
                    "Moray Eel", "Football Fish","Tuna","Blue Marlin", "Ray", "Ocean Sunfish","Hammerhead Shark","Shark", "Coelacanth","Can","Boot","Tire", "Key1", "Key2", "Key3", "Key4", "Key5", "Key6", "Key7", "Key8"}

local bugFlagAddr = 0x80ed9880
local fishFlagAddr = 0x80ed9880

function onScriptStart()
	SetScreenText("Hello")
end

function onScriptCancel()

end

function onScriptUpdate()

    local text = ""

    for i, fishAddr in pairs(fishAddrs) do

        fishId = ReadValue32(fishAddr)
        local name = "255 not filled"
        local ttlSeconds = -1

        local bugRelFlag = 0x74
        local bugRelFlagValue = ReadValue32(bugFlagAddr)
        local ttlMs = ReadValue32(ttlAddrs[i])

        prefix = "River " .. i
        if i > 4 then
            prefix = "Ocean "..(i-4)
        end

        if bugRelFlagValue == bugRelFlag then
            if fishId < 75 then
                name = fishNames[fishId+1]
                ttlSeconds = math.floor(ttlMs / 60)
            else 
                if fishId == 255 then
                    name = "not filled"
                    ttlSeconds = -1
                else
                    name = "N/A"
                    ttlSeconds = -1
                end
            end
        else
            WriteValue32(fishAddr, 75)
            name = "N/A"
        end
    
        text = text .. prefix .. ": " .. name .. "\nTTL: " .. ttlSeconds .. "\n\n"

    end

    SetScreenText(text)	
end