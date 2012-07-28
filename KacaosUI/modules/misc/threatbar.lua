local T, C, L = unpack(Tukui)
if not C.unitframes.enable == true then return end
if not C.misc.threatbar == true then return end



if C.unitframes.style == 2 then
		
	local status = TukuiThreatBar
	status:SetParent(UIParent)
	status:Width(4)
	status:Height(25)
	status:ClearAllPoints()
	status:Point("LEFT", TukuiPlayer, "RIGHT", 4, -3)
	status:SetOrientation("VERTICAL")

	local background = CreateFrame("Frame", nil, status)
	background:SetFrameLevel(status:GetFrameLevel() - 1)
	background:Point("TOPLEFT", -1, 1)
	background:Point("BOTTOMRIGHT", 1, -1)
	background:SetTemplate("Transparent")
		
	status.text:Kill()
	status.Title:Kill()

elseif C.unitframes.style == 1 then

	local status = TukuiThreatBar
	status:SetParent(UIParent)
	status:Width(175)
	status:Height(3)
	status:ClearAllPoints()
	status:Point("BOTTOM", TukuiPlayer, "TOP", 0, 5)
	status:SetOrientation("Horizontal")

	local background = CreateFrame("Frame", nil, status)
	background:SetFrameLevel(status:GetFrameLevel() - 1)
	background:Point("TOPLEFT", -1, 1)
	background:Point("BOTTOMRIGHT", 1, -1)
	background:SetTemplate("Transparent")

	status.text:Kill()
	status.Title:Kill()

elseif C.actionbar.style == 2 then

	local status = TukuiThreatBar
	status:SetParent(TukuiBar1)
	status:Width(157)
	status:Height(6)
	status:ClearAllPoints()
	status:Point("BOTTOMLEFT", ActionButton1, 1, -8)
	status:SetOrientation("Horizontal")

	local background = CreateFrame("Frame", nil, status)
	background:SetFrameLevel(status:GetFrameLevel() - 1)
	background:Point("TOPLEFT", -1, 1)
	background:Point("BOTTOMRIGHT", 1, -1)
	background:SetTemplate("Transparent")

	status.text:ClearAllPoints()
	status.text:Point("RIGHT", status, 0, 0)
	status.text:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	status.text:SetShadowOffset(0,0)
	status.Title:ClearAllPoints()
	status.Title:Point("LEFT", status, 0, 0)
	TukuiThreatBar.Title:SetText(L.threat)
	status.Title:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	status.Title:SetShadowOffset(0,0)
end