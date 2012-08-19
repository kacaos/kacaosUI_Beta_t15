local T, C, L = unpack(Tukui)
if not C.actionbar.enable == true then return end
if C.actionbar.style ~= 2 then return end

-- kill some buttons for bar4
TukuiBar4:Size(0.001, 0.001)
TukuiBar4:SetAlpha(0)