local T, C, L, G = unpack(Tukui)

local tbWidth = C.classbar.width
local tbHeight = C.classbar.height
local ebWidth = C.classbar.ebwidth

-------------------------------------
-- mover
-------------------------------------
local mover = CreateFrame("Frame", "tbMover", TukuiBar1)
mover:Width(tbWidth)
mover:Height(tbHeight+3)
mover:Point("BOTTOM", UIParent, "CENTER", 1, -200)
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
				if( C.classbar.warlock ~= true ) then
					G.UnitFrames.Player.WarlockSpecBars:Kill()
				else	
					G.UnitFrames.Player.WarlockSpecBars:ClearAllPoints()
					G.UnitFrames.Player.WarlockSpecBars:SetPoint("CENTER", mover)
					G.UnitFrames.Player.WarlockSpecBars:Size((tbWidth*4)+3, tbHeight)
					G.UnitFrames.Player.WarlockSpecBars:SetFrameStrata("LOW")
					G.UnitFrames.Player.WarlockSpecBars:CreateBorder(false, true)
					for i = 1, 4  do

						if i == 1 then
							G.UnitFrames.Player.WarlockSpecBars[i]:Point("TOPLEFT", G.UnitFrames.Player.WarlockSpecBars, "BOTTOMLEFT", 0, tbHeight)
							G.UnitFrames.Player.WarlockSpecBars[i]:Size(tbWidth*4, tbHeight)
						else
							G.UnitFrames.Player.WarlockSpecBars[i]:Point("LEFT", G.UnitFrames.Player.WarlockSpecBars[i-1], "RIGHT", 1, 0)
							G.UnitFrames.Player.WarlockSpecBars[i]:Size(tbWidth*4, tbHeight)
						end
					end	
				local wlPowerStatus = CreateFrame("StatusBar", "wlPowerStatus", G.UnitFrames.Player.WarlockSpecBars)
					wlPowerStatus:Point("TOPLEFT", G.UnitFrames.Player.WarlockSpecBars, "TOPLEFT", 2, -2)
					wlPowerStatus:Point("BOTTOMRIGHT", G.UnitFrames.Player.WarlockSpecBars, "BOTTOMRIGHT", -2, 2)
					wlPowerStatus.t = wlPowerStatus:CreateFontString(nil, "OVERLAY")
					wlPowerStatus.t:SetPoint("CENTER")
					wlPowerStatus.t:SetFont(C.media.pixelfont, 10, "MONOCHROMEOUTLINE")
					
					local function showpower()
						local spec = GetSpecialization()
						local SPEC_WARLOCK_DEMONOLOGY = SPEC_WARLOCK_DEMONOLOGY
						local SPEC_WARLOCK_DESTRUCTION = SPEC_WARLOCK_DESTRUCTION
						local SPEC_WARLOCK_AFFLICTION = SPEC_WARLOCK_AFFLICTION
						
						if spec == SPEC_WARLOCK_DEMONOLOGY then
							local SPELL_POWER_DEMONIC_FURY = SPELL_POWER_DEMONIC_FURY
							local power = UnitPower("player", SPELL_POWER_DEMONIC_FURY)
							local maxPower = UnitPowerMax("player", SPELL_POWER_DEMONIC_FURY)
							wlPowerStatus:SetMinMaxValues(0, maxPower)
							wlPowerStatus:SetValue(power)
							wlPowerStatus.t:SetText(power)
						elseif spec == SPEC_WARLOCK_DESTRUCTION then
							local maxPower = UnitPowerMax("player", SPELL_POWER_BURNING_EMBERS, true)
							local power = UnitPower("player", SPELL_POWER_BURNING_EMBERS, true)
							local numBars = floor(maxPower / MAX_POWER_PER_EMBER)
							for i = 1, numBars do
								wlPowerStatus:SetMinMaxValues((MAX_POWER_PER_EMBER * i) - MAX_POWER_PER_EMBER, MAX_POWER_PER_EMBER * i)
								wlPowerStatus:SetValue(power)
							end
							wlPowerStatus.t:SetText(power)
						elseif spec == SPEC_WARLOCK_AFFLICTION then
							wlPowerStatus.t:SetText(power)
						end
					end
					
					local function createBars()
						wlPowerStatus:RegisterEvent('UNIT_POWER')
						wlPowerStatus:RegisterEvent("PLAYER_TALENT_UPDATE")
						wlPowerStatus:SetScript("OnEvent", showpower)
						showpower()
					end
					wlPowerStatus:RegisterEvent("PLAYER_ENTERING_WORLD")
					wlPowerStatus:SetScript("OnEvent",function(self,event)
						if event == "PLAYER_ENTERING_WORLD" then
							createBars()
							showpower()
						end
					end)
				
				end
			end


