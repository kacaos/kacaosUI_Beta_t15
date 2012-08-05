local T, C, L, G = unpack( Tukui )
--------------------------------------------------------------
--Header
--------------------------------------------------------------
local width, height, showParty, showRaid, showPlayer, xOffset, yOffset, point, columnSpacing, columnAnchorPoint
if C.unitframes.minigrid == false then
	width = 25
	height = 25
	showParty = true
	showRaid = true
	showPlayer = true
	xOffset = T.Scale( 7 )
	yOffset = T.Scale( 5 )
	point = "LEFT"
	columnSpacing = T.Scale( 6 )
	columnAnchorPoint = "TOP"

		T.RaidFrameAttributes = function()
			return
			"TukuiRaid",
			nil,
			"custom [petbattle] hide;show",
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
			"xoffset",(5),
			"yOffset", (5),
			"point", point,
			"groupFilter", "1,2,3,4,5",
			"groupingOrder", "1,2,3,4,5",
			"groupBy", "GROUP",
			"maxColumns", 5,
			"unitsPerColumn", 5,
			"columnSpacing", T.Scale( columnSpacing ),
			"columnAnchorPoint", columnAnchorPoint
		end
else
	width = 60
	height = 20
	showParty = true
	showRaid = true
	showPlayer = true
	xOffset = T.Scale( 3 )
	yOffset = T.Scale( 0 )
	point = "LEFT"
	columnSpacing = T.Scale( 3 )
	columnAnchorPoint = "TOP"

		T.RaidFrameAttributes = function()
			return
			"TukuiRaid",
			nil,
			"custom [petbattle] hide;show",
			"oUF-initialConfigFunction", [[
				local header = self:GetParent()
				self:SetWidth( header:GetAttribute( "initial-width" ) )
				self:SetHeight( header:GetAttribute( "initial-height" ) )
			]],
			"initial-width", (60),
			"initial-height",(20),
			"showParty", true,
			"showRaid", true,
			"showPlayer", true,
			"showSolo", true,
			"xoffset",(3),
			"yOffset", (0),
			"point", point,
			"groupFilter", "1,2,3,4,5,6,7,8",
			"groupingOrder", "1,2,3,4,5,6,7,8",
			"groupBy", "GROUP",
			"maxColumns", 5,
			"unitsPerColumn", 5,
			"columnSpacing", T.Scale(3),
			"columnAnchorPoint", columnAnchorPoint
	end
end
	
T.PostUpdateRaidUnit = function( self )
		
-- kill some frames
self.panel:Kill()
self.Power:Kill()
self.RaidDebuffs:Kill()
self.AuraWatch:Kill()

------------------------------------------------------
-- names
------------------------------------------------------
self.Name:SetParent(self.Health)
self.Name:ClearAllPoints()
self.Name:SetPoint("CENTER", self.Health, "CENTER", 1, -1)
self.Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
self.Name:SetShadowOffset(0,0,0,0)
if C.unitframes.minigrid == false then
self:Tag(self.Name, '[Tukui:getnamecolor][Tukui:namemini]')	
end

-------------------------------------------------------
-- health
-------------------------------------------------------
if C.unitframes.minigrid == false then
	self.Health:Height(25)
	self.Health:Width(25)
	self.Health:CreateBorder(false, true)
	self.Health.value:Kill()
else
	self.Health:Height(20)
	self.Health:Width(60)
	self.Health:CreateBorder(false, true)
	self.Health.value:Kill()
end

--------------------------------------------------------
-- icons
--------------------------------------------------------

		local LFDRole = self.Health:CreateTexture( nil, "OVERLAY" )
		LFDRole:Height(15)
		LFDRole:Width(15)
		LFDRole:Point("TOPLEFT", 0, 0)
		LFDRole:SetTexture( "Interface\\AddOns\\Tukui\\medias\\textures\\lfdicons.blp" )
		self.LFDRole = LFDRole

		local Resurrect = CreateFrame( "Frame", nil, self.Health )
		Resurrect:SetFrameLevel( self.Health:GetFrameLevel() + 1 )
		Resurrect:Size(20)
		Resurrect:SetPoint( "CENTER" )

		local ResurrectIcon = Resurrect:CreateTexture( nil, "OVERLAY" )
		ResurrectIcon:SetAllPoints()
		ResurrectIcon:SetDrawLayer("OVERLAY", 7)
		self.ResurrectIcon = ResurrectIcon
		
--------------------------------------------------------------
-- debuffs
--------------------------------------------------------------
		
		if C["unitframes"].raidunitdebuffwatch == true then
			self.RaidDebuffs:Kill()
			
			-- Raid Debuffs (big middle icon)
			local RaidDebuffs = CreateFrame('Frame', nil, self)
			RaidDebuffs:Height(18)
			RaidDebuffs:Width(18)
			RaidDebuffs:Point('CENTER', self.Health, 1,0)
			RaidDebuffs:SetFrameStrata(self.Health:GetFrameStrata())
			RaidDebuffs:SetFrameLevel(self.Health:GetFrameLevel() + 2)
			
			RaidDebuffs:SetTemplate("Default")
			
			RaidDebuffs.icon = RaidDebuffs:CreateTexture(nil, 'OVERLAY')
			RaidDebuffs.icon:SetTexCoord(.1,.9,.1,.9)
			RaidDebuffs.icon:Point("TOPLEFT", 1, -1)
			RaidDebuffs.icon:Point("BOTTOMRIGHT", -1, 1)
			
			RaidDebuffs.count = RaidDebuffs:CreateFontString(nil, 'OVERLAY')
			RaidDebuffs.count:SetFont(C["media"].uffont, 10, "THINOUTLINE")
			RaidDebuffs.count:SetPoint('BOTTOMRIGHT', RaidDebuffs, 'BOTTOMRIGHT', 0, 2)
			RaidDebuffs.count:SetTextColor(1, .9, 0)
			
			RaidDebuffs:FontString('time', C["media"].uffont, 12, "THINOUTLINE")
			RaidDebuffs.time:SetPoint('CENTER')
			RaidDebuffs.time:SetTextColor(1, .9, 0)
			
			self.RaidDebuffs = RaidDebuffs
		end

------------------------------------------------------------
--MouseOver Highlight (Thx Hydra)
------------------------------------------------------------
	if C.unitframes.unicolor and C.unitframes.mouseoverhighlight then
		self:HookScript("OnEnter", function(self)
			if not UnitIsConnected(self.unit) or UnitIsDead(self.unit) or UnitIsGhost(self.unit) or (not UnitInRange(self.unit) and not UnitIsPlayer(self.unit)) then return end
			local hover = RAID_CLASS_COLORS[select(2, UnitClass(self.unit))]
			self.Health:SetStatusBarColor(hover.r, hover.g, hover.b)
			self.Health.classcolored = true
		end)

		self:HookScript("OnLeave", function(self)
			if not UnitIsConnected(self.unit) or UnitIsDead(self.unit) or UnitIsGhost(self.unit) then return end
			self.Health:SetStatusBarColor(.3, .3, .3, 1)
			self.Health.classcolored = false
		end)
	end
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
	raid:SetPoint("BOTTOMLEFT", ChatBackgroundLeft, "TOPLEFT", 2, 8)
end)