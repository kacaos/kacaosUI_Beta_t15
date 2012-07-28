local T, C, L, G = unpack(Tukui)
local oUF = oUFTukui
local RaidDebuff = oUF_RaidDebuffs or oUFTukui_RaidDebuffs


local items = {}
local SearchString = "Enter Spell ID"
local NumLines = 19
local offset = 5

-- Saved Variables
local SaveVariables = function(self, event)
	if event == "ADDON_LOADED" then
		if TukuiData.DebuffList == nil then
			TukuiData.DebuffList = T.debuffids
		else
			T.debuffids = TukuiData.DebuffList
		end
	elseif event == "PLAYER_LOGOUT" then
		TukuiData.DebuffList = T.debuffids
	end
end

local Loader = CreateFrame("Frame")
Loader:RegisterEvent("ADDON_LOADED")
Loader:RegisterEvent("PLAYER_LOGOUT")
Loader:SetScript("OnEvent", SaveVariables)

local OnMouseWheel = function(self, delta)
	if delta < 0 and floor(self:GetVerticalScroll()) <= floor(self:GetVerticalScrollRange()) then
		for i = 1, NumLines do
			self:SetVerticalScroll(self:GetVerticalScroll() + 1)
		end
	elseif delta > 0 and floor(self:GetVerticalScroll()) > 0 then
		for i = 1, NumLines do
			self:SetVerticalScroll(self:GetVerticalScroll() - 1)
		end
	end
end