-------------------------------------
-- Druid
-------------------------------------

			if( T.myclass == "DRUID" ) then
				if( C.classbar.druid ~= true ) then
					G.UnitFrames.Player.EclipseBar:Kill()
			else					
					G.UnitFrames.Player.DruidManaBackground:Kill()
					G.UnitFrames.Player.EclipseBar:ClearAllPoints()
					G.UnitFrames.Player.EclipseBar:SetPoint("CENTER", mover)
					G.UnitFrames.Player.EclipseBar:Size(ebWidth, tbHeight)
					G.UnitFrames.Player.EclipseBar:CreateBorder(false, true)
					G.UnitFrames.Player.EclipseBar:SetFrameStrata("LOW")
					G.UnitFrames.Player.EclipseBar.LunarBar:SetSize( G.UnitFrames.Player.EclipseBar:GetWidth(), G.UnitFrames.Player.EclipseBar:GetHeight() )
					G.UnitFrames.Player.EclipseBar.SolarBar:SetSize( G.UnitFrames.Player.EclipseBar:GetWidth(), G.UnitFrames.Player.EclipseBar:GetHeight() )
					G.UnitFrames.Player.EclipseBar.Text:ClearAllPoints()
					G.UnitFrames.Player.EclipseBar.Text:SetPoint( "TOP", G.UnitFrames.Player.EclipseBar, 0, tbHeight)
					G.UnitFrames.Player.EclipseBar.Text:SetFont(C.media.pixelfont, tbHeight, "MONOCHROMEOUTLINE")
					G.UnitFrames.Player.EclipseBar.Text:SetShadowOffset( T.mult, -T.mult )	
					
					local DPowerStatus = CreateFrame("StatusBar", "DPowerStatus", G.UnitFrames.Player.EclipseBar)
					DPowerStatus:Point("TOPLEFT", G.UnitFrames.Player.EclipseBar, "TOPLEFT", 2, -2)
					DPowerStatus:Point("BOTTOMRIGHT", G.UnitFrames.Player.EclipseBar, "BOTTOMRIGHT", -2, 2)
					
					DPowerStatus.t = DPowerStatus:CreateFontString(nil, "OVERLAY")
					DPowerStatus.t:SetPoint("CENTER")
					DPowerStatus.t:SetFont(C.media.pixelfont, 10, "MONOCHROMEOUTLINE")
					DPowerStatus.t:SetShadowOffset(0.5, -0.5)
					DPowerStatus.t:SetShadowColor(0,0,0)
					
					local t = 0
					DPowerStatus:SetScript("OnUpdate", function(self, elapsed)
						t = t + elapsed;
						if (t > 0.07) then
							local power = UnitPower('player', SPELL_POWER_ECLIPSE)
							local maxPower = UnitPowerMax('player', SPELL_POWER_ECLIPSE)				
							DPowerStatus:SetMinMaxValues(-maxPower, maxPower)
							DPowerStatus:SetValue(power)
							DPowerStatus.t:SetText(power)
						end
					end)	
				end
			
end
					
			if (T.myclass == "DRUID") then
					G.UnitFrames.Player.DruidManaText:Kill()
			end
			
-------------------------------------
-- Deathknight
-------------------------------------

