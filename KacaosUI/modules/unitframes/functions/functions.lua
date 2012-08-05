local T, C, L, G = unpack(Tukui)

T.SkinAura = function (self, button)
	button.count:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	button.remaining:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	button.icon:Point("TOPLEFT", 1, -1)
	button.icon:Point("BOTTOMRIGHT", -1, 1)
	button.Glow:Kill()
end

local function PostCreateAura(self, button)
	button.Glow:Kill()
	button.icon:Point("TOPLEFT", 1, -1)
	button.icon:Point("BOTTOMRIGHT", -1, 1)
	end
hooksecurefunc(T, "PostCreateAura", PostCreateAura)

hooksecurefunc(T, "PostNamePosition", function(self)
	self.Name:ClearAllPoints()
	if (self.Power.value:GetText() and UnitIsEnemy("player", "target") and C["unitframes"].targetpowerpvponly == true) or (self.Power.value:GetText() and C["unitframes"].targetpowerpvponly == false) then
		self.Name:SetPoint("LEFT", self.Health, "LEFT", 1, -25)
	else
		self.Power.value:SetAlpha(0)
		self.Name:SetPoint("LEFT", self.Health, "LEFT", 1, -25)
	end
end)

T.PostCastStart = function(self, unit, name, rank, castid)
	if unit == "vehicle" then unit = "player" end

	if self.interrupt and UnitCanAttack("player", unit) then
		self:SetStatusBarColor(1,.2,.2,1)
	else
		self:SetStatusBarColor(1, 1, 1,1)	
	end
end