local CreateDebuffsConfig = function()
	-- Backdrop
	local Backdrop = CreateFrame("Frame", "NishaDebuffConfigFrame", UIParent)
	Backdrop:Size(165, 230)
	Backdrop:Point("CENTER", UIParent, "CENTER", 0, 0)
	Backdrop:SetTemplate("Default")

	-- Scroll
	local ScrollArea = CreateFrame("Frame", nil, Backdrop)
	ScrollArea:Size(Backdrop:GetWidth() - 6, 192)
	ScrollArea:Point("BOTTOM", Backdrop, "BOTTOM", 0, 5)
	ScrollArea:SetTemplate("Default")

	ScrollArea.Texture = ScrollArea:CreateTexture(nil, "OVERLAY")
	ScrollArea.Texture:Point("TOPLEFT", 2, -2)
	ScrollArea.Texture:Point("BOTTOMRIGHT", -2, 2)
	ScrollArea.Texture:SetTexture(unpack(C.media.bordercolor))
	
	local ScrollFrame = CreateFrame("ScrollFrame", "NishaDebuffConfigScrollFrame", ScrollArea)
	ScrollFrame:SetPoint("TOPLEFT", ScrollArea, "TOPLEFT", 0, -2)
	ScrollFrame:SetWidth(ScrollArea:GetWidth())
	ScrollFrame:SetHeight(ScrollArea:GetHeight())
	ScrollFrame:SetFrameLevel(ScrollArea:GetFrameLevel() + 1)

	ScrollFrame.Anchor = CreateFrame("Frame", nil, ScrollFrame)
	ScrollFrame.Anchor:SetPoint("TOPLEFT", ScrollFrame, "TOPLEFT", 1, -1)
	ScrollFrame.Anchor:SetWidth(ScrollArea:GetWidth())
	ScrollFrame.Anchor:SetHeight(ScrollFrame:GetHeight())
	ScrollFrame.Anchor:SetFrameLevel(ScrollFrame:GetFrameLevel() + 1)
	ScrollFrame:SetScrollChild(ScrollFrame.Anchor)
	ScrollFrame:SetScript("OnMouseWheel", OnMouseWheel)
	
	-- Functions
	local SortList = function()
		table.sort(T.debuffids, function (a, b)
			return (b > a)
		end)
		
		for key, value in pairs(T.debuffids) do
			if key == 1 then
				items[key]:Point("TOPLEFT", ScrollFrame.Anchor, 2, 0)
			else
				items[key]:Point("TOP", items[key-1], "BOTTOM", 0, -1)
			end
		end
	end

	local UpdateList = function(Name)
		local num = #T.debuffids

		items[num] = CreateFrame("Frame", nil, ScrollFrame.Anchor)
		items[num]:Size(ScrollFrame.Anchor:GetWidth() - 4, 18)
		
		items[num].Text = items[num]:CreateFontString(nil, "OVERLAY")
		items[num].Text:SetFont(C.media.font, 12)
		items[num].Text:SetText(Name)
		items[num].Text:Point("LEFT", items[num], 3, 0)
		items[num].Text:SetShadowColor(0, 0, 0)
		items[num].Text:SetShadowOffset(1.25, -1.25)
		
		SortList()
		RaidDebuff:RegisterDebuffs(T.debuffids) -- Register new ID's
	end

	local AddSpell = function(SpellID)
		local Name = select(1, GetSpellInfo(SpellID))
		
		if Name then
			if not T.debuffids[Name] then
				tinsert(T.debuffids, Name)
				print("Added " .. Name .. " to list.")
				
				UpdateList(Name)
			end
		else
			print(SpellID .. " is not a valid Spell ID.")
		end
	end

	local OnEnterPressed = function(self)
		local num = self:GetText()
		
		if type(tonumber(num)) == "number" then
			AddSpell(num)
		end

		self:ClearFocus()
		self:SetText(SearchString)
	end

	local OnEscapePressed = function(self)
		self:ClearFocus()
		self:SetText(SearchString)
	end

	local OnEditFocusGained = function(self)
		self:HighlightText()
	end

	-- Editbox
	local EditBox = CreateFrame("Frame", nil, Backdrop)
	EditBox:Size(Backdrop:GetWidth() - 35, 20)
	EditBox:Point("TOPLEFT", ScrollArea, "TOPLEFT", 0, 25)
	EditBox:SetTemplate("Default")

	EditBox.Entry = CreateFrame("Editbox", nil, EditBox)
	EditBox.Entry:SetFont(C.media.font, 12)
	EditBox.Entry:Point("TOPLEFT", 4, -2)
	EditBox.Entry:Point("BOTTOMRIGHT", -4, 2)
	EditBox.Entry:SetMaxLetters(14)
	EditBox.Entry:SetAutoFocus(false)
	EditBox.Entry:EnableKeyboard(true)
	EditBox.Entry:EnableMouse(true)
	EditBox.Entry:SetText(SearchString)
	EditBox.Entry:SetScript("OnEnterPressed", OnEnterPressed)
	EditBox.Entry:SetScript("OnEscapePressed", OnEscapePressed)
	EditBox.Entry:SetScript("OnEditFocusGained", OnEditFocusGained)
	
	
	local close = CreateFrame("Button", "deCloseButton", Backdrop, "UIPanelCloseButton")
	close:SetPoint("RIGHT", EditBox, "RIGHT", 35, 0)
	close:SkinCloseButton()
	close:SetScript("OnClick", function()
		NishaDebuffConfigFrame:Hide()
	end )

	table.sort(T.debuffids, function (a, b)
		return (b > a)
	end)
	
	for key, value in pairs(T.debuffids) do
		items[key] = CreateFrame("Frame", nil, ScrollFrame.Anchor)
		items[key]:Size(ScrollFrame.Anchor:GetWidth() - 4, 18)

		items[key].Text = items[key]:CreateFontString(nil, "OVERLAY")
		items[key].Text:SetFont(C.media.font, 12)
		items[key].Text:SetText(value)
		items[key].Text:Point("LEFT", items[key], 3, 0)
		items[key].Text:SetShadowColor(0, 0, 0)
		items[key].Text:SetShadowOffset(1.25, -1.25)

		if key == 1 then
			items[key]:Point("TOPLEFT", ScrollFrame.Anchor, 2, 0)
		else
			items[key]:Point("TOP", items[key-1], "BOTTOM", 0, -1)
		end
	end
end

local ToggleAddOn = function()
	if not NishaDebuffConfigFrame then
		CreateDebuffsConfig()
	else
		if not NishaDebuffConfigFrame:IsVisible() then
			NishaDebuffConfigFrame:Show()
		else
			NishaDebuffConfigFrame:Hide()
		end
	end
end

SLASH_DEBUFFS1 = "/debuffs"
SlashCmdList.DEBUFFS = ToggleAddOn