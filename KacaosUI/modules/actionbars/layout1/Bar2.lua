local T, C, L = unpack(Tukui)
if not C.actionbar.enable == true then return end
if C.actionbar.style ~= 1 then return end

-- Kill backdrop
TukuiBar2:SetBackdrop(nil)

-- move the bar
TukuiBar2:ClearAllPoints()
TukuiBar2:Point("BOTTOMLEFT", TukuiBar4, "TOPLEFT", 0, -3000)

---------------------------------------------------
-- move the bar with mover
---------------------------------------------------
if not C.actionbar.b2bottom == true then
	local mover = CreateFrame("Frame", "TukuiBar2Mover", UIParent)
	mover:Width(27)
	mover:Height(27)
	mover:Point("TOPRIGHT", UIParent, -54, -410)
	mover:SetTemplate()
	mover:SetBackdropBorderColor(0,1,0)
	mover:SetClampedToScreen(true)
	mover:SetMovable(true)
	mover:SetFrameStrata("HIGH")
	mover:Hide()
	mover:FontString("Text", C.media.font, 12)
	mover.Text:SetPoint("CENTER", TukuiBar2Mover, "CENTER", 0, 0)
	mover.Text:SetText(L.mover_bar2)
	tinsert(T.AllowFrameMoving, mover)
end

if C.actionbar.b2bottom then
	local mover = CreateFrame("Frame", "TukuiBar2Mover", UIParent)
	mover:Width(27)
	mover:Height(27)
	mover:Point("LEFT", TukuiBar1, 3, (T.buttonsize*2+T.buttonspacing)+1)
	mover:SetTemplate()
	mover:SetBackdropBorderColor(0,1,0)
	mover:SetClampedToScreen(true)
	mover:SetMovable(true)
	mover:SetFrameStrata("HIGH")
	mover:Hide()
	mover:FontString("Text", C.media.font, 12)
	mover.Text:SetPoint("CENTER", TukuiBar2Mover, "CENTER", 0, 0)
	mover.Text:SetText(L.mover_bar2)
	tinsert(T.AllowFrameMoving, mover)

	-- move the bar
	TukuiBar2:ClearAllPoints()
	TukuiBar2:SetPoint("LEFT", mover, 0, 0)

	for i= 1, 12 do
		local b8 = _G["MultiBarBottomRightButton"..i]
		local b9 = _G["MultiBarBottomRightButton"..i-1]
		b8:SetSize(T.buttonsize, T.buttonsize)
		b8:ClearAllPoints()
		b8:SetFrameStrata("BACKGROUND")
		b8:SetFrameLevel(15)
		b8:SetAlpha(1)
		
		if i == 1 then
			b8:SetPoint("LEFT", TukuiBar2Mover, 0, 0)
		else
			b8:SetPoint("LEFT", b9, "RIGHT", T.buttonspacing, 0)
		end
	end
end

------------------------------------------------
-- bar2 horizontal right
------------------------------------------------
if not C.actionbar.b2bottom then
for i= 1, 12 do
	local b5 = _G["MultiBarBottomRightButton"..i]
	local b6 = _G["MultiBarBottomRightButton"..i-1]
	b5:SetSize(T.buttonsize, T.buttonsize)
	b5:ClearAllPoints()
	b5:SetFrameStrata("BACKGROUND")
	b5:SetFrameLevel(15)
	b5:SetAlpha(1)
		
	if i == 1 then
		b5:SetPoint("LEFT", TukuiBar2Mover, 0, 0)
	else
		b5:SetPoint("TOP", b6, "BOTTOM", 0, -T.buttonspacing)
	end
end
end

---------------------------------------------------
-- mouseover bar2
---------------------------------------------------
if C.actionbar.sidebar2mouseover then
	TukuiBar2:OnMouseOver("MultiBarBottomLeftButton", 12, 0, 1)
else
	TukuiBar2:Show()
end