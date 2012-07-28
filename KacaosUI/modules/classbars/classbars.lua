local T, C, L, G = unpack(Tukui)

local tbWidth, tbHeight = C.classbar.soulShards[2], C.classbar.soulShards[3]

-------------------------------------
-- mover
-------------------------------------
local mover = CreateFrame("Frame", "tbMover", UIParent)
mover:Width(tbWidth)
mover:Height(tbHeight+3)
mover:Point("TOP", UIParent, "CENTER", 0, -15)
mover:SetTemplate()
mover:SetBackdropBorderColor(1,0,0)
mover:SetClampedToScreen(true)
mover:SetMovable(true)
mover:SetFrameStrata("HIGH")
mover:Hide()
mover:FontString("Text", C.media.font, 12)
mover.Text:SetPoint("CENTER", tbMover, "CENTER", 0, 0)
mover.Text:SetText(L.mover_tbMover)
tinsert(T.AllowFrameMoving, mover)

--------------------------------------
-- Warlock
--------------------------------------

			if( T.myclass == "WARLOCK" ) then
				if( C.classbar.soulShards[1] ~= true ) then
					G.UnitFrames.Player.WarlockSpecBars:Kill()
				else	
					G.UnitFrames.Player.WarlockSpecBars:ClearAllPoints()
					G.UnitFrames.Player.WarlockSpecBars:SetPoint("CENTER", mover)
					G.UnitFrames.Player.WarlockSpecBars:Size(tbWidth, tbHeight)
					G.UnitFrames.Player.WarlockSpecBars:SetFrameStrata("LOW")
					G.UnitFrames.Player.WarlockSpecBars:CreateBorder(false, true)
					for i = 1, 4  do

						if i == 1 then
							G.UnitFrames.Player.WarlockSpecBars[i]:Point("TOPLEFT", G.UnitFrames.Player.WarlockSpecBars, "BOTTOMLEFT", 0, tbHeight)
							G.UnitFrames.Player.WarlockSpecBars[i]:Size(tbWidth/4, tbHeight)
						else
							G.UnitFrames.Player.WarlockSpecBars[i]:Point("LEFT", G.UnitFrames.Player.WarlockSpecBars[i-1], "RIGHT", 1, 0)
							G.UnitFrames.Player.WarlockSpecBars[i]:Size(tbWidth/4, tbHeight)
						end
					end	
				end
			end


-------------------------------------
-- Druid
-------------------------------------

local tbWidth, tbHeight = C.classbar.eclipseBar[2], C.classbar.eclipseBar[3]

			if( T.myclass == "DRUID" ) then
				if( C.classbar.eclipseBar[1] ~= true ) then
					G.UnitFrames.Player.EclipseBar:Kill()
			else					
					G.UnitFrames.Player.DruidManaBackground:Kill()
					G.UnitFrames.Player.EclipseBar:ClearAllPoints()
					G.UnitFrames.Player.EclipseBar:SetPoint("CENTER", mover)
					G.UnitFrames.Player.EclipseBar:Size(tbWidth, tbHeight)
					G.UnitFrames.Player.EclipseBar:CreateBorder(false, true)
					G.UnitFrames.Player.EclipseBar:SetFrameStrata("LOW")
					G.UnitFrames.Player.EclipseBar.LunarBar:SetSize( G.UnitFrames.Player.EclipseBar:GetWidth(), G.UnitFrames.Player.EclipseBar:GetHeight() )
					G.UnitFrames.Player.EclipseBar.SolarBar:SetSize( G.UnitFrames.Player.EclipseBar:GetWidth(), G.UnitFrames.Player.EclipseBar:GetHeight() )
					G.UnitFrames.Player.EclipseBar.Text:ClearAllPoints()
					G.UnitFrames.Player.EclipseBar.Text:SetPoint( "TOP", G.UnitFrames.Player.EclipseBar, 0, tbHeight)
					G.UnitFrames.Player.EclipseBar.Text:SetFont(C.media.pixelfont, tbHeight, "MONOCHROMEOUTLINE")
					G.UnitFrames.Player.EclipseBar.Text:SetShadowOffset( T.mult, -T.mult )					
				end
			end
					
			if (T.myclass == "DRUID") then
					G.UnitFrames.Player.DruidManaText:Kill()
			end
			
