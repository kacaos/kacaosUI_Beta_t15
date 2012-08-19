local T, C, L = unpack(Tukui)
if not C.actionbar.enable == true then return end
if C.actionbar.style ~= 1 then return end

-----------------------------------------------
-- kill button bar2
-----------------------------------------------
TukuiBar2Button:Size(0.0001,0.0001)
TukuiBar2Button:SetAlpha(0)

-----------------------------------------------
-- kill button bar3
-----------------------------------------------
TukuiBar3Button:SetParent(TukUIHider)
TukuiBar3Button:SetParent(TukUIHider)

-----------------------------------------------
-- kill button bar4
-----------------------------------------------
TukuiBar4Button:SetParent(TukUIHider)

-----------------------------------------------
-- kill button bar5
-----------------------------------------------
TukuiBar5ButtonTop:SetParent(TukUIHider)
TukuiBar5ButtonBottom:SetParent(TukUIHider)