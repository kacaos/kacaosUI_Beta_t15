local T, C, L, G = unpack(Tukui)
if not C.actionbar.enable == true then return end
if C.actionbar.style ~= 2 then return end

------------------------------------------------------
-- move buttons bar2
------------------------------------------------------
TukuiBar3Button:ClearAllPoints()
TukuiBar3Button:SetPoint("LEFT", ActionButton6, "RIGHT", 5, 15)

TukuiBar3Button.ClearAllPoints = T.dummy
TukuiBar3Button.SetPoint = T.dummy

------------------------------------------------------
-- move buttons bar3
------------------------------------------------------
TukuiBar2Button:ClearAllPoints()
TukuiBar2Button:SetPoint("RIGHT", ActionButton1, "LEFT", -5, 15)

TukuiBar2Button.ClearAllPoints = T.dummy
TukuiBar2Button.SetPoint = T.dummy

------------------------------------------------------
-- kill buttons bar4
------------------------------------------------------
TukuiBar4Button:Size(0.001, 0.001)
TukuiBar4Button:SetAlpha(0)

------------------------------------------------------
-- kill buttons bar5
------------------------------------------------------
TukuiBar5ButtonTop:Size(0.001, 0.001)
TukuiBar5ButtonTop:SetAlpha(0)
TukuiBar5ButtonBottom:Size(0.001, 0.001)
TukuiBar5ButtonBottom:SetAlpha(0)