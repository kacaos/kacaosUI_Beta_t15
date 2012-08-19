local T, C, L = unpack(Tukui)
if not C.actionbar.enable == true then return end
if C.actionbar.style ~= 2 then return end

-- Kill nackdrop
TukuiBar2:SetBackdrop(nil)

-- Move the bar
TukuiBar2:ClearAllPoints()
TukuiBar2:SetPoint("TOPRIGHT", ActionButton7, "TOPLEFT", -10, 3)