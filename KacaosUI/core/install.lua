local T, C, L, G = unpack(Tukui)

G.Install.Frame:SetFrameStrata("High")
G.Install.Frame:SetTemplate("Transparent")

TukuiPopupDialog1:SetFrameStrata("HIGH")

TukuiRollAnchor:ClearAllPoints()
TukuiRollAnchor:Point("CENTER", UIParent, "CENTER", 0, 50)

G.ActionBars.BarExtra.Holder:ClearAllPoints()
G.ActionBars.BarExtra.Holder:Point("CENTER", UIParent, "CENTER", 0, -500)

local UIOnLogon = CreateFrame( "Frame" )
UIOnLogon:RegisterEvent( "PLAYER_ENTERING_WORLD" )
UIOnLogon:SetScript( "OnEvent", function( self, event )
	self:UnregisterEvent( "PLAYER_ENTERING_WORLD" )

	if (IsAddOnLoaded("KacaosUI_Raid") and IsAddOnLoaded("KacaosUI_Raid_Healing")) then
		StaticPopup_Show("KACAOSUIDISABLE_RAID")
	end

end)

local function KacaosUICVars()
	SetCVar("chatBubblesParty", 0)
	SetCVar("chatBubbles", 0)
	SetCVar("cameraDistanceMax", 50)
	SetCVar("cameraDistanceMaxFactor", 5)
	SetCVar("profanityFilter", 0)
end