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
	-- hide ugly blizzard proc highlight
	if self.overlay then
		self.overlay:Show()
		ActionButton_ShowOverlayGlow(self)
		self.backdrop:SetBackdropBorderColor(0, 0, 0)
	end
end

hooksecurefunc("ActionButton_ShowOverlayGlow", T.ShowHighlightActionButton)