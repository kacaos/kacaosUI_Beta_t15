local T, C, L = unpack(Tukui)
if not C.actionbar.enable == true then return end
if C.actionbar.style ~= 2 then return end

-- Kill backdrop
TukuiBar1:SetBackdrop(nil)

--------------------------------------------------------------
-- make tukuibar1 2x6
--------------------------------------------------------------
local bar = TukuiBar1
--------------------------------------------------------------------------
-- Setup Main Action Bar.
-- Now used for stances, Bonus, Vehicle at the same time.
-- Since t12, it's also working for druid cat stealth. (a lot requested)
---------------------------------------------------------------------------

--This frame puts spells on the damn actionbar, fucking obliterate that shit
IconIntroTracker:UnregisterAllEvents()
IconIntroTracker:Hide()
IconIntroTracker:SetParent(UIHider)

local bar = TukuiBar1
bar:HookScript("OnEvent", function(self, event, unit)
	if event == "PLAYER_ENTERING_WORLD" then
		local button
		for i = 1, 12 do
			button = _G["ActionButton" .. i]
			button:SetSize(T.buttonsize, T.buttonsize)
			button:ClearAllPoints()
			button:SetParent(bar)
			button:SetFrameStrata("BACKGROUND")
			button:SetFrameLevel( 15 )
			if i == 1 then
					button:Point("BOTTOMLEFT", T.buttonspacing, 0)
			elseif i == 7 then
					button:SetPoint("BOTTOMLEFT", bar, T.buttonspacing, (T.buttonsize+T.buttonspacing))
			else
				local previous = _G["ActionButton" .. i-1]
				button:SetPoint("LEFT", previous, "RIGHT", T.buttonspacing, 0)
			end
		end
	end
end)

-----------------------------------------------------
-- add movers to actionbars
-----------------------------------------------------
local mover = CreateFrame("Frame", "TukuiBar1Mover", UIParent)
mover:Width(162)
mover:Height(51)
mover:Point("CENTER", UIParent, "CENTER", 0, -280)
mover:SetTemplate("Transparent")
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
TukuiBar1:SetPoint("BOTTOMLEFT", mover, 0, 0)