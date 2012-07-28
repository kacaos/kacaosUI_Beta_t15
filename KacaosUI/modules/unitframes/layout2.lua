local T, C, L = unpack(Tukui)
if not C.unitframes.enable == true then return end
if C.unitframes.style ~= 2 then return end
---------------------------------------------------------------
-- UnitFrames
---------------------------------------------------------------

local units = {
	"Player",
	"Target",
	"TargetTarget",
	"Pet",
	"Focus",
}

	hooksecurefunc(T, "PostCreateAura", function(element, button)
	button.Glow:Kill()
	end)

for _, frame in pairs(units) do
	local t = "Tukui"
	local self = _G[t..frame]
	local unit = string.lower(frame)
	
	-- if we see a shadow around on a unit frame, kill it!
	if self.shadow then
		self.shadow:Kill()
	end
	
	-- player stuff
	if unit == "player" then		
		-- kill the panel
		self.panel:Kill()
		
		-- resize the frame
		self:Height(20)
		self:Width(175)
		self:SetBackdrop(nil)
		self:SetBackdropColor(0, 0, 0)
				
		-- resize health & power
		self.Health:Height(20)
		self.Health:SetFrameLevel(5)
		self.Health:AddBorder()
		self.Power:ClearAllPoints()
		self.Power:Point("BOTTOM", self.Health, 0,-5)
		self.Power:Width(175)
		self.Power:Height(2)
		self.Power:SetFrameLevel(3)
		self.Power:AddBorder()
		
		-- move the combat icon
		self.Combat:ClearAllPoints()
		self.Combat:Point("CENTER", self.Health, 0, 0)
		
		--kill custom low mana warning
		self.FlashInfo:Kill()
		
		-- new low mana warning ( cause the other one you cant move :( )
		LowMana = CreateFrame("Frame", "LowMana", self)
		LowMana:SetScript("OnUpdate", T.UpdateManaLevel)
		LowMana.parent = self
		LowMana:SetAllPoints(self.Health)
		LowMana:SetFrameStrata("HIGH")
		LowMana.ManaLevel = T.SetFontString(LowMana, C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		LowMana.ManaLevel:SetPoint("CENTER", self.Health, "CENTER", 0, 0)
		self.LowMana = LowMana
		
		
		-- move the default position
		self:ClearAllPoints()
		self:Point("BOTTOM", UIParent, -200, 120)
		
		-- castbar
		local mover = CreateFrame("Frame", "TukuiPlayerCastbarMover", UIParent)
		mover:Width(241)
		mover:Height(20)
		mover:Point("BOTTOM", TukuiBar1, "BOTTOM", -1, 60)
		mover:SetTemplate()
		mover:SetBackdropBorderColor(1,0,0)
		mover:SetClampedToScreen(true)
		mover:SetMovable(true)
		mover:SetFrameStrata("HIGH")
		mover:Hide()
		mover:FontString("Text", C.media.font, 12)
		mover.Text:SetPoint("CENTER", TukuiPlayerCastbarMover, "CENTER", 0, 0)
		mover.Text:SetText(L.mover_castbarplayer)
		tinsert(T.AllowFrameMoving, mover)
		local PlayerCast = TukuiPlayer.Castbar
		PlayerCast:ClearAllPoints()
		PlayerCast:SetPoint("CENTER", mover)
		PlayerCast:Height(20)
		PlayerCast:SetTemplate()
		PlayerCast:Width(241)
		PlayerCast.Text:Point("LEFT", PlayerCast, "LEFT", 3, -1)
		PlayerCast.Text:SetFont(C.media.pixelfont, 10, "MONOCHROMEOUTLINE")
		PlayerCast.Text:SetShadowOffset(0,0)
		PlayerCast.Time:Point("RIGHT", PlayerCast, "RIGHT", -3, -1)
		PlayerCast.Time:SetFont(C.media.pixelfont, 10, "MONOCHROMEOUTLINE")
		PlayerCast.Time:SetShadowOffset(0,0)
		PlayerCast.button:Kill()
		PlayerCast:CreateBorder(false, true)
		
		-- experience bar on player via mouseover for player currently levelling a character
		local Experience = TukuiPlayer.Experience
		local Resting = TukuiPlayer.Resting
		if T.level ~= MAX_PLAYER_LEVEL then
			Experience:Width(175)
			Experience:Height(2)
			Experience:ClearAllPoints()
			Experience:Point("BOTTOM", TukuiPlayer.Power, "BOTTOM", 0, -5)
			Experience:SetOrientation("Horizontal")
			Experience.Rested:SetOrientation("Horizontal")
			Experience:SetFrameLevel(12)
			Experience:SetAlpha(1)
			Experience:HookScript("OnLeave", function(self) self:SetAlpha(1) end)

		local xpBG = CreateFrame("Frame", nil, Experience)
			--xpBG:CreatePanel("Transparent", Experience:GetWidth(), Experience:GetHeight(), "TOPLEFT", Experience, "TOPLEFT", -1, 1)
			xpBG:SetSize(Experience:GetWidth(), Experience:GetHeight())
			xpBG:SetPoint("TOPLEFT", Experience, "TOPLEFT", -1, 1)
			xpBG:SetTemplate("Transparent")
			xpBG:Point("BOTTOMRIGHT", Experience, "BOTTOMRIGHT", 1, -1)	

		Resting:SetTexture(nil)
		end

		-- reputation bar for max level character
		local Reputation = TukuiPlayer.Reputation
		local Resting = TukuiPlayer.Resting
		if T.level == MAX_PLAYER_LEVEL then
			Reputation:SetOrientation("Horizontal")
			Reputation:Width(175)
			Reputation:Height(2)
			Reputation:ClearAllPoints()
			Reputation:Point("BOTTOM", TukuiPlayer.Power, "BOTTOM", 0, -5)
			Reputation:SetFrameLevel(10)
			Reputation:SetOrientation("Horizontal")
			Reputation:SetAlpha(1)
			Reputation:HookScript("OnLeave", function(self) self:SetAlpha(1) end)
			Reputation:SetParent(UIParent)

		local repBG = CreateFrame("Frame", nil, Reputation)
			--repBG:CreatePanel("Transparent", Reputation:GetWidth(), Reputation:GetHeight(), "TOPLEFT", Reputation, "TOPLEFT", -1, 1)
			repBG:SetSize(Reputation:GetWidth(), Reputation:GetHeight())
			repBG:SetPoint("TOPLEFT", Reputation, "TOPLEFT", -1, 1)
			repBG:SetTemplate("Transparent")
			repBG:Point("BOTTOMRIGHT", Reputation, "BOTTOMRIGHT", 1, -1)
		end
	
	end
	
	-- set health and power value on player
		local p = TukuiPlayer
		p.Health.value = T.SetFontString(p.Health, C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		p.Health.value:SetShadowOffset(0,0)
		p.Health.value:SetPoint("RIGHT", p.Health, -1, 0)

		p.Power.value = T.SetFontString(p.Health, C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		p.Power.value:SetShadowOffset(0,0)
		p.Power.value:SetPoint("LEFT", p.Health, 2, 0)
		
		p.Health.value.ClearAllPoints = T.dummy
		p.Health.value.SetPoint = T.dummy
		p.Power.value.ClearAllPoints = T.dummy
		p.Power.value.SetPoint = T.dummy			

	
	--set health and power value on target
		local t = TukuiTarget
		t.Health.value = T.SetFontString(t.Health, C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		t.Health.value:SetShadowOffset(0,0)
		t.Health.value:Point("LEFT", t.Health, 2, 0)

		t.Power.value = T.SetFontString(t.Health, C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		t.Power.value:SetShadowOffset(0,0)
		t.Power.value:Point("RIGHT", t.Health, -1, 0)
		
		t.Health.value.ClearAllPoints = T.dummy
		t.Health.value.SetPoint = T.dummy
		t.Power.value.ClearAllPoints = T.dummy
		t.Power.value.SetPoint = T.dummy


		--change target name tag
		local t = TukuiTarget
		t:Tag(t.Name, "[Tukui:getnamecolor][Tukui:namemedium] [Tukui:diffcolor][level] [shortclassification]")
	
	if unit == "target" then
		
	-- our update (hook) or the original buff/debuffs button creation)
	local function PostCreateAura(self, button)
	-- kill the glow
	button.Glow:Kill()

	-- move icon just 1px inside the black inset (it hide 1px borders)
	button.icon:Point("TOPLEFT", 1, -1)
	button.icon:Point("BOTTOMRIGHT", -1, 1)
	
	end
	hooksecurefunc(T, "PostCreateAura", PostCreateAura)
		
		-- kill the panel
		self.panel:Kill()
		
		-- resize the frame
		self:Height(20)
		self:Width(175)
		self:SetBackdrop(nil)
		self:SetBackdropColor(0, 0, 0)
		
		-- resize health & power
		self.Health:Height(20)
		self.Health:SetFrameLevel(5)
		self.Health:AddBorder()
		self.Power:ClearAllPoints()
		self.Power:Point("BOTTOM", self.Health, 0, -5)
		self.Power:Height(2)
		self.Power:Width(175)
		self.Power:SetFrameLevel(3)
		self.Power:AddBorder()
		
		-- move the default position
		self:ClearAllPoints()
		self:Point("BOTTOM", UIParent, 200, 120)	
		
		-- change the font of name into target
		self.Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		self.Name:SetShadowOffset(0,0)
		self.Name:SetParent(self.Health)
		self.Name:ClearAllPoints()
		self.Name:SetPoint("LEFT", 0, -25)
		
		-- castbar
		local mover = CreateFrame("Frame", "TukuiTargetCastbarMover", UIParent)
		mover:Width(280)
		mover:Height(20)
		mover:Point("CENTER", UIParent, "CENTER", 0, 140)
		mover:SetTemplate()
		mover:SetBackdropBorderColor(1,0,0)
		mover:SetClampedToScreen(true)
		mover:SetMovable(true)
		mover:SetFrameStrata("HIGH")
		mover:Hide()
		mover:FontString("Text", C.media.font, 12)
		mover.Text:SetPoint("CENTER", TukuiTargetCastbarMover, "CENTER", 0, 0)
		mover.Text:SetText(L.mover_castbartarget)
		tinsert(T.AllowFrameMoving, mover)
		local TargetCast = TukuiTarget.Castbar
		TargetCast:ClearAllPoints()
		TargetCast:SetPoint("CENTER", mover)
		TargetCast:Height(20)
		TargetCast:Width(280)
		TargetCast.Text:Point("LEFT", TargetCast, "LEFT", 3, -1)
		TargetCast.Time:Point("RIGHT", TargetCast, "RIGHT", -3, -1)
		TargetCast.Text:SetFont(C.media.pixelfont, 10, "MONOCHROMEOUTLINE")
		TargetCast.Text:SetShadowOffset(0,0)
		TargetCast.Time:SetFont(C.media.pixelfont, 10, "MONOCHROMEOUTLINE")
		TargetCast.Time:SetShadowOffset(0,0)
		TargetCast:CreateBorder(false, true)
		TargetCast.button:Kill()	
	
		-- target debuffs
		TukuiTarget.Debuffs:ClearAllPoints()
		TukuiTarget.Debuffs:Point("CENTER", self.Power, "CENTER", 1, 62)
		TukuiTarget.Debuffs.size = 21
		TukuiTarget.Debuffs:Width(168)
		TukuiTarget.Debuffs.num = 14
		TukuiTarget.Debuffs["growth-y"] = "UP"
		TukuiTarget.Debuffs["growth-x"] = "LEFT"
		TukuiTarget.Debuffs.spacing = 1
		TukuiTarget.Debuffs.PostCreateIcon = T.PostCreateAura
		TukuiTarget.Debuffs.PostUpdateIcon = T.PostUpdateAura
		TukuiTarget.Buffs:ClearAllPoints()
		TukuiTarget.Buffs:SetPoint("BOTTOMLEFT", self.Health, "TOPLEFT", -1, 3)
		TukuiTarget.Buffs:SetHeight(21)
		TukuiTarget.Buffs:SetWidth(168)
		TukuiTarget.Buffs.size = 21
		TukuiTarget.Buffs.num = 8
		TukuiTarget.Buffs.spacing = 1
		TukuiTarget.Buffs.initialAnchor = 'TOPLEFT'
		TukuiTarget.Buffs.PostCreateIcon = T.PostCreateAura
		TukuiTarget.Buffs.PostUpdateIcon = T.PostUpdateAura
		
		local t = TukuiTarget
		t.Buffs.ClearAllPoints = T.dummy
		t.Buffs.SetPoint = T.dummy
		t.Buffs.Point = T.dummy
		t.Debuffs.ClearAllPoints = T.dummy
		t.Debuffs.SetPoint = T.dummy
		t.Debuffs.Point = T.dummy
		
		-- an option to show only our debuffs on target
			if unit == "target" then
				TukuiTarget.Debuffs.onlyShowPlayer = C.unitframes.onlyselfdebuffs
			end
		
		
		-- I want to have this name stay where it is for ever
		-- (because in tukui we have a script where it move the name according to some events)
		self.Name.ClearAllPoints = T.dummy
		self.Name.SetPoint = T.dummy	
	end
	
	--remove pets lvl
	local pet = TukuiPet
	pet:Tag(pet.Name, "[Tukui:getnamecolor][Tukui:nameshort]")
	
	if unit == "pet" then
		if C.unitframes.petshow then
		
		-- kill the panel
		if not T.lowversion then
		self.panel:Kill()
		end
		
		-- resize the frame
		self:Height(11)
		self:Width(60)
		self:SetBackdrop(nil)
		self:SetBackdropColor(0, 0, 0)
	
		-- resize health & power
		self.Health:Height(12)
		self.Health:AddBorder()
		self.Health:SetTemplate("Default")
		self.Power:Kill()
		
		-- move the defaault position
		self:ClearAllPoints()
		self:Point("BOTTOM", UIParent, -258, 98)
		
		-- change the font of name
		self.Name:SetFont(C.media.pixelfont, 7.5, "MONOCHROMEOUTLINE")
		self.Name:SetShadowOffset(0,0)
		self.Name:SetParent(self.Health)
		self.Name:ClearAllPoints()
		self.Name:SetPoint("CENTER", 0, 0)

		self.Castbar:Kill()
		
		else
		self:Disable()
		end
		
	end
	
	-- resize tot name
	local tot = TukuiTargetTarget
	tot:Tag(tot.Name, "[Tukui:getnamecolor][Tukui:nameshort]")
	
	if unit == "targettarget" then
		if C.unitframes.totshow then
		
		-- kill the panel
		if not T.lowversion then
		self.panel:Kill()
		end
		
		-- resize the frame
		self:Height(11)
		self:Width(60)
		self:SetBackdrop(nil)
		self:SetBackdropColor(0, 0, 0)
		
		-- resize health & power
		self.Health:Height(12)
		self.Health:AddBorder()
		self.Health:SetTemplate("Default")

		-- move the default position
		self:ClearAllPoints()
		self:Point("BOTTOM", UIParent, 257, 98)
		
		-- change the font of name
		self.Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		self.Name:SetShadowOffset(0,0)
		self.Name:SetParent(self.Health)
		self.Name:ClearAllPoints()
		self.Name:SetPoint("CENTER", 0, 0)
		else
		self:Disable()
		end
		
	end
	
		--change focus name tag
		local f = TukuiFocus
		f:Tag(f.Name, "[Tukui:getnamecolor][Tukui:namemedium] [Tukui:diffcolor][level] [shortclassification]")
	
	if unit == "focus" then
		-- resize the frame
		self:Height(20)
		self:Width(175)
		self:SetBackdrop(nil)
		self:SetBackdropColor(0, 0, 0,0)
		
		-- move the default position
		self:ClearAllPoints()
		self:Point("CENTER", UIParent, -400, -150)
		
		-- resize healt & power
		self.Health:Height(20)
		self.Health:SetFrameLevel(5)
		self.Health:AddBorder()
		self.Power:ClearAllPoints()
		self.Power:Point("BOTTOM", self.Health, 0, -5)
		self.Power:Height(2)
		self.Power:Width(175)
		self.Power:SetFrameLevel(3)
		self.Power:AddBorder()
		self.Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		self.Name:SetShadowOffset(0,0)
		self.Name:ClearAllPoints()
		self.Name:Point("LEFT", self.Health, 0, -25)
		self.Health.value:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		self.Health.value:SetShadowOffset(0,0)
		self.Power.value:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		self.Power.value:SetShadowOffset(0,0)
		
		-- set castbar size
		TukuiFocus.Castbar:ClearAllPoints()
		TukuiFocus.Castbar:SetFrameLevel(10)
		TukuiFocus.Castbar:Point("BOTTOM", TukuiFocus.Health, 0, -20)
		TukuiFocus.Castbar:Height(9)
		TukuiFocus.Castbar:Width(173)
		TukuiFocus.Castbar.Time:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		TukuiFocus.Castbar.Time:SetShadowOffset(0,0)
		TukuiFocus.Castbar.Text:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		TukuiFocus.Castbar.Text:SetShadowOffset(0,0)
		--TukuiFocus.Castbar.Text:Kill()
		TukuiFocus.Castbar.button:ClearAllPoints()
		TukuiFocus.Castbar.button:Point("CENTER", TukuiFocus.Castbar, "CENTER", 0, 0)
		TukuiFocus.Castbar.button:Kill()
		
		-- set debuffs
		TukuiFocus.Debuffs:ClearAllPoints()
		TukuiFocus.Debuffs:Point("LEFT", TukuiFocus.Health, -203, -3)
		TukuiFocus.Debuffs.size= 27
		TukuiFocus.Debuffs.num= 3
		TukuiFocus.Debuffs.PostCreateIcon = T.PostCreateAura
		TukuiFocus.Debuffs.PostUpdateIcon = T.PostUpdateAura

	end
	
	
	
	hooksecurefunc(T, "PostCreateAura", function(element, button)
	button.Glow:Kill()
	end)	
	
	if C.unitframes.showfocustarget == true then
		--change focustarget name tag
		local ft = TukuiFocusTarget
		ft:Tag(ft.Name, "[Tukui:getnamecolor][Tukui:namemedium] [Tukui:diffcolor][level] [shortclassification]")
	
	-- FOCUS TARGET --
	--resize the frame
	TukuiFocusTarget:Height(20)
	TukuiFocusTarget:Width(175)
	TukuiFocusTarget:SetBackdrop(nil)
	TukuiFocusTarget:SetBackdropColor(0, 0, 0,0)
	
	-- move the default position
	TukuiFocusTarget:ClearAllPoints()
	TukuiFocusTarget:Point("CENTER", TukuiFocus.Health, 0, 70)
	
	-- resize health & power
	TukuiFocusTarget.Health:Height(20)
	TukuiFocusTarget.Health:SetFrameLevel(5)
	TukuiFocusTarget.Health:AddBorder()
	TukuiFocusTarget.Power:ClearAllPoints()
	TukuiFocusTarget.Power:Point("BOTTOM", TukuiFocusTarget.Health, 0, -5)
	TukuiFocusTarget.Power:Height(2)
	TukuiFocusTarget.Power:Width(175)
	TukuiFocusTarget.Power:SetFrameLevel(3)
	TukuiFocusTarget.Power:AddBorder()
	TukuiFocusTarget.Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiFocusTarget.Name:SetShadowOffset(0,0)
	TukuiFocusTarget.Name:ClearAllPoints()
	TukuiFocusTarget.Name:Point("LEFT", TukuiFocusTarget.Health, 0, -25)
	TukuiFocusTarget.Health.value:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiFocusTarget.Health.value:SetShadowOffset(0,0)
	TukuiFocusTarget.Power.value:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiFocusTarget.Power.value:SetShadowOffset(0,0)
	
	-- set castbar size
	TukuiFocusTarget.Castbar:ClearAllPoints()
	TukuiFocusTarget.Castbar:SetFrameLevel(10)
	TukuiFocusTarget.Castbar:Point("BOTTOM", TukuiFocusTarget.Health, 0, -20)
	TukuiFocusTarget.Castbar:Width(173)
	TukuiFocusTarget.Castbar:Height(9)
	TukuiFocusTarget.Castbar.Time:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiFocusTarget.Castbar.Time:SetShadowOffset(0,0)
	TukuiFocusTarget.Castbar.Text:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiFocusTarget.Castbar.Text:SetShadowOffset(0,0)
--	TukuiFocusTarget.Castbar.Text:Kill()
	TukuiFocusTarget.Castbar.button:ClearAllPoints()
	TukuiFocusTarget.Castbar.button:Point("CENTER", TukuiFocusTarget.Castbar, "CENTER", 0, 0)
	TukuiFocusTarget.Castbar.button:Kill()
	
	-- set debuffs
	TukuiFocusTarget.Debuffs:ClearAllPoints()
	TukuiFocusTarget.Debuffs:Point("LEFT", TukuiFocusTarget.Health, -203, -3)
	TukuiFocusTarget.Debuffs.size = 27
	TukuiFocusTarget.Debuffs.num = 3
	TukuiFocusTarget.Debuffs.PostCreateIcon = T.PostCreateAura
	TukuiFocusTarget.Debuffs.PostUpdateIcon = T.PostUpdateAura
end
-------------------------------------------------------------------
	-- BOSS LAYOUT --
-------------------------------------------------------------------
	if C.unitframes.showboss == true then
	--change boss1 name tag
	local b1 = TukuiBoss1
	b1:Tag(b1.Name, "[Tukui:getnamecolor][Tukui:namemedium] [Tukui:diffcolor][level] [shortclassification]")
	--change boss2 name tag
	local b2 = TukuiBoss2
	b2:Tag(b2.Name, "[Tukui:getnamecolor][Tukui:namemedium] [Tukui:diffcolor][level] [shortclassification]")
	--change boss3 name tag
	local b3 = TukuiBoss3
	b3:Tag(b3.Name, "[Tukui:getnamecolor][Tukui:namemedium] [Tukui:diffcolor][level] [shortclassification]")
	--change boss4 name tag
	local b4 = TukuiBoss4
	b4:Tag(b4.Name, "[Tukui:getnamecolor][Tukui:namemedium] [Tukui:diffcolor][level] [shortclassification]")
	
	
	-- resize the frame
	TukuiBoss1:ClearAllPoints()
	TukuiBoss2:ClearAllPoints()
	TukuiBoss3:ClearAllPoints()
	TukuiBoss4:ClearAllPoints()
	TukuiBoss1:Width(175)
	TukuiBoss2:Width(175)
	TukuiBoss3:Width(175)
	TukuiBoss4:Width(175)
	TukuiBoss1:SetBackdrop(nil)
	TukuiBoss1:SetBackdropColor(0, 0, 0,0)
	TukuiBoss2:SetBackdrop(nil)
	TukuiBoss2:SetBackdropColor(0, 0, 0,0)
	TukuiBoss3:SetBackdrop(nil)
	TukuiBoss3:SetBackdropColor(0, 0, 0,0)
	TukuiBoss4:SetBackdrop(nil)
	TukuiBoss4:SetBackdropColor(0, 0, 0,0)
	
	-- move the default position
	TukuiBoss1:Height(20)
	TukuiBoss2:Height(20)
	TukuiBoss3:Height(20)
	TukuiBoss4:Height(20)
	TukuiBoss1:Point("CENTER", UIParent, 600, -150)
	TukuiBoss2:Point("CENTER", TukuiBoss1, 0, 70)
	TukuiBoss3:Point("CENTER", TukuiBoss2, 0, 70)
	TukuiBoss4:Point("CENTER", TukuiBoss3, 0, 70)
	
	-- resize health & power
	TukuiBoss1.Health:Height(20)
	TukuiBoss1.Health:SetFrameLevel(5)
	TukuiBoss1.Health:AddBorder()
	TukuiBoss1.Power:ClearAllPoints()
	TukuiBoss1.Power:Point("BOTTOM", TukuiBoss1.Health, 0, -5)
	TukuiBoss1.Power:Height(2)
	TukuiBoss1.Power:Width(175)
	TukuiBoss1.Power:SetFrameLevel(3)
	TukuiBoss1.Power:AddBorder()
	
	TukuiBoss2.Health:Height(20)
	TukuiBoss2.Health:SetFrameLevel(5)
	TukuiBoss2.Health:AddBorder()
	TukuiBoss2.Power:ClearAllPoints()
	TukuiBoss2.Power:Point("BOTTOM", TukuiBoss2.Health, 0, -5)
	TukuiBoss2.Power:Height(2)
	TukuiBoss2.Power:Width(175)
	TukuiBoss2.Power:SetFrameLevel(3)
	TukuiBoss2.Power:AddBorder()
	
	TukuiBoss3.Health:Height(20)
	TukuiBoss3.Health:SetFrameLevel(5)
	TukuiBoss3.Health:AddBorder()
	TukuiBoss3.Power:ClearAllPoints()
	TukuiBoss3.Power:Point("BOTTOM", TukuiBoss3.Health, 0, -5)
	TukuiBoss3.Power:Height(2)
	TukuiBoss3.Power:Width(175)
	TukuiBoss3.Power:SetFrameLevel(3)
	TukuiBoss3.Power:AddBorder()
	
	TukuiBoss4.Health:Height(20)
	TukuiBoss4.Health:SetFrameLevel(5)
	TukuiBoss4.Health:AddBorder()
	TukuiBoss4.Power:ClearAllPoints()
	TukuiBoss4.Power:Point("BOTTOM", TukuiBoss4.Health, 0, -5)
	TukuiBoss4.Power:Height(2)
	TukuiBoss4.Power:Width(175)
	TukuiBoss4.Power:SetFrameLevel(3)
	TukuiBoss4.Power:AddBorder()
	
	-- change font of name / halth value / power value / castbar text and time
	TukuiBoss1.Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiBoss1.Name:SetShadowOffset(0,0)
	TukuiBoss2.Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiBoss2.Name:SetShadowOffset(0,0)
	TukuiBoss3.Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiBoss3.Name:SetShadowOffset(0,0)
	TukuiBoss4.Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiBoss4.Name:SetShadowOffset(0,0)
	TukuiBoss1.Name:ClearAllPoints()
	TukuiBoss2.Name:ClearAllPoints()
	TukuiBoss3.Name:ClearAllPoints()
	TukuiBoss4.Name:ClearAllPoints()
	TukuiBoss1.Name:Point("LEFT", TukuiBoss1.Health, 0, -25)
	TukuiBoss2.Name:Point("LEFT", TukuiBoss2.Health, 0, -25)
	TukuiBoss3.Name:Point("LEFT", TukuiBoss3.Health, 0, -25)
	TukuiBoss4.Name:Point("LEFT", TukuiBoss4.Health, 0, -25)
	TukuiBoss1.Health.value:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiBoss1.Health.value:SetShadowOffset(0,0)
	TukuiBoss1.Power.value:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiBoss1.Power.value:SetShadowOffset(0,0)
	TukuiBoss2.Health.value:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiBoss2.Health.value:SetShadowOffset(0,0)
	TukuiBoss2.Power.value:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiBoss2.Power.value:SetShadowOffset(0,0)
	TukuiBoss3.Health.value:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiBoss3.Health.value:SetShadowOffset(0,0)
	TukuiBoss3.Power.value:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiBoss3.Power.value:SetShadowOffset(0,0)
	TukuiBoss4.Health.value:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiBoss4.Health.value:SetShadowOffset(0,0)
	TukuiBoss4.Power.value:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiBoss4.Power.value:SetShadowOffset(0,0)
	TukuiBoss1.Castbar.Text:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiBoss1.Castbar.Text:SetShadowOffset(0,0)
	TukuiBoss1.Castbar.Time:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiBoss1.Castbar.Time:SetShadowOffset(0,0)
	TukuiBoss2.Castbar.Text:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiBoss2.Castbar.Text:SetShadowOffset(0,0)
	TukuiBoss2.Castbar.Time:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiBoss2.Castbar.Time:SetShadowOffset(0,0)
	TukuiBoss3.Castbar.Text:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiBoss3.Castbar.Text:SetShadowOffset(0,0)
	TukuiBoss3.Castbar.Time:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiBoss3.Castbar.Time:SetShadowOffset(0,0)
	TukuiBoss4.Castbar.Text:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiBoss4.Castbar.Text:SetShadowOffset(0,0)
	TukuiBoss4.Castbar.Time:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiBoss4.Castbar.Time:SetShadowOffset(0,0)
	
	-- set castbar size / time / text / button
	TukuiBoss1.Castbar:ClearAllPoints()
	TukuiBoss2.Castbar:ClearAllPoints()
	TukuiBoss3.Castbar:ClearAllPoints()
	TukuiBoss4.Castbar:ClearAllPoints()
	TukuiBoss1.Castbar:SetFrameLevel(10)
	TukuiBoss2.Castbar:SetFrameLevel(10)
	TukuiBoss3.Castbar:SetFrameLevel(10)
	TukuiBoss4.Castbar:SetFrameLevel(10)
	TukuiBoss1.Castbar:Point("BOTTOM", TukuiBoss1.Health, 0, -20)
	TukuiBoss2.Castbar:Point("BOTTOM", TukuiBoss2.Health, 0, -20)
	TukuiBoss3.Castbar:Point("BOTTOM", TukuiBoss3.Health, 0, -20)
	TukuiBoss4.Castbar:Point("BOTTOM", TukuiBoss4.Health, 0, -20)
	TukuiBoss1.Castbar:Height(9)
	TukuiBoss2.Castbar:Height(9)
	TukuiBoss3.Castbar:Height(9)
	TukuiBoss4.Castbar:Height(9)
	TukuiBoss1.Castbar:Width(173)
	TukuiBoss2.Castbar:Width(173)
	TukuiBoss3.Castbar:Width(173)
	TukuiBoss4.Castbar:Width(173)
	--TukuiBoss1.Castbar.Text:Kill()
	--TukuiBoss2.Castbar.Text:Kill()
	--TukuiBoss3.Castbar.Text:Kill()
	--TukuiBoss4.Castbar.Text:Kill()
	TukuiBoss1.Castbar.button:ClearAllPoints()
	TukuiBoss1.Castbar.button:Point("CENTER", TukuiBoss1.Castbar, "CENTER", 0, 0)
	TukuiBoss2.Castbar.button:ClearAllPoints()
	TukuiBoss2.Castbar.button:Point("CENTER", TukuiBoss2.Castbar, "CENTER", 0, 0)
	TukuiBoss3.Castbar.button:ClearAllPoints()
	TukuiBoss3.Castbar.button:Point("CENTER", TukuiBoss3.Castbar, "CENTER", 0, 0)
	TukuiBoss4.Castbar.button:ClearAllPoints()
	TukuiBoss4.Castbar.button:Point("CENTER", TukuiBoss4.Castbar, "CENTER", 0, 0)
	TukuiBoss1.Castbar.button:Kill()
	TukuiBoss2.Castbar.button:Kill()
	TukuiBoss3.Castbar.button:Kill()
	TukuiBoss4.Castbar.button:Kill()
	
	-- set buffs
	TukuiBoss1.Buffs:ClearAllPoints()
	TukuiBoss1.Buffs:Point("LEFT", TukuiBoss1.Health, -255, -3)
	TukuiBoss1.Buffs.size= 27
	TukuiBoss1.Buffs.num= 3
	TukuiBoss2.Buffs:ClearAllPoints()
	TukuiBoss2.Buffs:Point("LEFT", TukuiBoss2.Health, -255, -3)
	TukuiBoss2.Buffs.size= 27
	TukuiBoss2.Buffs.num= 3
	TukuiBoss3.Buffs:ClearAllPoints()
	TukuiBoss3.Buffs:Point("LEFT", TukuiBoss3.Health, -255, -3)
	TukuiBoss3.Buffs.size= 27
	TukuiBoss3.Buffs.num= 3
	TukuiBoss4.Buffs:ClearAllPoints()
	TukuiBoss4.Buffs:Point("LEFT", TukuiBoss4.Health, -255, -3)
	TukuiBoss4.Buffs.size= 27
	TukuiBoss4.Buffs.num= 3
	TukuiBoss1.Buffs.PostCreateIcon = T.PostCreateAura
	TukuiBoss1.Buffs.PostUpdateIcon = T.PostUpdateAura
	TukuiBoss2.Buffs.PostCreateIcon = T.PostCreateAura
	TukuiBoss2.Buffs.PostUpdateIcon = T.PostUpdateAura
	TukuiBoss3.Buffs.PostCreateIcon = T.PostCreateAura
	TukuiBoss3.Buffs.PostUpdateIcon = T.PostUpdateAura
	TukuiBoss4.Buffs.PostCreateIcon = T.PostCreateAura
	TukuiBoss4.Buffs.PostUpdateIcon = T.PostUpdateAura
	
	-- set debuffs
	TukuiBoss1.Debuffs:ClearAllPoints()
	TukuiBoss1.Debuffs:Point("RIGHT", TukuiBoss1.Health, 203, -3)
	TukuiBoss1.Debuffs.size= 27
	TukuiBoss1.Debuffs.num= 3
	TukuiBoss2.Debuffs:ClearAllPoints()
	TukuiBoss2.Debuffs:Point("RIGHT", TukuiBoss2.Health, 203, -3)
	TukuiBoss2.Debuffs.size= 27
	TukuiBoss2.Debuffs.num= 3
	TukuiBoss3.Debuffs:ClearAllPoints()
	TukuiBoss3.Debuffs:Point("RIGHT", TukuiBoss3.Health, 203, -3)
	TukuiBoss3.Debuffs.size= 27
	TukuiBoss3.Debuffs.num= 3
	TukuiBoss4.Debuffs:ClearAllPoints()
	TukuiBoss4.Debuffs:Point("RIGHT", TukuiBoss4.Health, 203, -3)
	TukuiBoss4.Debuffs.size= 27
	TukuiBoss4.Debuffs.num= 3
	TukuiBoss1.Debuffs.PostCreateIcon = T.PostCreateAura
	TukuiBoss1.Debuffs.PostUpdateIcon = T.PostUpdateAura
	TukuiBoss2.Debuffs.PostCreateIcon = T.PostCreateAura
	TukuiBoss2.Debuffs.PostUpdateIcon = T.PostUpdateAura
	TukuiBoss3.Debuffs.PostCreateIcon = T.PostCreateAura
	TukuiBoss3.Debuffs.PostUpdateIcon = T.PostUpdateAura
	TukuiBoss4.Debuffs.PostCreateIcon = T.PostCreateAura
	TukuiBoss4.Debuffs.PostUpdateIcon = T.PostUpdateAura
	
	if(self:GetParent():GetName():match"TukuiMainTank" or self:GetParent():GetName():match"TukuiMainAssist") then
	self.Health:ClearAllPoints()
	self.Health:Widht(60)
	self.Health:Height(25)
	end
end
end

if C["unitframes"].charportrait == true then
			TukuiPlayer_Portrait:ClearAllPoints()
			TukuiPlayer_Portrait:SetAllPoints(TukuiPlayer.Health)
			TukuiPlayer_Portrait:SetAlpha(0.25)
			TukuiPlayer_Portrait:SetFrameLevel(TukuiPlayer.Health:GetFrameLevel())
			TukuiTarget_Portrait:ClearAllPoints()
			TukuiTarget_Portrait:SetAllPoints(TukuiTarget.Health)
			TukuiTarget_Portrait:SetAlpha(0.25)
			TukuiTarget_Portrait:SetFrameLevel(TukuiTarget.Health:GetFrameLevel())
			TukuiTarget_Portrait.SetAlpha = T.dummy
			TukuiPlayer.Health:SetPoint("TOPLEFT", 0,0)
			TukuiPlayer.Health:SetPoint("TOPRIGHT")
			TukuiTarget.Health:SetPoint("TOPRIGHT", 0,0)
			TukuiTarget.Health:SetPoint("TOPLEFT")
end

if C.actionbar.bar4 then
TukuiPlayer.Castbar:ClearAllPoints()
TukuiPlayer.Castbar:Point("BOTTOM", TukuiBar4, "TOP", 0, 3)
TukuiPlayer.Castbar:Width(TukuiBar4:GetWidth()-8)
TukuiPlayer.Castbar:Height(15)
TukuiPlayer.Castbar.Text:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
TukuiPlayer.Castbar.Time:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
end

if C.actionbar.b2bottom then
TukuiPlayer.Castbar:ClearAllPoints()
TukuiPlayer.Castbar:Point("BOTTOM", TukuiBar4, "TOP", 0, 35)
TukuiPlayer.Castbar:Width(TukuiBar4:GetWidth()-8)
TukuiPlayer.Castbar:Height(15)
TukuiPlayer.Castbar.Text:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
TukuiPlayer.Castbar.Time:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
TukuiPlayer:ClearAllPoints()
TukuiPlayer:Point("BOTTOM", UIParent, -250, 150)
TukuiTarget:ClearAllPoints()
TukuiTarget:Point("BOTTOM", UIParent, 250, 150)
end


--[[add spark to castbar
local oUF = oUFTukui or oUF

if not oUF then
	return
end

local AddCastBarSpark = function(self)
	local Spark = self:CreateTexture(nil, "OVERLAY")
	Spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	Spark:SetVertexColor(1, 1, 1)
	Spark:SetBlendMode("ADD")
	Spark:Width(14)
	Spark:Height(self:GetHeight() * 1.6)
	Spark:Point("LEFT", self:GetStatusBarTexture(), "RIGHT", -6, 0)

	self.Spark = Spark
end

for unit, object in pairs(oUF.units) do
	if object.Castbar then
		AddCastBarSpark(object.Castbar)
	end
end]]