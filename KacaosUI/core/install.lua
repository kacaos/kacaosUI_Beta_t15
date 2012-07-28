local T, C, L, G = unpack(Tukui)

G.Install.Frame:SetFrameStrata("High")
G.Install.Frame:SetTemplate("Transparent")

TukuiPopupDialog1:SetFrameStrata("HIGH")

TukuiRollAnchor:ClearAllPoints()
TukuiRollAnchor:Point("CENTER", UIParent, "CENTER", 0, 50)