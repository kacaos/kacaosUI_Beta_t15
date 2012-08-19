local T, C, L = unpack(Tukui)
if not C.actionbar.enable == true then return end
if C.actionbar.style ~= 1 then return end

-- Kill backdrop
TukuiBar3:SetBackdrop(nil)

-- move the bar
TukuiBar3:ClearAllPoints()
TukuiBar3:Point("BOTTOMRIGHT", TukuiBar4, "TOPRIGHT", 0, -3000)

------------------------------------------------
--bar 3 mover
------------------------------------------------
local mover = CreateFrame("Frame", "TukuiBar3Mover", UIParent)
mover:Width(27)
mover:Height(27)
mover:Point("TOPRIGHT", UIParent, -27, -410)
mover:SetTemplate()
mover:SetBackdropBorderColor(0,1,0)
mover:SetClampedToScreen(true)
mover:SetMovable(true)
mover:SetFrameStrata("HIGH")
mover:Hide()
mover:FontString("Text", C.media.font, 12)
mover.Text:SetPoint("CENTER", TukuiBar3Mover, "CENTER", 0, 0)
mover.Text:SetText(L.mover_bar3)
tinsert(T.AllowFrameMoving, mover)

-----------------------------------------------
-- bar3 horizontal right
-----------------------------------------------
for i= 1, 12 do
	local b3 = _G["MultiBarBottomLeftButton"..i]
	local b4 = _G["MultiBarBottomLeftButton"..i-1]
	b3:SetSize(T.buttonsize, T.buttonsize)
	b3:ClearAllPoints()
	b3:SetFrameStrata("BACKGROUND")
	b3:SetFrameLevel(15)
	
	if i == 1 then
		b3:SetPoint("LEFT", TukuiBar3Mover, 0, 0)
	else
		b3:SetPoint("TOP", b4, "BOTTOM", 0, -T.buttonspacing)
	end
end

------------------------------------------------
-- mouseover bar3
------------------------------------------------
if C.actionbar.sidebar3mouseover then
	TukuiBar3:OnMouseOver("MultiBarBottomRightButton", 12, 0, 1)
else
	TukuiBar3:Show()
end