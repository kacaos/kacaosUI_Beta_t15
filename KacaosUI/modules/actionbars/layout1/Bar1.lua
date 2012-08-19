local T, C, L = unpack(Tukui)
if not C.actionbar.enable == true then return end
if C.actionbar.style ~= 1 then return end

-- Kill backdrop
TukuiBar1:SetBackdrop(nil)


-- set the bar
TukuiBar1:SetFrameLevel(2)
TukuiBar1:SetWidth((T.buttonsize * 14) + (T.buttonspacing * 15))
TukuiBar1:SetHeight((T.buttonsize * 1) + (T.buttonspacing * 2))

--------------------------------------------------
-- add mover
--------------------------------------------------
local mover = CreateFrame("Frame", "TukuiBar1Mover", UIParent)

if C.actionbar.bar4 then
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

		-- move bar
		TukuiBar1:ClearAllPoints()
		TukuiBar1:SetPoint("LEFT", mover, 0, 0)
else
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
		
		-- move bar
		TukuiBar1:ClearAllPoints()
		TukuiBar1:SetPoint("LEFT", mover, 0, 0)
end

