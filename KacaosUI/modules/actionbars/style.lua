local T, C, L = unpack(Tukui)

local function style(self)
	local name = self:GetName()

	--> fixing a taint issue while changing totem flyout button in combat.
	if name:match("MultiCast") then return end

	--> don't skin the boss encounter extra button to match texture (4.3 patch)
	--> http://www.tukui.org/storage/viewer.php?id=913811extrabar.jpg
	if name:match("ExtraActionButton") then return end

	local Count = _G[name.."Count"]
	local HotKey = _G[name.."HotKey"]
	local Border = _G[name.."Panel"]
	local Icon = _G[name.."Icon"]

	Count:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	Count:SetShadowOffset(0,0)
	HotKey:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
	HotKey:SetShadowOffset(0,0)

    Icon:Point("TOPLEFT", 1, -1)
	Icon:Point("BOTTOMRIGHT", -1, 1)
	
	--Border:SetBackdropColor(0,0,0,0.5)
end
hooksecurefunc("ActionButton_Update", style)

local function StyleActionBarPetAndShiftButton(normal, button, icon, name, pet)
	local Icon = _G[name.."Icon"]
	local Border = _G[name.."Panel"]
	
    Icon:Point("TOPLEFT", 1, -1)
	Icon:Point("BOTTOMRIGHT", -1, 1)
	
	--Border:SetBackdropColor(0,0,0,0.5)
	
end

hooksecurefunc(T, "StyleActionBarPetAndShiftButton", StyleActionBarPetAndShiftButton)

local function StyleActionBarButton(self)
	local name = self:GetName()
	local Icon = _G[name.."Icon"]
	local Border = _G[name.."Panel"]

	if name:match("MultiCast") or name:match("ExtraActionButton") then return end

    Icon:Point("TOPLEFT", 1, -1)
	Icon:Point("BOTTOMRIGHT", -1, 1)
	
	--Border:SetBackdropColor(0,0,0,0.5)
	
end

hooksecurefunc(T, "StyleActionBarButton", StyleActionBarButton)

T.ShowHighlightActionButton = function(self)
	if self.overlay then
		local color = RAID_CLASS_COLORS[T.myclass]
		self.overlay:Hide()
		ActionButton_HideOverlayGlow(self)
		self.shine = SpellBook_GetAutoCastShine();
        self.shine:Show();
        self.shine:SetParent(self);
        self.shine:SetPoint("CENTER", self, "CENTER");
        AutoCastShine_AutoCastStart(self.shine, color.r, color.g, color.b);

	for _, sparkle in next, self.shine.sparkles do
		sparkle:SetHeight(sparkle:GetHeight() * 2)
		sparkle:SetWidth(sparkle:GetWidth() * 2)
    end
	end
end

T.HideHighlightActionButton = function(self)
	if self.shine then
		AutoCastShine_AutoCastStop(self.shine);
	end
end

hooksecurefunc("ActionButton_ShowOverlayGlow", T.ShowHighlightActionButton)
hooksecurefunc("ActionButton_HideOverlayGlow", T.HideHighlightActionButton)