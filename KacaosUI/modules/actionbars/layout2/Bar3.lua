local T, C, L = unpack(Tukui)
if not C.actionbar.enable == true then return end
if C.actionbar.style ~= 2 then return end

-- Kill backdrop
TukuiBar3:SetBackdrop(nil)

-- Move the bar
TukuiBar3:ClearAllPoints()
TukuiBar3:SetPoint("TOPLEFT", ActionButton12, "TOPRIGHT", 10, 3)