if( T.myclass == "DEATHKNIGHT" ) then
				if( C.classbar.deathknight ~= true ) then
					G.UnitFrames.Player.Runes:Kill()
					for i = 1, 6 do
						G.UnitFrames.Player.Runes[i]:Kill()
					end
				else	
					G.UnitFrames.Player.Runes:ClearAllPoints()
					G.UnitFrames.Player.Runes:SetPoint("CENTER", mover)
					G.UnitFrames.Player.Runes:Size((tbWidth*6)+5, tbHeight)
					G.UnitFrames.Player.Runes:CreateBorder(false, true)

					for i = 1, 6 do
						if( i == 1 ) then
							G.UnitFrames.Player.Runes[i]:SetPoint( "BOTTOMLEFT", G.UnitFrames.Player.Runes, "TOPLEFT", 0, -tbHeight)
							G.UnitFrames.Player.Runes[i]:Size(tbWidth, tbHeight)
						elseif( i == 2 or i == 3 ) then
							G.UnitFrames.Player.Runes[i]:Size(tbWidth, tbHeight)
						else
							G.UnitFrames.Player.Runes[i]:Point("LEFT", G.UnitFrames.Player.Runes[i - 1], "RIGHT", 1, 0)
							G.UnitFrames.Player.Runes[i]:Size(tbWidth, tbHeight)
						end
					end
				end
			end
			
--------------------------------------
-- Shaman
--------------------------------------

if( T.myclass == "SHAMAN" ) then
				if( C.classbar.shaman ~= true ) then
					for i = 1, 4  do
						G.UnitFrames.Player.TotemBar[i]:Kill()
					end
				else	
					local totembg = CreateFrame("Frame", "totembg", UIParent)
					totembg:Size((tbWidth*4)+3, tbHeight)
					totembg:SetPoint("CENTER", mover)
					totembg:SetTemplate("Default")
					totembg:CreateBorder(false, true)

					for i = 1, 4  do
						if i == 1 then
							G.UnitFrames.Player.TotemBar[i]:ClearAllPoints()
							G.UnitFrames.Player.TotemBar[i]:SetPoint("BOTTOMLEFT", totembg, "TOPLEFT", 0, -tbHeight)
							G.UnitFrames.Player.TotemBar[i]:Size(tbWidth, tbHeight)
						else
							G.UnitFrames.Player.TotemBar[i]:ClearAllPoints()
							G.UnitFrames.Player.TotemBar[i]:Point("LEFT", G.UnitFrames.Player.TotemBar[i-1], "RIGHT", 1, 0)
							G.UnitFrames.Player.TotemBar[i]:Size(tbWidth, tbHeight)
						end
					end
				end
			end
			
--------------------------------------
-- Priest
--------------------------------------

if( T.myclass == "PRIEST" ) then
				if( C.classbar.priest ~= true ) then
					G.UnitFrames.Player.ShadowOrbsBar:Kill()
				else	
					G.UnitFrames.Player.ShadowOrbsBar:ClearAllPoints()
					G.UnitFrames.Player.ShadowOrbsBar:SetPoint("CENTER", mover)
					G.UnitFrames.Player.ShadowOrbsBar:Size((tbWidth*3)+2, tbHeight)
					G.UnitFrames.Player.ShadowOrbsBar:SetFrameStrata("LOW")
					G.UnitFrames.Player.ShadowOrbsBar:CreateBorder(false, true)
					for i = 1, 3  do

						if i == 1 then
							G.UnitFrames.Player.ShadowOrbsBar[i]:SetPoint( "BOTTOMLEFT", G.UnitFrames.Player.ShadowOrbsBar, "TOPLEFT", 0, -tbHeight)
							G.UnitFrames.Player.ShadowOrbsBar[i]:Size(tbWidth, tbHeight)
						else
							G.UnitFrames.Player.ShadowOrbsBar[i]:Point("LEFT", G.UnitFrames.Player.ShadowOrbsBar[i-1], "RIGHT", 1, 0)
							G.UnitFrames.Player.ShadowOrbsBar[i]:Size(tbWidth, tbHeight)
						end
					end
				end
			end
			
