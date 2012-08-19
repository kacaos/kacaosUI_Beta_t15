local T, C, L = unpack(Tukui)
if not C.actionbar.enable == true then return end
if C.actionbar.style ~= 1 then return end

-- Kill backdrop
TukuiBar4:SetBackdrop(nil)

-- move the bar
TukuiBar4:ClearAllPoints()
TukuiBar4:SetPoint("BOTTOMLEFT", TukuiBar1, 0, 0)

---------------------------------------------------
-- option for 2 bottombars
---------------------------------------------------
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

----------------------------------------------
--bar 4 mover
----------------------------------------------
if C.actionbar.bar4 then
local mover = CreateFrame("Frame", "TukuiBar4Mover", UIParent)
mover:Width(27)
mover:Height(27)
mover:Point("LEFT", TukuiBar1, 0, (T.buttonsize+T.buttonspacing))
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