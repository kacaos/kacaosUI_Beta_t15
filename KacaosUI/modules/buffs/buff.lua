local T, C, L = unpack(Tukui)
if not C.auras.enable == false then return end
---------------------------------------------------------------
-- Buffs
---------------------------------------------------------------

-- move the player buffs at the topright corner
TukuiAurasPlayerBuffs:ClearAllPoints()
TukuiAurasPlayerBuffs:Point("TOPRIGHT", UIParent, "TOPRIGHT", -4, -2)
TukuiAurasPlayerBuffs:SetAttribute("wrapYOffset", -36)
if C.auras.classictimer == false then
	TukuiAurasPlayerBuffs:SetAttribute("xOffset", -42)
else
	TukuiAurasPlayerBuffs:SetAttribute("xOffset", -32)
end


local mover = CreateFrame("Frame", "DebuffsMover", UIParent)
mover:Width(200)
mover:Height(30)
mover:Point("CENTER", UIParent, "CENTER", -300, 80)
mover:SetTemplate()
mover:SetBackdropBorderColor(1,0,0)
mover:SetClampedToScreen(true)
mover:SetMovable(true)
mover:SetFrameStrata("LOW")
mover:Hide()
mover:FontString("Text", C.media.font, 12)
mover.Text:SetPoint("CENTER", DebuffsMover, "CENTER", 0, 0)
mover.Text:SetText(L.mover_debuffs)
tinsert(T.AllowFrameMoving, mover)

TukuiAurasPlayerDebuffs:ClearAllPoints()
TukuiAurasPlayerDebuffs:Point("RIGHT", mover)
TukuiAurasPlayerDebuffs:SetAttribute("xOffset", -32)

local hooks = {
	TukuiAurasPlayerBuffs,
	TukuiAurasPlayerDebuffs,
	TukuiAurasPlayerConsolidate,
}

local OnAttributeChanged = function(self)
	for i = 1, self:GetNumChildren() do
		local child = select(i, self:GetChildren())

		if child.Duration then
			child.Duration:SetFont(C["media"].pixelfont, 8, "MONOCHROMEOUTLINE")
			child.Duration:SetShadowOffset(0,0)
			child.Duration:SetPoint("BOTTOM", 1, 1)
		end
		
		if child.Holder then
			child.Holder:ClearAllPoints()
			child.Holder:SetPoint("TOPRIGHT", child, "TOPLEFT", -1, 0)
			child.Holder:Size(7, 30)
		end
		
		if child.Bar then
			child.Bar:SetOrientation("VERTICAL")
		end

		if child.Count then
			child.Count:SetFont(C["media"].pixelfont, 8, "MONOCHROMEOUTLINE")
			child.Count:SetShadowOffset(0,0)
			child.Count:SetPoint("TOP", 1, -1)
		end
		if child.Icon then
			child.Icon:ClearAllPoints()
			child.Icon:Point("TOPLEFT", child, 1, -1)
			child.Icon:Point("BOTTOMRIGHT", child, -1, 1)
        end
	end
end

for _, frame in pairs(hooks) do
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	frame:HookScript("OnAttributeChanged", OnAttributeChanged)
	frame:HookScript("OnEvent", OnAttributeChanged)
end

if C.auras.buffsfadeout then
local fadeout = CreateFrame("Frame")
fadeout:RegisterEvent("PLAYER_ENTERING_WORLD")
fadeout:RegisterEvent("PLAYER_REGEN_ENABLED")
fadeout:RegisterEvent("PLAYER_REGEN_DISABLED")
fadeout:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_REGEN_ENABLED" then
			TukuiAurasPlayerBuffs:Show()
	elseif event == "PLAYER_REGEN_DISABLED" then
			TukuiAurasPlayerBuffs:Hide()
	end
end)
end