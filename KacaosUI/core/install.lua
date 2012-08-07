local T, C, L, G = unpack(Tukui)

------------------------------------------
-- set installframe
------------------------------------------
G.Install.Frame:SetFrameStrata("High")
G.Install.Frame:SetTemplate("Transparent")

-------------------------------------------
-- set popups
-------------------------------------------
TukuiPopupDialog1:SetFrameStrata("HIGH")

-------------------------------------------
-- move anchors
-------------------------------------------
TukuiRollAnchor:ClearAllPoints()
TukuiRollAnchor:Point("CENTER", UIParent, "CENTER", 0, 50)

G.ActionBars.BarExtra.Holder:ClearAllPoints()
G.ActionBars.BarExtra.Holder:Point("CENTER", UIParent, "CENTER", 0, -500)

-------------------------------------------
-- save CVars
-------------------------------------------
local function KacaosUICVars()
	SetCVar("chatBubblesParty", 0)
	SetCVar("chatBubbles", 0)
	SetCVar("cameraDistanceMax", 50)
	SetCVar("cameraDistanceMaxFactor", 5)
	SetCVar("profanityFilter", 0)
end

-------------------------------------------
-- raidframe event
-------------------------------------------
local UIOnLogon = CreateFrame( "Frame" )
UIOnLogon:RegisterEvent( "PLAYER_ENTERING_WORLD" )
UIOnLogon:SetScript( "OnEvent", function( self, event )
	self:UnregisterEvent( "PLAYER_ENTERING_WORLD" )
	if TukuiSaved == nil then
		KacaosUICVars()		
	end
	
	if (IsAddOnLoaded("KacaosUI_Raid") and IsAddOnLoaded("KacaosUI_Raid_Healing")) then
		StaticPopup_Show("KACAOSUIDISABLE_RAID")
	end

end)