-------------------------------------
-- Deathknight
-------------------------------------
local tbWidth, tbHeight = C.classbar.runeBars[2], C.classbar.runeBars[3]

if( T.myclass == "DEATHKNIGHT" ) then
				if( C.classbar.runeBars[1] ~= true ) then
					G.UnitFrames.Player.Runes:Kill()
					for i = 1, 6 do
						G.UnitFrames.Player.Runes[i]:Kill()
					end
				else	
					G.UnitFrames.Player.Runes:ClearAllPoints()
					G.UnitFrames.Player.Runes:SetPoint("CENTER", mover)
					G.UnitFrames.Player.Runes:Size(tbWidth+4, tbHeight)
					G.UnitFrames.Player.Runes:CreateBorder(false, true)

					for i = 1, 6 do
						if( i == 1 ) then
							G.UnitFrames.Player.Runes[i]:SetPoint( "BOTTOMLEFT", G.UnitFrames.Player.Runes, "TOPLEFT", 0, -tbHeight)
							G.UnitFrames.Player.Runes[i]:Size(tbWidth/6, tbHeight)
						elseif( i == 2 or i == 3 ) then
							G.UnitFrames.Player.Runes[i]:Size(tbWidth/6, tbHeight)
						else
							G.UnitFrames.Player.Runes[i]:Point("LEFT", G.UnitFrames.Player.Runes[i - 1], "RIGHT", 1, 0)
							G.UnitFrames.Player.Runes[i]:Size(tbWidth/6, tbHeight)
						end
					end
				end
			end
			
--------------------------------------
-- Shaman
--------------------------------------

local tbWidth, tbHeight = C.classbar.totemTimers[2], C.classbar.totemTimers[3]

if( T.myclass == "SHAMAN" ) then
				if( C.classbar.totemTimers[1] ~= true ) then
					for i = 1, 4  do
						G.UnitFrames.Player.TotemBar[i]:Kill()
					end
				else	
					local totembg = CreateFrame("Frame", "totembg", UIParent)
					totembg:Size(tbWidth, tbHeight)
					totembg:SetPoint("CENTER", mover)
					totembg:SetTemplate("Default")
					totembg:CreateBorder(false, true)

					for i = 1, 4  do
						if i == 1 then
							G.UnitFrames.Player.TotemBar[i]:ClearAllPoints()
							G.UnitFrames.Player.TotemBar[i]:SetPoint("BOTTOMLEFT", totembg, "TOPLEFT", 0, -tbHeight)
							G.UnitFrames.Player.TotemBar[i]:Size(tbWidth/4, tbHeight)
						else
							G.UnitFrames.Player.TotemBar[i]:ClearAllPoints()
							G.UnitFrames.Player.TotemBar[i]:Point("LEFT", G.UnitFrames.Player.TotemBar[i-1], "RIGHT", 1, 0)
							G.UnitFrames.Player.TotemBar[i]:Size(tbWidth/4, tbHeight)
						end
					end
				end
			end
			
--------------------------------------
-- Priest
--------------------------------------

local tbWidth, tbHeight = C.classbar.shadowOrb[2], C.classbar.shadowOrb[3]

if( T.myclass == "PRIEST" ) then
				if( C.classbar.shadowOrb[1] ~= true ) then
					G.UnitFrames.Player.ShadowOrbsBar:Kill()
				else	
					G.UnitFrames.Player.ShadowOrbsBar:ClearAllPoints()
					G.UnitFrames.Player.ShadowOrbsBar:SetPoint("CENTER", mover)
					G.UnitFrames.Player.ShadowOrbsBar:Size(tbWidth, tbHeight)
					G.UnitFrames.Player.ShadowOrbsBar:SetFrameStrata("LOW")
					G.UnitFrames.Player.ShadowOrbsBar:CreateBorder(false, true)
					for i = 1, 3  do

						if i == 1 then
							G.UnitFrames.Player.ShadowOrbsBar[i]:SetPoint( "BOTTOMLEFT", G.UnitFrames.Player.ShadowOrbsBar, "TOPLEFT", 0, -tbHeight)
							G.UnitFrames.Player.ShadowOrbsBar[i]:Size(tbWidth/3, tbHeight)
						else
							G.UnitFrames.Player.ShadowOrbsBar[i]:Point("LEFT", G.UnitFrames.Player.ShadowOrbsBar[i-1], "RIGHT", 1, 0)
							G.UnitFrames.Player.ShadowOrbsBar[i]:Size(tbWidth/3, tbHeight)
						end
					end
				end
			end
			
