local frameName = "MR_OCX_MONEY_MAKER_FRAME"
if not _G[frameName] then
    _G[frameName] = CreateFrame("Frame")
    _G[frameName]:RegisterEvent("MERCHANT_SHOW")
    _G[frameName]:RegisterEvent("GOSSIP_SHOW")
end

local function Set(list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end

local vendors = {
    ["Qia"] = Set {
        "Pattern: Runecloth Bag",
        "Pattern: Runecloth Gloves"
    },
    ["Professor Thaddeus Paleo"] = Set {
        "Living Ruby",
        "Dawnstone",
        "Nightseye",
        "Noble Topaz",
        "Star of Elune",
        "Talasite"
    },
    ["Dealer Tariq"] = Set {
        "Mote of Fire",
        "Mote of Air",
        "Mote of Life",
        "Mote of Mana",
        "Mote of Water",
        "Mote of Shadow",
        "Mote of Earth"
    }
}


local frame = _G[frameName]
frame:SetScript("OnEvent", function(self, event, ...)
    if IsShiftKeyDown() then return end
    
    local targetName = UnitName("target")
    if not targetName then return end
    local vendor = vendors[targetName]
    if not vendor then return end

    
    if targetName == "Professor Thaddeus Paleo" then
        SelectGossipOption(1)
    end

    for i=1,GetMerchantNumItems() do
        local itemName =  GetMerchantItemInfo(i)
        if vendor[itemName] then
            BuyMerchantItem(i)
        end
    end
    
    local count = 0
    frame:SetScript("OnUpdate", function(self)
        count = count + 1
        if count > 10 then
            CloseMerchant()
            frame:SetScript("OnUpdate", nil)
        end
    end)
end)
