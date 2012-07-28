local T, C, L = unpack(Tukui)
if not C.actionbar.enable == true then return end
if C.actionbar.style ~= 1 then return end
---------------------------------------------------------------
-- Action Bars
---------------------------------------------------------------

-- move main bar
TukuiBar1:ClearAllPoints()
TukuiBar1:SetPoint("BOTTOM", 0, 2)
TukuiBar1:SetFrameLevel(2)
TukuiBar1:SetWidth((T.buttonsize * 14) + (T.buttonspacing * 15))
TukuiBar1:SetHeight((T.buttonsize * 1) + (T.buttonspacing * 2))
TukuiBar4:ClearAllPoints()
TukuiBar4:SetPoint("BOTTOMLEFT", TukuiBar1, 0, 0)

-- Kill backdrop of bars
TukuiBar2:SetBackdrop(nil)
TukuiBar3:SetBackdrop(nil)
TukuiBar4:SetBackdrop(nil)
TukuiBar5:SetBackdrop(nil)
TukuiBar1:SetBackdrop(nil)
TukuiPetBar:SetBackdrop(nil)

-- if the option I added earlier is enabled do this
if C.actionbar.allbars then
	-- Now, I want relocate some action bars
	TukuiBar2:ClearAllPoints()
	TukuiBar3:ClearAllPoints()
	TukuiBar5:ClearAllPoints()
	TukuiBar2:Point("BOTTOMLEFT", TukuiBar4, "TOPLEFT", 0, -3000)
	TukuiBar3:Point("BOTTOMRIGHT", TukuiBar4, "TOPRIGHT", 0, -3000)
	TukuiBar5:Point("BOTTOMLEFT", TukuiBar2, "TOPLEFT", 0, 4000)
	
		--bar 5 mover
		local mover = CreateFrame("Frame", "TukuiBar5Mover", UIParent)
		mover:Width(27)
		mover:Height(27)
		mover:Point("TOPRIGHT", UIParent, -38, -410)
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

	-- bar5 horizontal right
	for i= 1, 12 do
		local b = _G["MultiBarRightButton"..i]
		local b2 = _G["MultiBarRightButton"..i-1]
		b:SetSize(20, 20)
		b:ClearAllPoints()
		b:SetFrameStrata("BACKGROUND")
		b:SetFrameLevel(15)
		
		if i == 1 then
			b:SetPoint("LEFT", TukuiBar5Mover, 0, 0)
		else
			b:SetPoint("TOP", b2, "BOTTOM", 0, -T.buttonspacing)
		end
		
	end

		--bar 3 mover
		local mover = CreateFrame("Frame", "TukuiBar3Mover", UIParent)
		mover:Width(27)
		mover:Height(27)
		mover:Point("TOPRIGHT", UIParent, -68, -410)
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

	-- bar3 horizontal right
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
	
	if not C.actionbar.b2bottom == true then
	--bar 2 mover
	local mover = CreateFrame("Frame", "TukuiBar2Mover", UIParent)
		mover:Width(27)
		mover:Height(27)
		mover:Point("TOPRIGHT", UIParent, -98, -410)
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
	-- bar2 horizontal right
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
	
	
	if C.actionbar.bar4 then
	TukuiBar4:Show()

	TukuiBar1:ClearAllPoints()
	TukuiBar1:SetPoint("BOTTOM", 27, 2)

	else

	-- bar4 extra buttons right to bar1
	for i= 1, 12 do
		local b7 = _G["MultiBarLeftButton"..i]
		local b8 = _G["MultiBarLeftButton"..i-1]
		b7:SetSize(T.buttonsize, T.buttonsize)
		b7:ClearAllPoints()
		b7:SetFrameStrata("BACKGROUND")
		b7:SetFrameLevel(15)

		if i == 1 then
		b7:SetPoint("LEFT", _G["ActionButton12"], "RIGHT", T.buttonspacing, 0)
		elseif i == 3 then
		b7:SetPoint("TOP", _G["ActionButton8"], "TOP", -64, 25)
		else
		b7:SetPoint("LEFT", b8, "RIGHT", T.buttonspacing, 0)
		end
		
		-- kill button 3-12 from bar4
		MultiBarLeftButton3:Kill()
		MultiBarLeftButton4:Kill()
		MultiBarLeftButton5:Kill()
		MultiBarLeftButton6:Kill()
		MultiBarLeftButton7:Kill()
		MultiBarLeftButton8:Kill()
		MultiBarLeftButton9:Kill()
		MultiBarLeftButton10:Kill()
		MultiBarLeftButton11:Kill()
		MultiBarLeftButton12:Kill()
	end
end
end

if C.actionbar.b2bottom then

