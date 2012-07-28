local T, C, L, G = unpack(Tukui)

--------------------------------------------------------------------------------------------
-- Grid theme indicator section
--------------------------------------------------------------------------------------------

-- position of indicators
T.countOffsets = {
	TOPLEFT = {6*C["unitframes"].gridscale, 1},
	TOPRIGHT = {-6*C["unitframes"].gridscale, 1},
	BOTTOMLEFT = {6*C["unitframes"].gridscale, 1},
	BOTTOMRIGHT = {-6*C["unitframes"].gridscale, 1},
	LEFT = {6*C["unitframes"].gridscale, 1},
	RIGHT = {-6*C["unitframes"].gridscale, 1},
	TOP = {0, 0},
	BOTTOM = {0, 0},
}

-- skin the icon
T.CreateAuraWatchIcon = function(self, icon)
	icon:SetTemplate("Default")
	icon.icon:Point("TOPLEFT", 1, -1)
	icon.icon:Point("BOTTOMRIGHT", -1, 1)
	icon.icon:SetTexCoord(.08, .92, .08, .92)
	icon.icon:SetDrawLayer("ARTWORK")
	if (icon.cd) then
		icon.cd:SetReverse()
	end
	icon.overlay:SetTexture()
end

-- create the icon
T.createAuraWatch = function(self, unit)
	local auras = CreateFrame("Frame", nil, self)
	auras:SetPoint("TOPLEFT", self.Health, 2, -2)
	auras:SetPoint("BOTTOMRIGHT", self.Health, -2, 2)
	auras.presentAlpha = 1
	auras.missingAlpha = 0
	auras.icons = {}
	auras.PostCreateIcon = T.CreateAuraWatchIcon

	if (not C["unitframes"].auratimer) then
		auras.hideCooldown = true
	end

	local buffs = {}

	if (T.buffids["ALL"]) then
		for key, value in pairs(T.buffids["ALL"]) do
			tinsert(buffs, value)
		end
	end

	if (T.buffids[T.myclass]) then
		for key, value in pairs(T.buffids[T.myclass]) do
			tinsert(buffs, value)
		end
	end

	-- "Cornerbuffs"
	if (buffs) then
		for key, spell in pairs(buffs) do
			local icon = CreateFrame("Frame", nil, auras)
			icon.spellID = spell[1]
			icon.anyUnit = spell[4]
			icon:Width(14)
			icon:Height(14)
			icon:SetPoint(spell[2], 0, 0)

			--[[local tex = icon:CreateTexture(nil, "OVERLAY")
			tex:SetAllPoints(icon)
			tex:SetTexture(C.media.blank)
			if (spell[3]) then
				tex:SetVertexColor(unpack(spell[3]))
			else
				tex:SetVertexColor(0.8, 0.8, 0.8)
			end]]

			local count = icon:CreateFontString(nil, "OVERLAY")
			count:SetFont(C["media"].uffont, 12, "THINOUTLINE")
			count:SetPoint("CENTER", unpack(T.countOffsets[spell[2]]))
			icon.count = count

			auras.icons[spell[1]] = icon
		end
	end
	
	self.AuraWatch = auras
end