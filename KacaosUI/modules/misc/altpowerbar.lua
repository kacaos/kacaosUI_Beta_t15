local T, C, L = unpack(Tukui)
if not C.unitframes.enable == true then return end

local bar = TukuiAltPowerBar
local status = TukuiAltPowerBarStatus
local text = TukuiAltPowerBarText

if C.unitframes.style == 1 then
	-- position the bar
	bar:SetParent(UIParent)
	bar:ClearAllPoints()
	bar:Size(177, 8)
	bar:SetPoint("TOP", TukuiPlayer.Power, "BOTTOM", 0, -3)
	bar:SetTemplate()
	bar:SetFrameStrata("HIGH")

	-- position status bar
	status:SetParent(bar)
	status:ClearAllPoints()
	status:Point("TOPLEFT", 2, -2)
	status:Point("BOTTOMRIGHT", -2, 2)

	-- change the font
	text:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	text:SetShadowOffset(0,0)
	
elseif C.actionbar.style == 2 then
	-- position the bar
	bar:SetParent(TukuiBar1)
	bar:ClearAllPoints()
	bar:Size(159, 6)
	bar:SetPoint("BOTTOMLEFT", ActionButton1, 0, -17)
	bar:SetTemplate("Transparent")

	-- position status bar
	status:SetParent(bar)
	status:ClearAllPoints()
	status:Point("TOPLEFT", 1, -1)
	status:Point("BOTTOMRIGHT", -1, 1)

	-- change the font
	text:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	text:SetShadowOffset(0,0)
end