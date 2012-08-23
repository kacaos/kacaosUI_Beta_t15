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
-- move durability frame
-------------------------------------------
local dummydura = CreateFrame("Frame", "Testdummydura", UIParent)
dummydura:RegisterEvent("PLAYER_ENTERING_WORLD")

dummydura:SetScript("OnEvent", function(self, event)
if(event == "PLAYER_ENTERING_WORLD") then
			DurabilityFrame:ClearAllPoints()
			DurabilityFrame:Point("BOTTOM", TukuiMinimap, "TOP", 0, 20)
	end
end)

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