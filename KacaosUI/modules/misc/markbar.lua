local T, C, L, G = unpack(Tukui)

----------------------------------------------------------------------------------------
--	Mark Bar(by Smelly)
----------------------------------------------------------------------------------------
local button_size = 15

local markbarbutton = CreateFrame("Button", "markbarbutton", UIParent)
markbarbutton:Height(16)
markbarbutton:Width(16)
markbarbutton:SetTemplate("Transparent")
markbarbutton:Point("BOTTOMLEFT", ChatBackgroundLeft, "BOTTOMRIGHT", -20, 2)
markbarbutton:EnableMouse(true)
markbarbutton:SetAlpha(0)
markbarbutton:SetScript("OnEnter", function()
	markbarbutton:FadeIn()
end)

markbarbutton:SetScript("OnLeave", function()
	markbarbutton:FadeOut()
end)

local markbarbutton_tex = markbarbutton:CreateTexture(nil, "OVERLAY")
markbarbutton_tex:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
markbarbutton_tex:SetPoint("TOPLEFT", markbarbutton, "TOPLEFT", -1, -1)
markbarbutton_tex:SetPoint("BOTTOMRIGHT", markbarbutton, "BOTTOMRIGHT", 1, 1)

local MarkBarBG = CreateFrame("Frame", "MarkBarAnchor", PetBattleHider)
MarkBarBG:SetTemplate("Transparent")
--MarkBarBG:CreateBorder(false, true)
MarkBarBG:SetBackdropBorderColor(0,0,0,0)
MarkBarBG:SetBackdropColor(0,0,0,0)
MarkBarBG:Size((button_size * 5) + 15, (button_size * 2) + 6)
MarkBarBG:Point("BOTTOMLEFT", markbarbutton, "BOTTOMRIGHT", 18, 22)
MarkBarBG:SetFrameLevel(0)
MarkBarBG:Hide()

local icon = {}
local mark = {}
for i = 0, 8 do
	mark[i] = CreateFrame("Button", "mark"..i, MarkBarBG)
	mark[i]:SetTemplate("Transparent")
	mark[i]:SetBackdropColor(0,0,0,0)
	mark[i]:SetBackdropBorderColor(0,0,0,0)
	mark[i]:Size(button_size-1, button_size-1)
	if i == 1 then
		mark[i]:SetPoint("TOPLEFT", MarkBarBG, "TOPLEFT", 3, -9)
	elseif i == 2 then
		mark[i]:SetPoint("BOTTOM", mark1, "TOP", 0, 3)
	elseif i == 3 then
		mark[i]:SetPoint("TOPLEFT", mark2, "TOPRIGHT", 3, 0)
	elseif i == 4 then
		mark[i]:SetPoint("TOP", mark3, "BOTTOM", 0, -3)
	elseif i == 5 then
		mark[i]:SetPoint("TOP", mark4, "BOTTOM", 0, -3)
	elseif i == 6 then
		mark[i]:SetPoint("TOP", mark1, "BOTTOM", 0, -3)
	elseif i == 7 then
		mark[i]:SetPoint("TOPLEFT", mark3, "TOPRIGHT", 3, 0)
	elseif i == 8 then
		mark[i]:SetPoint("TOP", mark7, "BOTTOM", 0, -3)
	end
	mark[0]:SetPoint("TOP", mark8, "BOTTOM", 0, -2)
	mark[0]:Size(button_size, button_size)
	mark[0]:SetScript("OnMouseUp", function()
		if MarkBarBG:IsVisible() then
			MarkBarBG:Hide()
		else
			MarkBarBG:Show()
		end
	end)
	mark[i]:EnableMouse(true)
	mark[i]:HookScript("OnEnter", function(self)
		self:SetBackdropBorderColor(1,1,1,1)
		self:SetBackdropColor(0,0,0,0)
	end)
	mark[i]:HookScript("OnLeave", function(self)
		self:SetBackdropBorderColor(0,0,0,0)
		self:SetBackdropColor(0,0,0,0)
	end)
	mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", i) end)

	icon[i] = CreateFrame("Button", "icon"..i, MarkBarBG)
	if i == 0 then
		icon[i]:SetNormalTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
	else
		icon[i]:SetNormalTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	end
	icon[i]:Size(button_size - 5, button_size - 5)
	icon[i]:Point("CENTER", mark[i])
	icon[i]:CreateBorder(false, true)
	icon[i]:SetBackdropColor(0,0,0)
	icon[i]:SetTemplate("Default")

	-- Set up each button
	if i == 1 then
		icon[i]:GetNormalTexture():SetTexCoord(0, 0.25, 0, 0.25)
	elseif i == 2 then
		icon[i]:GetNormalTexture():SetTexCoord(0.25, 0.5, 0, 0.25)
	elseif i == 3 then
		icon[i]:GetNormalTexture():SetTexCoord(0.5, 0.75, 0, 0.25)
	elseif i == 4 then
		icon[i]:GetNormalTexture():SetTexCoord(0.75, 1, 0, 0.25)
	elseif i == 5 then
		icon[i]:GetNormalTexture():SetTexCoord(0, 0.25, 0.25, 0.5)
	elseif i == 6 then
		icon[i]:GetNormalTexture():SetTexCoord(0.25, 0.5, 0.25, 0.5)
	elseif i == 7 then
		icon[i]:GetNormalTexture():SetTexCoord(0.5, 0.75, 0.25, 0.5)
	elseif i == 8 then
		icon[i]:GetNormalTexture():SetTexCoord(0.75, 1, 0.25, 0.5)
	end
end

markbarbutton:SetScript("OnClick", function()
	if MarkBarBG:IsVisible() then
		MarkBarBG:Hide()
	else
		MarkBarBG:Show()
	end
end)