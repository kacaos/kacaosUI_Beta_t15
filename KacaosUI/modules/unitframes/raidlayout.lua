local T, C, L, G = unpack( Tukui )
if not C.unitframes.raid == true then return end
if not C.unitframes.enable == true then return end
if C.misc.raidstyle ~= "dps" then return end

--------------------------------------------------------------
--Header
--------------------------------------------------------------
local width, height, showParty, showRaid, showPlayer, xOffset, yOffset, point, columnSpacing, columnAnchorPoint
	width = 25
	height = 25
	showParty = true
	showRaid = true
	showPlayer = true
	xOffset = T.Scale( 7 )
	yOffset = T.Scale( -5 )
	point = "LEFT"
	columnSpacing = T.Scale( 6 )
	columnAnchorPoint = "TOP"

	T.RaidFrameAttributes = function()
		return
		"TukuiRaid",
		nil,
		"solo,raid,party",
		"oUF-initialConfigFunction", [[
			local header = self:GetParent()
			self:SetWidth( header:GetAttribute( "initial-width" ) )
			self:SetHeight( header:GetAttribute( "initial-height" ) )
		]],
		"initial-width", (25),
		"initial-height",(25),
		"showParty", true,
		"showRaid", true,
		"showPlayer", true,
		"showSolo", true,
		"xoffset",(0),
		"yOffset", (-5),
		"point", point,
		"groupFilter", "1,2,3,4,5",
		"groupingOrder", "1,2,3,4,5",
		"groupBy", "GROUP",
		"maxColumns", 5,
		"unitsPerColumn", 5,
		"columnSpacing", T.Scale( columnSpacing ),
		"columnAnchorPoint", columnAnchorPoint
	end
	
T.PostUpdateRaidUnit = function( self )
		
-- kill some frames
self.panel:Kill()
self.Power:Kill()
		
-- set Names
self.Name:SetParent(self.Health)
self.Name:ClearAllPoints()
self.Name:SetPoint("CENTER", self.Health, "CENTER", 1, 0)
self.Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
self.Name:SetShadowOffset(0,0,0,0)
self:Tag(self.Name, '[Tukui:getnamecolor][Tukui:namemini]')	

--set Health
self.Health:Height(25)
self.Health:Width(25)
self.Health:CreateBorder(false, true)

self.Health.value:Kill()

local LFDRole = self.Health:CreateTexture( nil, "OVERLAY" )
LFDRole:Height(10)
LFDRole:Width(10)
LFDRole:Point("TOPRIGHT", 0, 0)
LFDRole:SetTexture( "Interface\\AddOns\\Tukui\\medias\\textures\\lfdicons.blp" )
self.LFDRole = LFDRole

end


---------------------------------------------------------------
-- Raidposition
---------------------------------------------------------------
local RaidPosition = CreateFrame("Frame")
RaidPosition:RegisterEvent("PLAYER_LOGIN")
RaidPosition:SetScript("OnEvent", function(self, event)
	local raid = G.UnitFrames.RaidUnits
	local pets = G.UnitFrames.RaidPets
	raid:ClearAllPoints()
	raid:SetPoint("BOTTOMLEFT", ChatBackgroundLeft, "TOPLEFT", 2, 5)
end)