-------------------------------------
-- Monk
-------------------------------------

local tbWidth, tbHeight = C.classbar.harmonyBar[2], C.classbar.harmonyBar[3]

if T.myclass == "MONK" then
				if( C.classbar.harmonyBar[1] ~= true ) then
					G.UnitFrames.Player.HarmonyBar:Kill()
				else	
					G.UnitFrames.Player.HarmonyBar:ClearAllPoints()
					G.UnitFrames.Player.HarmonyBar:SetPoint("CENTER", mover)
					G.UnitFrames.Player.HarmonyBar:Size(tbWidth, tbHeight)
					G.UnitFrames.Player.HarmonyBar:SetFrameStrata("LOW")
					G.UnitFrames.Player.HarmonyBar:CreateBorder(false, true)
					for i = 1, 5 do

						if i == 1 then
							G.UnitFrames.Player.HarmonyBar[i]:Point("TOPLEFT", G.UnitFrames.Player.HarmonyBar, "BOTTOMLEFT", 0, tbHeight)
							G.UnitFrames.Player.HarmonyBar[i]:Size(tbWidth, tbHeight)
						else
							G.UnitFrames.Player.HarmonyBar[i]:Point("LEFT", G.UnitFrames.Player.HarmonyBar[i-1], "RIGHT", 1, 0)
							G.UnitFrames.Player.HarmonyBar[i]:Size(tbWidth, tbHeight)
						end
					end

					-- energy bar
					local nPowerBG = CreateFrame("Frame", "nPowerBG", G.UnitFrames.Player.HarmonyBar)
					nPowerBG:Size((G.UnitFrames.Player.HarmonyBar:GetWidth()+6), G.UnitFrames.Player.HarmonyBar:GetHeight()*1.5)
					nPowerBG:Point("TOPLEFT", G.UnitFrames.Player.HarmonyBar, "BOTTOMLEFT", -3, -5)
					nPowerBG:SetTemplate("Default")
					local nPowerStatus = CreateFrame("StatusBar", "nPowerStatus", nPowerBG)
					nPowerStatus:SetStatusBarTexture(C["media"].normTex)
					nPowerStatus:SetFrameLevel(6)
					nPowerStatus:Point("TOPLEFT", nPowerBG, "TOPLEFT", 2, -2)
					nPowerStatus:Point("BOTTOMRIGHT", nPowerBG, "BOTTOMRIGHT", -2, 2)
					nPowerStatus.t = nPowerStatus:CreateFontString(nil, "OVERLAY")
					nPowerStatus.t:SetPoint("CENTER", 0, -1)
					nPowerStatus.t:SetFont(C.media.pixelfont, tbHeight, "MONOCHROMEOUTLINE")
					nPowerStatus.t:SetShadowOffset(0.5, -0.5)
					nPowerStatus.t:SetShadowColor(0,0,0)
					local color = RAID_CLASS_COLORS[T.myclass]
					nPowerStatus:SetStatusBarColor(color.r, color.g, color.b)
					local t = 0
					nPowerStatus:SetScript("OnUpdate", function(self, elapsed)
						t = t + elapsed;
						if (t > 0.07) then
							nPowerStatus:SetMinMaxValues(0, UnitPowerMax("player"))
							local power = UnitPower("player")
							nPowerStatus:SetValue(power)
							nPowerStatus.t:SetText(power)
						end
					end)
				end
			end
			
-----------------------------------------
-- Paladin
-----------------------------------------

local tbWidth, tbHeight = C.classbar.holyPower[2], C.classbar.holyPower[3]