-------------------------------------
-- Monk
-------------------------------------


if T.myclass == "MONK" then
			if( C.classbar.monk ~= true ) then
					G.UnitFrames.Player.HarmonyBar:Kill()
				else	
					G.UnitFrames.Player.HarmonyBar:ClearAllPoints()
					G.UnitFrames.Player.HarmonyBar:SetPoint("CENTER", mover)
					G.UnitFrames.Player.HarmonyBar:Size((sbWidth*5)+4, tbHeight)
					G.UnitFrames.Player.HarmonyBar:SetFrameStrata("LOW")
					G.UnitFrames.Player.HarmonyBar:CreateBorder(false, true)
					for i = 1, 5 do

						if i == 1 then
							G.UnitFrames.Player.HarmonyBar[i]:Point("TOPLEFT", G.UnitFrames.Player.HarmonyBar, "BOTTOMLEFT", 0, tbHeight)
							G.UnitFrames.Player.HarmonyBar[i]:Size(sbWidth, tbHeight)
						else
							G.UnitFrames.Player.HarmonyBar[i]:Point("LEFT", G.UnitFrames.Player.HarmonyBar[i-1], "RIGHT", 1, 0)
							G.UnitFrames.Player.HarmonyBar[i]:Size(sbWidth, tbHeight)
						end
					end
				end
	
end
			
-----------------------------------------
-- Paladin
-----------------------------------------

if( T.myclass == "PALADIN" ) then
				if( C.classbar.paladin ~= true ) then
					G.UnitFrames.Player.HolyPower:Kill()
					for i = 1, 5 do
						G.UnitFrames.Player.HolyPower[i]:Kill()
					end
				else	
					G.UnitFrames.Player.HolyPower:ClearAllPoints()
					G.UnitFrames.Player.HolyPower:SetPoint("CENTER", mover)
					G.UnitFrames.Player.HolyPower:Size((tbWidth*5)+4, tbHeight)
					G.UnitFrames.Player.HolyPower:SetFrameStrata("LOW")
					G.UnitFrames.Player.HolyPower:CreateBorder(false, true)
					for i = 1, 5  do
							G.UnitFrames.Player.HolyPower[i]:SetStatusBarColor( 228 / 255, 225 / 255, 16 / 255 )
						if i == 1 then
							G.UnitFrames.Player.HolyPower[i]:Point("TOPLEFT", G.UnitFrames.Player.HolyPower, "BOTTOMLEFT", 0, tbHeight)
							G.UnitFrames.Player.HolyPower[i]:Size(tbWidth, tbHeight)
						else
							G.UnitFrames.Player.HolyPower[i]:Point("LEFT", G.UnitFrames.Player.HolyPower[i-1], "RIGHT", 1, 0)
							G.UnitFrames.Player.HolyPower[i]:Size(tbWidth, tbHeight)
						end
					end	
				end
			end
			
----------------------------------------
-- Rogue
----------------------------------------

local combobar = G.UnitFrames.Player.ComboPointsBar or G.UnitFrames.Target.ComboPointsBar
if( T.myclass == "ROGUE" or "DRUID") then
				if( C.classbar.combopoints ~= true ) then
					combobar:Kill()
				else	
					combobar:ClearAllPoints()
					combobar:SetPoint("CENTER", mover)
					combobar:Size((tbWidth*5)+4, tbHeight)
					combobar:SetFrameStrata("LOW")
					combobar:CreateBorder(false, true)
					for i = 1, 5  do

						if i == 1 then
							combobar[i]:Point("TOPLEFT", combobar, "BOTTOMLEFT", 0, tbHeight)
							combobar[i]:Size(tbWidth, tbHeight)
						else
							combobar[i]:Point("LEFT", combobar[i-1], "RIGHT", 1, 0)
							combobar[i]:Size(tbWidth, tbHeight)
						end
					end	
			end
		end