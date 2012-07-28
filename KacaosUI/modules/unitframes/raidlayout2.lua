local T, C, L, G = unpack( Tukui )
if not C.unitframes.raid == true then return end
if not C.unitframes.enable == true then return end
if C.misc.raidstyle ~= "heal" then return end

--------------------------------------------------------------
--Header
--------------------------------------------------------------
local width, height, showParty, showRaid, showPlayer, xOffset, yOffset, point, columnSpacing, columnAnchorPoint
	width = 60
	height = 40
	showParty = true
	showRaid = true
	showPlayer = true
	xOffset = T.Scale( 3 )
	yOffset = T.Scale( -6 )
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
		"initial-width", (60),
		"initial-height",(40),
		"showParty", true,
		"showRaid", true,
		"showPlayer", true,
		"showSolo", true,
		"xoffset",(3),
		"yOffset", (-6),
		"point", point,
		"groupFilter", "1,2,3,4,5,6,7,8",
		"groupingOrder", "1,2,3,4,5,6,7,8",
		"groupBy", "GROUP",
		"maxColumns", 5,
		"unitsPerColumn", 5,
		"columnSpacing", T.Scale(6),
		"columnAnchorPoint", columnAnchorPoint
	end
	
T.PostUpdateRaidUnit = function( self )
		
-- kill some frames
self.panel:Kill()
		
-- set Names
self.Name:SetParent(self.Health)
self.Name:ClearAllPoints()
self.Name:SetPoint("BOTTOM", self.Health, 2, 5)
self.Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
self.Name:SetShadowOffset(0,0,0,0)
--self:Tag(self.Name, '[Tukui:getnamecolor][Tukui:namemshort]')	

--set Health
self.Health:Height(40)
self.Health:Width(60)
self.Health:CreateBorder(false, true)
self.Health.value:ClearAllPoints()
self.Health.value:Point("TOP", self.Health, 0, -1)
self.Health.value:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
self.Health.value:SetShadowOffset(0,0,0,0)

--set Power
self.Power:ClearAllPoints()
self.Power:Height(1)
self.Power:Width(55)
self.Power:CreateBorder(false, true)
self.Power:Point("BOTTOM", self.Health, 0, 2)
self.Power:SetFrameLevel(5)

--------------------------------------------------------------
-- debuffs
--------------------------------------------------------------
		
		if C["unitframes"].raidunitdebuffwatch == true then
			self.RaidDebuffs:Kill()
			
			-- Raid Debuffs (big middle icon)
			local RaidDebuffs = CreateFrame('Frame', nil, self)
			RaidDebuffs:Height(24)
			RaidDebuffs:Width(24)
			RaidDebuffs:Point('CENTER', self.Health, 1,0)
			RaidDebuffs:SetFrameStrata(self.Health:GetFrameStrata())
			RaidDebuffs:SetFrameLevel(self.Health:GetFrameLevel() + 2)
			
			RaidDebuffs:SetTemplate("Default")
			
			RaidDebuffs.icon = RaidDebuffs:CreateTexture(nil, 'OVERLAY')
			RaidDebuffs.icon:SetTexCoord(.1,.9,.1,.9)
			RaidDebuffs.icon:Point("TOPLEFT", 1, -1)
			RaidDebuffs.icon:Point("BOTTOMRIGHT", -1, 1)
			
			RaidDebuffs.count = RaidDebuffs:CreateFontString(nil, 'OVERLAY')
			RaidDebuffs.count:SetFont(C["media"].uffont, 12, "THINOUTLINE")
			RaidDebuffs.count:SetPoint('BOTTOMRIGHT', RaidDebuffs, 'BOTTOMRIGHT', 0, 2)
			RaidDebuffs.count:SetTextColor(1, .9, 0)
			
			RaidDebuffs:FontString('time', C["media"].uffont, 14, "THINOUTLINE")
			RaidDebuffs.time:SetPoint('CENTER')
			RaidDebuffs.time:SetTextColor(1, .9, 0)
			
			self.RaidDebuffs = RaidDebuffs
		end
		
	--set Icons		
		local leader = self.Health:CreateTexture( nil, "OVERLAY" )
		leader:Height(15)
		leader:Width(15)
		leader:SetPoint("TOPRIGHT", 0,6)
		self.Leader = leader

		local MasterLooter = self.Health:CreateTexture( nil, "OVERLAY" )
		MasterLooter:Height(15)
		MasterLooter:Width(15)
		MasterLooter:SetPoint("TOPRIGHT", -18,8)
		self.MasterLooter = MasterLooter
		self:RegisterEvent("PARTY_LEADER_CHANGED", T.MLAnchorUpdate)
		self:RegisterEvent("PARTY_MEMBERS_CHANGED", T.MLAnchorUpdate)
		
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

--------------------------------------------------------------
-- only show 5 groups in raid (25 mans raid)
--------------------------------------------------------------
local MaxGroup = CreateFrame("Frame")
MaxGroup:RegisterEvent("PLAYER_ENTERING_WORLD")
MaxGroup:RegisterEvent("ZONE_CHANGED_NEW_AREA")
MaxGroup:SetScript("OnEvent", function(self)
	local inInstance, instanceType = IsInInstance()
	local _, _, _, _, maxPlayers, _, _ = GetInstanceInfo()
	if inInstance and instanceType == "raid" and maxPlayers ~= 40 then
		G.UnitFrames.RaidUnits:SetAttribute("groupFilter", "1,2,3,4,5")
	else
		G.UnitFrames.RaidUnits:SetAttribute("groupFilter", "1,2,3,4,5,6,7,8")
	end
end)

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