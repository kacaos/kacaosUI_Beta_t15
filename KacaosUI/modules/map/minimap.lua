local T, C, L = unpack(Tukui)

---------------------------------------------------------------
-- Minimap
---------------------------------------------------------------

-- Now, I want to move Minimap from right to left, by default.
if C.misc.infobottom == false then
TukuiMinimap:ClearAllPoints()
TukuiMinimap:Point("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 0, 0)
else
TukuiMinimap:ClearAllPoints()
TukuiMinimap:Point("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -3, 18)
end

-- I find the map too big, resize it!
TukuiMinimap:Size(120)
Minimap:Size(120)

-- Parent Minimap into our Map frame.
Minimap:SetParent(TukuiMinimap)
Minimap:ClearAllPoints()
Minimap:Point("TOPLEFT", 1, -1)
Minimap:Point("BOTTOMRIGHT", -1, 1)

-- I want to kill the panels datatext under map!
TukuiMinimapStatsLeft:Hide()
TukuiMinimapStatsRight:Hide()

-- moved the mapstatright top to get the raidutility shown
TukuiMinimapStatsRight:ClearAllPoints()
TukuiMinimapStatsRight:Point("TOPLEFT", UIParent, 450, 21)

-- shitty 3.3 flag to move
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetParent(Minimap)
MiniMapInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, -1)

-- 4.0.6 Guild instance difficulty
GuildInstanceDifficulty:ClearAllPoints()
GuildInstanceDifficulty:SetParent(Minimap)
GuildInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, -1)