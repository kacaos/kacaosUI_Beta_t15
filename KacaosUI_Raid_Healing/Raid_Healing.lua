local T, C, L, G = unpack( Tukui )
--------------------------------------------------------------
--Header
--------------------------------------------------------------
local width, height, showParty, showRaid, showPlayer, xOffset, yOffset, point, columnSpacing, columnAnchorPoint
	width = 60
	height = 45
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
		"initial-height",(45),
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
		"maxColumns", 8,
		"unitsPerColumn", 5,
		"columnSpacing", T.Scale(3),
		"columnAnchorPoint", columnAnchorPoint
	end
	
T.PostUpdateRaidUnit = function( self )
		
-- kill some frames
self.panel:Kill()
self:SetFrameLevel(1)
self.panel:Kill()
local panel = CreateFrame("Frame", nil, self)
panel:SetTemplate()
panel:Point("TOPRIGHT", self, "TOPRIGHT", 1, 1)
panel:Point("BOTTOMLEFT", self, "BOTTOMLEFT", -1, -1)
panel:SetFrameLevel(2)
panel:SetFrameStrata("MEDIUM")
self.panel = panel

self:HighlightUnit(1,1,1,1)
		
------------------------------------------------------
-- names
------------------------------------------------------
self.Name:SetParent(self.Health)
self.Name:ClearAllPoints()
self.Name:SetPoint("CENTER", self.Health, 1, 0)
self.Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
self.Name:SetShadowOffset(0,0,0,0)
	
-------------------------------------------------------
-- health
-------------------------------------------------------
self.Health:Height(45)
self.Health:Width(80)
self.Health:CreateBorder(false, true)
self.Health:SetFrameLevel(1)
self.Health.value:ClearAllPoints()
self.Health.value:Point("TOP", self.Health, 0, -1)
self.Health.value:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
self.Health.value:SetShadowOffset(0,0,0,0)

self.Health.bg:SetTexture( 0.6, 0.6, 0.6 )
		
	if( C["unitframes"].unicolor == true ) then
		self.Health.bg:SetVertexColor(unpack(C["unitframes"].healthBgColor))
	end

-------------------------------------------------------
-- power
-------------------------------------------------------
self.Power:ClearAllPoints()
self.Power:Height(1)
self.Power:Width(55)
self.Power:CreateBorder(false, true)
self.Power:Point("BOTTOM", self.Health, 0, 2)
self.Power:SetFrameLevel(8)

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
		
--------------------------------------------------------
-- icons
--------------------------------------------------------
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
		
		if C["unitframes"].aggro == true then
			table.insert(self.__elements, T.UpdateThreat)
			self:RegisterEvent('PLAYER_TARGET_CHANGED', T.UpdateThreat)
			self:RegisterEvent('UNIT_THREAT_LIST_UPDATE', T.UpdateThreat)
			self:RegisterEvent('UNIT_THREAT_SITUATION_UPDATE', T.UpdateThreat)
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
	raid:SetPoint("CENTER", UIParent, "CENTER", -500, -135)
end)