if( T.myclass == "PALADIN" ) then
				if( C.classbar.holyPower[1] ~= true ) then
					G.UnitFrames.Player.HolyPower:Kill()
					for i = 1, 5 do
						G.UnitFrames.Player.HolyPower[i]:Kill()
					end
				else	
					G.UnitFrames.Player.HolyPower:ClearAllPoints()
					G.UnitFrames.Player.HolyPower:SetPoint("CENTER", mover)
					G.UnitFrames.Player.HolyPower:Size(tbWidth, tbHeight)
					G.UnitFrames.Player.HolyPower:SetFrameStrata("LOW")
					G.UnitFrames.Player.HolyPower:CreateBorder(false, true)
					for i = 1, 5  do
							G.UnitFrames.Player.HolyPower[i]:SetStatusBarColor( 228 / 255, 225 / 255, 16 / 255 )
						if i == 1 then
							G.UnitFrames.Player.HolyPower[i]:Point("TOPLEFT", G.UnitFrames.Player.HolyPower, "BOTTOMLEFT", 0, tbHeight)
							G.UnitFrames.Player.HolyPower[i]:Size(tbWidth/5, tbHeight)
						else
							G.UnitFrames.Player.HolyPower[i]:Point("LEFT", G.UnitFrames.Player.HolyPower[i-1], "RIGHT", 1, 0)
							G.UnitFrames.Player.HolyPower[i]:Size(tbWidth/5, tbHeight)
						end
					end	
				end
			end
			
----------------------------------------
-- Rogue
----------------------------------------

local tbWidth, tbHeight = C.classbar.comboPoints[2], C.classbar.comboPoints[3]
local combobar = G.UnitFrames.Player.ComboPointsBar or G.UnitFrames.Target.ComboPointsBar
if( T.myclass == "ROGUE") then
if (T.myclass == "DRUID") then
				if( C.classbar.comboPoints[1] ~= true ) then
					combobar:Kill()
				else	
					combobar:ClearAllPoints()
					combobar:SetPoint("CENTER", mover)
					combobar:Size(tbWidth+5, tbHeight)
					combobar:SetFrameStrata("LOW")
					combobar:CreateBorder(false, true)
					for i = 1, 5  do

						if i == 1 then
							combobar[i]:Point("TOPLEFT", combobar, "BOTTOMLEFT", 0, tbHeight)
							combobar[i]:Size(tbWidth/5, tbHeight)
						else
							combobar[i]:Point("LEFT", combobar[i-1], "RIGHT", 1, 0)
							combobar[i]:Size(tbWidth/5, tbHeight)
						end
					end	

					local sPowerBG = CreateFrame("Frame", "sPowerBG", TukuiTarget)
					sPowerBG:Size((combobar:GetWidth()+6), combobar:GetHeight()*1.5)
					sPowerBG:Point("TOPLEFT", combobar, "BOTTOMLEFT", -3, -5)
					local sPowerStatus = CreateFrame("StatusBar", "sPowerStatus", TukuiTarget)
					sPowerStatus:SetStatusBarTexture(C["media"].normTex)
					sPowerStatus:CreateBorder(false, true)
					sPowerStatus:SetTemplate("Default")
					sPowerStatus:Point("TOPLEFT", sPowerBG, "TOPLEFT", 2, -2)
					sPowerStatus:Point("BOTTOMRIGHT", sPowerBG, "BOTTOMRIGHT", -2, 2)
					sPowerStatus.t = sPowerStatus:CreateFontString(nil, "OVERLAY")
					sPowerStatus.t:SetPoint("CENTER")
					sPowerStatus.t:SetFont(C.media.pixelfont, tbHeight, "MONOCHROMEOUTLINE")
					sPowerStatus.t:SetShadowOffset(0.5, -0.5)
					sPowerStatus.t:SetShadowColor(0,0,0)
					local color = RAID_CLASS_COLORS[T.myclass]
					sPowerStatus:SetStatusBarColor(color.r, color.g, color.b)
					local t = 0
					sPowerStatus:SetScript("OnUpdate", function(self, elapsed)
						t = t + elapsed;
						if (t > 0.07) then
							sPowerStatus:SetMinMaxValues(0, UnitPowerMax("player"))
							local power = UnitPower("player")
							sPowerStatus:SetValue(power)
							sPowerStatus.t:SetText(power)
						end
					end)		
				end
			end
			end