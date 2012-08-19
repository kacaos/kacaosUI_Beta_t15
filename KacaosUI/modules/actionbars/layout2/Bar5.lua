local T, C, L = unpack(Tukui)
if not C.actionbar.enable == true then return end
if C.actionbar.style ~= 2 then return end

-- Kill backdrop
TukuiBar5:SetBackdrop(nil)

-- Move the bar
TukuiBar5:ClearAllPoints()
TukuiBar5:SetPoint("RIGHT", UIParent, -8, 20)

-- bar on mouseover
if C.actionbar.sidebar1mouseover then
	TukuiBar5:OnMouseOver("MultiBarRightButton", 12, 0, 1)
else
	TukuiBar5:Show()
end

-----------------------------------------------------
-- add movers to actionbars
-----------------------------------------------------
local mover = CreateFrame("Frame", "TukuiBar5Mover", UIParent)
mover:Width(27)
mover:Height(324)
mover:Point("RIGHT", UIParent, -8, 20)
mover:SetTemplate("Transparent")
mover:SetBackdropBorderColor(0,1,0)
mover:SetClampedToScreen(true)
mover:SetMovable(true)
mover:SetFrameStrata("HIGH")
mover:Hide()
mover:FontString("Text", C.media.font, 12)
mover.Text:SetPoint("CENTER", TukuiBar5Mover, "CENTER", 0, 0)
mover.Text:SetText(L.mover_bar5)
tinsert(T.AllowFrameMoving, mover)
TukuiBar5:ClearAllPoints()
TukuiBar5:SetPoint("LEFT", mover, 0, 0)
