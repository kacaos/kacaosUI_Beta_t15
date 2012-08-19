local T, C, L = unpack(Tukui)
if not C.actionbar.enable == true then return end
if C.actionbar.style ~= 1 then return end

-- Kill backdrop
TukuiBar5:SetBackdrop(nil)

-- move the bar
TukuiBar5:ClearAllPoints()
TukuiBar5:Point("BOTTOMLEFT", TukuiBar2, "TOPLEFT", 0, 4000)

-----------------------------------------------------
--bar 5 mover
-----------------------------------------------------
local mover = CreateFrame("Frame", "TukuiBar5Mover", UIParent)
mover:Width(27)
mover:Height(27)
mover:Point("TOPRIGHT", UIParent, 0, -410)
mover:SetTemplate()
mover:SetBackdropBorderColor(0,1,0)
mover:SetClampedToScreen(true)
mover:SetMovable(true)
mover:SetFrameStrata("HIGH")
mover:Hide()
mover:FontString("Text", C.media.font, 12)
mover.Text:SetPoint("CENTER", TukuiBar5Mover, "CENTER", 0, 0)
mover.Text:SetText(L.mover_bar5)
tinsert(T.AllowFrameMoving, mover)

-------------------------------------------------------
-- bar5 horizontal right
-------------------------------------------------------
for i= 1, 12 do
	local b = _G["MultiBarRightButton"..i]
	local b2 = _G["MultiBarRightButton"..i-1]
	b:SetSize(T.buttonsize, T.buttonsize)
	b:ClearAllPoints()
	b:SetFrameStrata("BACKGROUND")
	b:SetFrameLevel(15)
		
	if i == 1 then
		b:SetPoint("LEFT", TukuiBar5Mover, 0, 0)
	else
		b:SetPoint("TOP", b2, "BOTTOM", 0, -T.buttonspacing)
	end
		
end

---------------------------------------------------------
-- bar5 on mouseover
---------------------------------------------------------
if C.actionbar.sidebar1mouseover then
	TukuiBar5:OnMouseOver("MultiBarRightButton", 12, 0, 1)
else
	TukuiBar5:Show()
end