local T, C, L = unpack(Tukui)
if not C["tooltip"].enable then return end
--------------------------------------------------------
-- Tooltip
--------------------------------------------------------
TukuiTooltipAnchor:ClearAllPoints()
TukuiTooltipAnchor:SetClampedToScreen(false)
TukuiTooltipAnchor:Point("BOTTOMRIGHT", Minimap, "BOTTOMLEFT", -78, -30)

--------------------------------------------------------
-- icon on tooltip
--------------------------------------------------------
local function AddTooltipIcon(self, icon)
	if icon then
		local title = _G[self:GetName() .. "TextLeft1"]
		if title and not title:GetText():find("|T" .. icon) then
			title:SetFormattedText("|T%s:20:20:0:0:64:64:5:59:5:59:%d|t %s", icon, 18, title:GetText())
		end
	end
end

--------------------------------------------------------
-- Hyperlink (mouseover tooltip in chat
--------------------------------------------------------
local function hookItem(tip)
	tip:HookScript("OnTooltipSetItem", function(self, ...)
		local name, link = self:GetItem()
		local icon = link and GetItemIcon(link)
		AddTooltipIcon(self, icon)
	end)
end
hookItem(_G["GameTooltip"])
hookItem(_G["ItemRefTooltip"])

local function hookSpell(tip)
	tip:HookScript("OnTooltipSetSpell", function(self, ...)
		if self:GetSpell() then
			local name, rank, icon = GetSpellInfo(self:GetSpell())
			AddTooltipIcon(self, icon)
		end
	end)
end
hookSpell(_G["GameTooltip"])
hookSpell(_G["ItemRefTooltip"])

-----------------------------------------------------------
-- ilvl in tooltip
-----------------------------------------------------------
--[[
	thx to Gsuz for the script
]]--

local SlotName = {
        "Head","Neck","Shoulder","Back","Chest","Wrist",
        "Hands","Waist","Legs","Feet","Finger0","Finger1",
        "Trinket0","Trinket1","MainHand","SecondaryHand","Ranged"
    }
local function GetItemLVL(unit)
local total, item = 0, 0;
    for _,v in pairs(SlotName) do
        local slot = GetInventoryItemLink(unit, GetInventorySlotInfo(v .. "Slot"));
        if (slot ~= nil) then
            item = item + 1;
            total = total + select(4, GetItemInfo(slot))
        end
    end
    if (item > 0) then
        return floor(total * 10 / item)/10;
    end
    return 0;
end
GameTooltip:HookScript("OnTooltipSetUnit", function(self, ...)
    if C["tooltip"].ilvl == true then
		local _, unit = GameTooltip:GetUnit();
		if (unit and CanInspect(unit)) then
			if (not ((InspectFrame and InspectFrame:IsShown()) or (Examiner and Examiner:IsShown()))) then
				NotifyInspect(unit);
				GameTooltip:AddLine("Item Level: " .. GetItemLVL(unit));
				ClearInspectPlayer(unit);
				GameTooltip:Show();
			end
		end
	end
end)