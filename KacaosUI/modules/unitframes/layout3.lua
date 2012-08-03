local T, C, L, G = unpack(Tukui)
if not C.unitframes.enable == true then return end
if C.unitframes.style ~= 3 then return end
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

	hooksecurefunc(T, "PostCreateAura", function(element, button)
	button.Glow:Kill()
	end)	
		-- kill the panel
		self.panel:Kill()
		
		-- resize the frame
		self:Height(12)
		self:Width(200)
				
		-- resize health & power
		self.Health:Height(12)
		self.Health:CreateBorder(false, true)
		self.Power:ClearAllPoints()
		self.Power:Point("BOTTOM", self.Health, 0, -4)
		self.Power:Height(1)
		self.Power:Width(200)
		self.Power:SetFrameLevel(3)
		self.Power:SetBorder(false, true)
		
		--kill custom low mana warning
		self.FlashInfo:Kill()
		
		-- new low mana warning ( cause the other one you cant move :( )
		LowMana = CreateFrame("Frame", "LowMana", self)
		LowMana:SetScript("OnUpdate", T.UpdateManaLevel)
		LowMana.parent = self
		LowMana:SetAllPoints(self.Health)
		LowMana.ManaLevel = T.SetFontString(LowMana, C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		LowMana.ManaLevel:SetPoint("CENTER", self.Health, "CENTER", 0, 0)
		self.LowMana = LowMana

		
		-- move the default position
		self:ClearAllPoints()
		self:Point("CENTER", UIParent, 0, -150)
		
		-- castbar
		local mover = CreateFrame("Frame", "TukuiPlayerCastbarMover", UIParent)
		mover:Width(200)
		mover:Height(8)
		mover:Point("BOTTOM", TukuiPlayer, "BOTTOM", 0, -16)
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
		PlayerCast:Height(8)
		PlayerCast:SetTemplate("Transparent")
		PlayerCast:Width(200)
		PlayerCast.Text:Point("LEFT", PlayerCast, "LEFT", 3, -1)
		PlayerCast.Text:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		PlayerCast.Text:SetShadowOffset(0,0)
		PlayerCast.Time:Point("RIGHT", PlayerCast, "RIGHT", -3, -1)
		PlayerCast.Time:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		PlayerCast.Time:SetShadowOffset(0,0)
		PlayerCast:CreateBorder(false, true)
		PlayerCast.CustomTimeText = T.CustomCastTimeText
	    PlayerCast.CustomDelayText = T.CustomCastDelayText
        PlayerCast.PostCastStart = T.PostCastStart
        PlayerCast.PostChannelStart = T.PostCastStart
		
		if C.unitframes.cbbutton == true then
		PlayerCast.button:ClearAllPoints()
		PlayerCast.button:Point("BOTTOMLEFT", PlayerCast, "BOTTOMRIGHT", 5, 0)
		PlayerCast.button:SetTemplate()
		PlayerCast.button:CreateBorder(false, true)
		--PlayerCast.button:CreateShadow(nil)
		PlayerCast.button:Size(28)
		PlayerCast.icon:Point("TOPLEFT", PlayerCast.button, 0, -0)
		PlayerCast.icon:Point("BOTTOMRIGHT", PlayerCast.button, -0, 0)
		else
		PlayerCast.button:Kill()
		end
		
	
		--[experience bar on player via mouseover for player currently levelling a character
		local Experience = TukuiPlayer.Experience
		local Resting = TukuiPlayer.Resting
		if T.level ~= MAX_PLAYER_LEVEL then
			Experience:Width(224)
			Experience:Height(10)
			Experience:ClearAllPoints()
			Experience:Point("TOP", UIParent, 0, -20)
			Experience:SetOrientation("Horizontal")
			Experience.Rested:SetOrientation("Horizontal")
			Experience:SetFrameLevel(12)
			Experience:SetAlpha(.55)
			Experience:HookScript("OnLeave", function(self) self:SetAlpha(.55) end)
			
			Experience.Text = Experience:CreateFontString(nil, "OVERLAY")
			Experience.Text:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			Experience.Text:SetPoint("CENTER", 0, 0)
			Experience.Text:SetShadowOffset(0,0)

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
			Reputation:Width(224)
			Reputation:Height(10)
			Reputation:ClearAllPoints()
			Reputation:Point("TOP", UIParent, 0, -20)
			Reputation:SetFrameLevel(10)
			Reputation:SetOrientation("Horizontal")
			Reputation:SetAlpha(.55)
			Reputation:HookScript("OnLeave", function(self) self:SetAlpha(.55) end)
			Reputation:SetParent(UIParent)
			
			Reputation.Text = Reputation:CreateFontString(nil, "OVERLAY")
			Reputation.Text:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			Reputation.Text:SetPoint("CENTER", 0, 0)
			Reputation.Text:SetShadowOffset(0,0)

		local repBG = CreateFrame("Frame", nil, Reputation)
			--repBG:CreatePanel("Transparent", Reputation:GetWidth(), Reputation:GetHeight(), "TOPLEFT", Reputation, "TOPLEFT", -1, 1)
			repBG:SetSize(Reputation:GetWidth(), Reputation:GetHeight())
			repBG:SetPoint("TOPLEFT", Reputation, "TOPLEFT", -1, 1)
			repBG:SetTemplate("Transparent")
			repBG:Point("BOTTOMRIGHT", Reputation, "BOTTOMRIGHT", 1, -1)
		end
	
	end
	
	if C.unitframes.hpshowp then
		local p = TukuiPlayer
		p.Health.value = T.SetFontString(p.Health, C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		p.Health.value:SetShadowOffset(0,0)
		p.Health.value:Point("LEFT", p.Health, 1, 0)

		p.Power.value = T.SetFontString(p.Health, C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		p.Power.value:SetShadowOffset(0,0)
		p.Power.value:Point("RIGHT", p.Health, -1, 0)
	else
		local p = TukuiPlayer
		p.Health.value:Hide()
		p.Power.value:Hide()
	end
	
	--set health and power value on target
	if C.unitframes.hpshow then
		local t = TukuiTarget
		t.Health.value = T.SetFontString(t.Health, C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		t.Health.value:SetShadowOffset(0,0)
		t.Health.value:Point("LEFT", t.Health, 1, 0)

		t.Power.value = T.SetFontString(t.Health, C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		t.Power.value:SetShadowOffset(0,0)
		t.Power.value:Point("RIGHT", t.Health, -1, 0)
	else
		local t = TukuiTarget
		t.Health.value:Hide()
		t.Power.value:Hide()
	end

	--change lenght of target name
	local t = TukuiTarget
	t:Tag(t.Name, "[Tukui:getnamecolor][Tukui:nameshort] [Tukui:diffcolor][level]")
	
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
		self:Height(12)
		self:Width(200)
		
		-- resize health & power
		self.Health:Height(12)
		self.Health:SetFrameLevel(5)
		self.Health:CreateBorder(false, true)
		self.Power:ClearAllPoints()
		self.Power:Point("BOTTOM", self.Health, 0, -4)
		self.Power:Height(1)
		self.Power:Width(200)
		self.Power:SetFrameLevel(3)
		self.Power:SetBorder(false, true)
		
		-- move the default position
		self:ClearAllPoints()
		self:Point("CENTER", UIParent, 250, -135)	
		
		-- change the font of name into target
		self.Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		self.Name:SetShadowOffset(0,0)
		self.Name:SetParent(self.Health)
		self.Name:ClearAllPoints()
		self.Name:SetPoint("LEFT", 0, 12)
		
		-- castbar
		local mover = CreateFrame("Frame", "TukuiTargetCastbarMover", UIParent)
		mover:Width(200)
		mover:Height(8)
		mover:Point("BOTTOM", TukuiTarget, "BOTTOM", 0, -16)
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
		TargetCast:Height(8)
		TargetCast:Width(200)
		TargetCast.Text:Point("LEFT", TargetCast, "LEFT", 3, -1)
		TargetCast.Time:Point("RIGHT", TargetCast, "RIGHT", -3, -1)
		TargetCast.Text:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		TargetCast.Text:SetShadowOffset(0,0)
		TargetCast.Time:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		TargetCast.Time:SetShadowOffset(0,0)
		TargetCast:CreateBorder(false, true)
		
		if C.unitframes.cbbutton == true then
		TargetCast.button:ClearAllPoints()
		TargetCast.button:Point("BOTTOMLEFT", TargetCast, "BOTTOMRIGHT", 5, 0)
		TargetCast.button:SetTemplate()
		TargetCast.button:CreateBorder(false, true)
		--TargetCast.button:CreateShadow(nil)
		TargetCast.button:Size(28)	
		TargetCast.icon:Point("TOPLEFT", TargetCast.button, 0, -0)
		TargetCast.icon:Point("BOTTOMRIGHT", TargetCast.button, -0, 0)
		else
		TargetCast.button:Kill()
		end
	
		hooksecurefunc(T, "PostCreateAura", function(element, button)
		button.Glow:Kill()
		end)
	
		-- target debuffs
		if C.unitframes.showdb then
		TukuiTarget.Debuffs:ClearAllPoints()
		TukuiTarget.Debuffs:Point("BOTTOMRIGHT", self.Health, "BOTTOMRIGHT", 2, 52)
		TukuiTarget.Debuffs.size = 21
		TukuiTarget.Debuffs:Width(200)
		TukuiTarget.Debuffs.num = 14
		TukuiTarget.Debuffs["growth-y"] = "UP"
		TukuiTarget.Debuffs["growth-x"] = "LEFT"
		TukuiTarget.Debuffs.spacing = 2
		TukuiTarget.Debuffs.PostCreateIcon = T.PostCreateAura
		TukuiTarget.Debuffs.PostUpdateIcon = T.PostUpdateAura
		else
		TukuiTarget.Debuffs:Hide()
		end
		TukuiTarget.Buffs:ClearAllPoints()
		TukuiTarget.Buffs:SetPoint("BOTTOMLEFT", self.Health, "TOPLEFT", -1, 17)
		TukuiTarget.Buffs:SetHeight(21)
		TukuiTarget.Buffs:SetWidth(200)
		TukuiTarget.Buffs.size = 21
		TukuiTarget.Buffs.num = 9
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
		self:Height(12)
		self:Width(80)
	
		-- resize health & power
		self.Health:Height(12)
		self.Health:SetTemplate("Default")
		self.Power:Kill()
		
		-- move the defaault position
		self:ClearAllPoints()
		self:Point("RIGHT", TukuiPlayer, 0, 15)
		
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
		self:Height(12)
		self:Width(80)
		
		-- resize health & power
		self.Health:Height(12)
		self.Health:SetTemplate("Default")
				
		-- move the default position
		self:ClearAllPoints()
		self:Point("RIGHT", TukuiTarget, 0, 15)
		
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
	
	if unit == "focus" then
		-- resize the frame
		self:Height(12)
		self:Width(200)
		
		-- move the default position
		self:ClearAllPoints()
		self:Point("CENTER", UIParent, -400, -150)
		
		-- resize healt & power
		self.Health:Height(12)
		self.Health:SetFrameLevel(5)
		self.Health:CreateBorder(false, true)
		self.Power:ClearAllPoints()
		self.Power:Point("BOTTOM", self.Health, 0, -4)
		self.Power:Height(1)
		self.Power:Width(200)
		self.Power:SetFrameLevel(3)
		self.Power:SetBorder(false, true)
		self.Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		self.Name:SetShadowOffset(0,0)
		self.Name:ClearAllPoints()
		self.Name:Point("CENTER", self.Health, 0, -1)
		self.Health.value:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		self.Health.value:SetShadowOffset(0,0)
		self.Power.value:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		self.Power.value:SetShadowOffset(0,0)
		
		-- set castbar size
		TukuiFocus.Castbar:ClearAllPoints()
		TukuiFocus.Castbar:Point("LEFT", TukuiFocus.Health, 0, -18)
		TukuiFocus.Castbar:Height(6)
		TukuiFocus.Castbar:Width(200)
		TukuiFocus.Castbar:SetTemplate("Transparent")
		TukuiFocus.Castbar:CreateBorder(false, true)
		TukuiFocus.Castbar.Time:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		TukuiFocus.Castbar.Time:SetShadowOffset(0,0)
		TukuiFocus.Castbar.Text:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		TukuiFocus.Castbar.Text:SetShadowOffset(0,0)
		
		if C.unitframes.cbbutton == true then
		TukuiFocus.Castbar.button:ClearAllPoints()
		TukuiFocus.Castbar.button:Size(29)
		TukuiFocus.Castbar.button:CreateBorder(false, true)
		TukuiFocus.Castbar.button:SetTemplate()
		TukuiFocus.Castbar.button:Point("LEFT", TukuiFocus, "RIGHT", 5, -8)
		TukuiFocus.Castbar.icon:Point("TOPLEFT", TukuiFocus.Castbar.button, 0, -0)
		TukuiFocus.Castbar.icon:Point("BOTTOMRIGHT", TukuiFocus.Castbar.button, -0, 0)
		else
		TukuiFocus.Castbar.button:Kill()
		end
		
		-- set debuffs
		TukuiFocus.Debuffs:Kill()

	end
	
	
	
	hooksecurefunc(T, "PostCreateAura", function(element, button)
	button.Glow:Kill()
	end)	
	
	-- FOCUS TARGET --
	if C.unitframes.showfocustarget == true then
	--resize the frame
	TukuiFocusTarget:Height(12)
	TukuiFocusTarget:Width(200)
	
	-- move the default position
	TukuiFocusTarget:ClearAllPoints()
	TukuiFocusTarget:Point("CENTER", TukuiFocus.Health, 0, 40)
	
	-- resize health & power
	TukuiFocusTarget.Health:Height(12)
	TukuiFocusTarget.Health:SetFrameLevel(5)
	TukuiFocusTarget.Health:CreateBorder(false, true)
	TukuiFocusTarget.Power:ClearAllPoints()
	TukuiFocusTarget.Power:Point("BOTTOM", TukuiFocusTarget.Health, 0, -4)
	TukuiFocusTarget.Power:Height(1)
	TukuiFocusTarget.Power:Width(200)
	TukuiFocusTarget.Power:SetFrameLevel(3)
	TukuiFocusTarget.Power:SetBorder(false, true)
	TukuiFocusTarget.Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiFocusTarget.Name:SetShadowOffset(0,0)
	TukuiFocusTarget.Name:ClearAllPoints()
	TukuiFocusTarget.Name:Point("CENTER", TukuiFocusTarget.Health, 0, 0)
	TukuiFocusTarget.Health.value:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiFocusTarget.Health.value:SetShadowOffset(0,0)
	TukuiFocusTarget.Power.value:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiFocusTarget.Power.value:SetShadowOffset(0,0)
	
	-- set castbar size
	TukuiFocusTarget.Castbar:ClearAllPoints()
	TukuiFocusTarget.Castbar:SetFrameLevel(10)
	TukuiFocusTarget.Castbar:Point("BOTTOM", TukuiFocusTarget.Health, 0, -15)
	TukuiFocusTarget.Castbar:Width(200)
	TukuiFocusTarget.Castbar:Height(6)
	TukuiFocusTarget.Castbar:SetTemplate("Transparent")
	TukuiFocusTarget.Castbar:CreateBorder(false, true)
	TukuiFocusTarget.Castbar.Time:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiFocusTarget.Castbar.Time:SetShadowOffset(0,0)
	TukuiFocusTarget.Castbar.Text:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	TukuiFocusTarget.Castbar.Text:SetShadowOffset(0,0)
	
	if C.unitframes.cbbutton == true then
	TukuiFocusTarget.Castbar.button:ClearAllPoints()
	TukuiFocusTarget.Castbar.button:Size(29)
	TukuiFocusTarget.Castbar.button:CreateBorder(false, true)
	TukuiFocusTarget.Castbar.button:SetTemplate()
	TukuiFocusTarget.Castbar.button:Point("LEFT", TukuiFocusTarget, "RIGHT", 5, -8)
	TukuiFocusTarget.Castbar.icon:Point("TOPLEFT", TukuiFocusTarget.Castbar.button, 0, -0)
	TukuiFocusTarget.Castbar.icon:Point("BOTTOMRIGHT", TukuiFocusTarget.Castbar.button, -0, 0)
	else
	TukuiFocusTarget.Castbar.button:Kill()
	end
	
	-- set debuffs
	TukuiFocusTarget.Debuffs:Kill()
	end
	
-------------------------------------------------------------------
	-- BOSS LAYOUT --
-------------------------------------------------------------------
	if C.unitframes.showboss == true then
	
	--change boss1 name tag
	local b1 = TukuiBoss1
	b1:Tag(b1.Name, "[Tukui:getnamecolor][Tukui:namemedium]")
	--change boss2 name tag
	local b2 = TukuiBoss2
	b2:Tag(b2.Name, "[Tukui:getnamecolor][Tukui:namemedium]")
	--change boss3 name tag
	local b3 = TukuiBoss3
	b3:Tag(b3.Name, "[Tukui:getnamecolor][Tukui:namemedium]")
	--change boss4 name tag
	local b4 = TukuiBoss4
	b4:Tag(b4.Name, "[Tukui:getnamecolor][Tukui:namemedium]")
	
	-- resize the frame
	TukuiBoss1:ClearAllPoints()
	TukuiBoss2:ClearAllPoints()
	TukuiBoss3:ClearAllPoints()
	TukuiBoss4:ClearAllPoints()
	TukuiBoss1:Width(200)
	TukuiBoss2:Width(200)
	TukuiBoss3:Width(200)
	TukuiBoss4:Width(200)
	
	-- move the default position
	TukuiBoss1:Height(12)
	TukuiBoss2:Height(12)
	TukuiBoss3:Height(12)
	TukuiBoss4:Height(12)
	TukuiBoss1:Point("CENTER", UIParent, 600, -150)
	TukuiBoss2:Point("CENTER", TukuiBoss1, 0, 50)
	TukuiBoss3:Point("CENTER", TukuiBoss2, 0, 50)
	TukuiBoss4:Point("CENTER", TukuiBoss3, 0, 50)
	
	-- resize health & power
	TukuiBoss1.Health:Height(12)
	TukuiBoss1.Health:SetFrameLevel(5)
	TukuiBoss1.Health:CreateBorder(false, true)
	TukuiBoss1.Power:ClearAllPoints()
	TukuiBoss1.Power:Point("BOTTOM", TukuiBoss1.Health, 0, -4)
	TukuiBoss1.Power:Height(1)
	TukuiBoss1.Power:Width(200)
	TukuiBoss1.Power:SetFrameLevel(3)
	TukuiBoss1.Power:SetBorder(false, true)
	
	TukuiBoss2.Health:Height(12)
	TukuiBoss2.Health:SetFrameLevel(5)
	TukuiBoss2.Health:CreateBorder(false, true)
	TukuiBoss2.Power:ClearAllPoints()
	TukuiBoss2.Power:Point("BOTTOM", TukuiBoss2.Health, 0, -4)
	TukuiBoss2.Power:Height(1)
	TukuiBoss2.Power:Width(200)
	TukuiBoss2.Power:SetFrameLevel(3)
	TukuiBoss2.Power:SetBorder(false, true)
	
	TukuiBoss3.Health:Height(12)
	TukuiBoss3.Health:SetFrameLevel(5)
	TukuiBoss3.Health:CreateBorder(false, true)
	TukuiBoss3.Power:ClearAllPoints()
	TukuiBoss3.Power:Point("BOTTOM", TukuiBoss3.Health, 0, -4)
	TukuiBoss3.Power:Height(1)
	TukuiBoss3.Power:Width(200)
	TukuiBoss3.Power:SetFrameLevel(3)
	TukuiBoss3.Power:SetBorder(false, true)
	
	TukuiBoss4.Health:Height(12)
	TukuiBoss4.Health:SetFrameLevel(5)
	TukuiBoss4.Health:CreateBorder(false, true)
	TukuiBoss4.Power:ClearAllPoints()
	TukuiBoss4.Power:Point("BOTTOM", TukuiBoss4.Health, 0, -4)
	TukuiBoss4.Power:Height(1)
	TukuiBoss4.Power:Width(200)
	TukuiBoss4.Power:SetFrameLevel(3)
	TukuiBoss4.Power:SetBorder(false, true)
	
	-- resize Boss AltpowerBar
	TukuiBoss1.AltPowerBar:Height(6)
	TukuiBoss1.AltPowerBar:SetFrameLevel(5)
	TukuiBoss1.AltPowerBar:SetPoint("LEFT")
	TukuiBoss1.AltPowerBar:SetPoint("RIGHT")
	TukuiBoss1.AltPowerBar:SetPoint("BOTTOM", TukuiBoss1.Health, "TOP", 0, 3)
	TukuiBoss1.AltPowerBar:CreateBorder(false, true)
	
	TukuiBoss2.AltPowerBar:Height(6)
	TukuiBoss2.AltPowerBar:SetFrameLevel(5)
	TukuiBoss2.AltPowerBar:SetPoint("LEFT")
	TukuiBoss2.AltPowerBar:SetPoint("RIGHT")
	TukuiBoss2.AltPowerBar:SetPoint("BOTTOM", TukuiBoss2.Health, "TOP", 0, 3)
	TukuiBoss2.AltPowerBar:CreateBorder(false, true)
	
	TukuiBoss3.AltPowerBar:Height(6)
	TukuiBoss3.AltPowerBar:SetFrameLevel(5)
	TukuiBoss3.AltPowerBar:SetPoint("LEFT")
	TukuiBoss3.AltPowerBar:SetPoint("RIGHT")
	TukuiBoss3.AltPowerBar:SetPoint("BOTTOM", TukuiBoss3.Health, "TOP", 0, 3)
	TukuiBoss3.AltPowerBar:CreateBorder(false, true)
	
	TukuiBoss4.AltPowerBar:Height(6)
	TukuiBoss4.AltPowerBar:SetFrameLevel(5)
	TukuiBoss4.AltPowerBar:SetPoint("LEFT")
	TukuiBoss4.AltPowerBar:SetPoint("RIGHT")
	TukuiBoss4.AltPowerBar:SetPoint("BOTTOM", TukuiBoss4.Health, "TOP", 0, 3)
	TukuiBoss4.AltPowerBar:CreateBorder(false, true)

	
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
	TukuiBoss1.Name:Point("LEFT", TukuiBoss1.Health, 3, 0)
	TukuiBoss2.Name:Point("LEFT", TukuiBoss2.Health, 3, 0)
	TukuiBoss3.Name:Point("LEFT", TukuiBoss3.Health, 3, 0)
	TukuiBoss4.Name:Point("LEFT", TukuiBoss4.Health, 3, 0)
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
	TukuiBoss1.Power.value:Kill()
	TukuiBoss2.Power.value:Kill()
	TukuiBoss3.Power.value:Kill()
	TukuiBoss4.Power.value:Kill()
	TukuiBoss1.Health.value:ClearAllPoints()
	TukuiBoss1.Health.value:Point("RIGHT", TukuiBoss1.Health)
	TukuiBoss2.Health.value:ClearAllPoints()
	TukuiBoss2.Health.value:Point("RIGHT", TukuiBoss2.Health)
	TukuiBoss3.Health.value:ClearAllPoints()
	TukuiBoss3.Health.value:Point("RIGHT", TukuiBoss3.Health)
	TukuiBoss4.Health.value:ClearAllPoints()
	TukuiBoss4.Health.value:Point("RIGHT", TukuiBoss4.Health)
	
	-- set castbar size / time / text / button
	TukuiBoss1.Castbar:ClearAllPoints()
	TukuiBoss2.Castbar:ClearAllPoints()
	TukuiBoss3.Castbar:ClearAllPoints()
	TukuiBoss4.Castbar:ClearAllPoints()
	TukuiBoss1.Castbar:SetFrameLevel(10)
	TukuiBoss2.Castbar:SetFrameLevel(10)
	TukuiBoss3.Castbar:SetFrameLevel(10)
	TukuiBoss4.Castbar:SetFrameLevel(10)
	TukuiBoss1.Castbar:Point("BOTTOM", TukuiBoss1.Health, 0, -15)
	TukuiBoss2.Castbar:Point("BOTTOM", TukuiBoss2.Health, 0, -15)
	TukuiBoss3.Castbar:Point("BOTTOM", TukuiBoss3.Health, 0, -15)
	TukuiBoss4.Castbar:Point("BOTTOM", TukuiBoss4.Health, 0, -15)
	TukuiBoss1.Castbar:Height(6)
	TukuiBoss2.Castbar:Height(6)
	TukuiBoss3.Castbar:Height(6)
	TukuiBoss4.Castbar:Height(6)
	TukuiBoss1.Castbar:Width(200)
	TukuiBoss2.Castbar:Width(200)
	TukuiBoss3.Castbar:Width(200)
	TukuiBoss4.Castbar:Width(200)
	
	if C.unitframes.cbbutton == true then
	TukuiBoss1.Castbar.button:ClearAllPoints()
	TukuiBoss1.Castbar.button:Point("LEFT", TukuiBoss1, "RIGHT", 5, -8)
	TukuiBoss2.Castbar.button:ClearAllPoints()
	TukuiBoss2.Castbar.button:Point("LEFT", TukuiBoss2, "RIGHT", 5, -8)
	TukuiBoss3.Castbar.button:ClearAllPoints()
	TukuiBoss3.Castbar.button:Point("LEFT", TukuiBoss3, "RIGHT", 5, -8)
	TukuiBoss4.Castbar.button:ClearAllPoints()
	TukuiBoss4.Castbar.button:Point("LEFT", TukuiBoss4, "RIGHT", 5, -8)
	TukuiBoss1.Castbar.button:Size(29)
	TukuiBoss2.Castbar.button:Size(29)
	TukuiBoss3.Castbar.button:Size(29)
	TukuiBoss4.Castbar.button:Size(29)
	TukuiBoss1.Castbar.button:CreateBorder(false, true)
	TukuiBoss2.Castbar.button:CreateBorder(false, true)
	TukuiBoss3.Castbar.button:CreateBorder(false, true)
	TukuiBoss4.Castbar.button:CreateBorder(false, true)
	TukuiBoss1.Castbar.icon:Point("TOPLEFT", TukuiBoss1.Castbar.button, 0, -0)
	TukuiBoss1.Castbar.icon:Point("BOTTOMRIGHT", TukuiBoss1.Castbar.button, -0, 0)
	TukuiBoss2.Castbar.icon:Point("TOPLEFT", TukuiBoss2.Castbar.button, 0, -0)
	TukuiBoss2.Castbar.icon:Point("BOTTOMRIGHT", TukuiBoss2.Castbar.button, -0, 0)
	TukuiBoss3.Castbar.icon:Point("TOPLEFT", TukuiBoss3.Castbar.button, 0, -0)
	TukuiBoss3.Castbar.icon:Point("BOTTOMRIGHT", TukuiBoss3.Castbar.button, -0, 0)
	TukuiBoss4.Castbar.icon:Point("TOPLEFT", TukuiBoss4.Castbar.button, 0, -0)
	TukuiBoss4.Castbar.icon:Point("BOTTOMRIGHT", TukuiBoss4.Castbar.button, -0, 0)
	TukuiBoss1.Castbar.button:SetTemplate()
	TukuiBoss2.Castbar.button:SetTemplate()
	TukuiBoss3.Castbar.button:SetTemplate()
	TukuiBoss4.Castbar.button:SetTemplate()
	else
	TukuiBoss1.Castbar.button:Kill()
	TukuiBoss2.Castbar.button:Kill()
	TukuiBoss3.Castbar.button:Kill()
	TukuiBoss4.Castbar.button:Kill()
	end
	
	TukuiBoss1.Castbar:SetTemplate("Default")
	TukuiBoss2.Castbar:SetTemplate("Default")
	TukuiBoss3.Castbar:SetTemplate("Default")
	TukuiBoss4.Castbar:SetTemplate("Default")
	
	-- set buffs
	TukuiBoss1.Buffs:Kill()
	TukuiBoss2.Buffs:Kill()
	TukuiBoss3.Buffs:Kill()
	TukuiBoss3.Buffs:Kill()
	
	-- set debuffs
	TukuiBoss1.Debuffs:Kill()
	TukuiBoss2.Debuffs:Kill()
	TukuiBoss3.Debuffs:Kill()
	TukuiBoss4.Debuffs:Kill()
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