--bar 2 mover
local mover = CreateFrame("Frame", "TukuiBar2Mover", UIParent)
mover:Width(27)
mover:Height(27)
mover:Point("LEFT", TukuiBar4, 3, TukuiBar4:GetHeight()-17)
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
	

-- if my new option is no enabled, hide them
if not C.actionbar.allbars then
	TukuiBar2:Hide()
	TukuiBar3:Hide()
	TukuiBar4:Hide()
	TukuiBar5:Hide()
end


-- sidebars on mouseover
if C.actionbar.sidebar1mouseover then
	TukuiBar5:OnMouseOver("MultiBarRightButton", 12, 0, 1)
else
	TukuiBar5:Show()
end

if C.actionbar.sidebar2mouseover then
	TukuiBar2:OnMouseOver("MultiBarBottomLeftButton", 12, 0, 1)
else
	TukuiBar2:Show()
end

if C.actionbar.sidebar3mouseover then
	TukuiBar3:OnMouseOver("MultiBarBottomRightButton", 12, 0, 1)
else
	TukuiBar3:Show()
end

-- kill the show/hide button because they doesn't fit my new bar layout
TukuiBar2Button:Kill()
TukuiBar3Button:Kill()
TukuiBar3Button:Kill()
TukuiBar4Button:Kill()
TukuiBar5ButtonTop:Kill()
TukuiBar5ButtonBottom:Kill()


--------------------------------------------------
-- add movers to actionbars
--------------------------------------------------

--bar 1 mover
if C.actionbar.bar4 then
local mover = CreateFrame("Frame", "TukuiBar1Mover", UIParent)
mover:Width(27)
mover:Height(27)
mover:Point("BOTTOM", -148, 2)
mover:SetTemplate()
mover:SetBackdropBorderColor(0,1,0)
mover:SetClampedToScreen(true)
mover:SetMovable(true)
mover:SetFrameStrata("HIGH")
mover:Hide()
mover:FontString("Text", C.media.font, 12)
mover.Text:SetPoint("CENTER", TukuiBar1Mover, "CENTER", 0, 0)
mover.Text:SetText(L.mover_bar1)
tinsert(T.AllowFrameMoving, mover)
TukuiBar1:ClearAllPoints()
TukuiBar1:SetPoint("LEFT", mover, 0, 0)
else
local mover = CreateFrame("Frame", "TukuiBar1Mover", UIParent)
mover:Width(27)
mover:Height(27)
mover:Point("BOTTOM", -177, 2)
mover:SetTemplate()
mover:SetBackdropBorderColor(0,1,0)
mover:SetClampedToScreen(true)
mover:SetMovable(true)
mover:SetFrameStrata("HIGH")
mover:Hide()
mover:FontString("Text", C.media.font, 12)
mover.Text:SetPoint("CENTER", TukuiBar1Mover, "CENTER", 0, 0)
mover.Text:SetText(L.mover_bar1)
tinsert(T.AllowFrameMoving, mover)
TukuiBar1:ClearAllPoints()
TukuiBar1:SetPoint("LEFT", mover, 0, 0)
end

--bar 4 mover
if C.actionbar.bar4 then
local mover = CreateFrame("Frame", "TukuiBar4Mover", UIParent)
mover:Width(27)
mover:Height(27)
mover:Point("BOTTOM", -148, 30)
mover:SetTemplate()
mover:SetBackdropBorderColor(0,1,0)
mover:SetClampedToScreen(true)
mover:SetMovable(true)
mover:SetFrameStrata("HIGH")
mover:Hide()
mover:FontString("Text", C.media.font, 12)
mover.Text:SetPoint("CENTER", TukuiBar4Mover, "CENTER", 0, 0)
mover.Text:SetText(L.mover_bar4)
tinsert(T.AllowFrameMoving, mover)
TukuiBar4:ClearAllPoints()
TukuiBar4:SetPoint("LEFT", mover, 0, -15)
end

local mover = CreateFrame("Frame", "TukuiPetBarMover", UIParent)
mover:Width(20)
mover:Height(100)
mover:Point("RIGHT", UIParent, -6, -39)
mover:SetTemplate("Transparent")
mover:SetBackdropBorderColor(0,1,0)
mover:SetClampedToScreen(true)
mover:SetMovable(true)
mover:SetFrameStrata("HIGH")
mover:Hide()
mover:FontString("Text", C.media.font, 12)
mover.Text:SetPoint("CENTER", TukuiPetBarMover, "CENTER", 0, 0)
mover.Text:SetText(L.mover_petbar)
tinsert(T.AllowFrameMoving, mover)
TukuiPetBar:ClearAllPoints()
TukuiPetBar:SetPoint("LEFT", mover, 0, 0)