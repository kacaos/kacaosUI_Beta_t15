local T, C, L = unpack(Tukui)

--Smelly's Addon Manager

local aList = CreateFrame("Frame", "AddonManager", UIParent)
--aList:CreatePanel("Transparent", 300, 500, "CENTER", UIParent, "CENTER", 0, 0)
aList:SetSize(300, 500)
aList:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
aList:SetTemplate("Transparent")
aList:SetFrameStrata("MEDIUM")
aList:SetFrameLevel(10)
aList:Hide()
aList.header = CreateFrame("Frame", "AddonManager_Header", aList)
aList.header:Point("TOPLEFT", 4, -4)
aList.header:Point("TOPRIGHT", -4, -24)
aList.header:Height(20)
aList.header:SetTemplate("Transparent")
aList.header:FontString("text", C.media.pixelfont, 12, "MONOCHROMEOUTLINE")
aList.header.text:SetText("Addon List")
aList.header.text:SetPoint("CENTER")
tinsert(UISpecialFrames,aList:GetName());

aList.closeButton = CreateFrame("Frame", "AddonManager_CloseButton", aList)
aList.closeButton:Point("RIGHT", aList.header, "RIGHT", 0, 0)
aList.closeButton:Height(20)
aList.closeButton:Width(20)
aList.closeButton:EnableMouse(true)
aList.closeButton:FontString("text", C.media.pixelfont, 12, "MONOCHROMEOUTLINE")
aList.closeButton.text:SetPoint("CENTER")
aList.closeButton.text:SetText("X")
aList.closeButton:SetScript("OnMouseDown", function() aList:Hide() end)
aList.closeButton:SetScript("OnEnter", function()
	local color = RAID_CLASS_COLORS[T.myclass]
	aList.closeButton.text:SetTextColor(color.r, color.g, color.b)
end)
aList.closeButton:SetScript("OnLeave", function() aList.closeButton.text:SetTextColor(1, 1, 1) end)

aList.scrollFrame = CreateFrame("ScrollFrame", "AddonManager_ScrollFrame", aList, "UIPanelScrollFrameTemplate")
aList.scrollFrame:Point("TOPLEFT", aList.header, "TOPLEFT", 10, -40)
aList.scrollFrame:Point("BOTTOMRIGHT", aList, "BOTTOMRIGHT", -35, 40)
T.SkinScrollBar(AddonManager_ScrollFrameScrollBar)

aList.scrollAnchor = CreateFrame("Frame", "AddonManager_ScrollAnchor", scrollFrame)
aList.scrollAnchor:SetPoint("TOPLEFT")
aList.scrollAnchor:SetWidth(aList.scrollFrame:GetWidth())
aList.scrollAnchor:SetHeight(aList.scrollFrame:GetHeight())
aList.scrollFrame:SetScrollChild(aList.scrollAnchor)

aList.reloadButton = CreateFrame("Button", "AddonManager_ReloadButton", aList)
--aList.reloadButton:CreatePanel("Transparent", 100, 20, "BOTTOM", aList, "BOTTOM", 0, 10)
aList.reloadButton:SetSize(100, 20)
aList.reloadButton:SetPoint("BOTTOM", aList, "BOTTOM", 0, 10)
aList.reloadButton:SetTemplate("Transparent")
aList.reloadButton:EnableMouse(true)
aList.reloadButton:FontString("text", C.media.pixelfont, 12, "MONOCHROMEOUTLINE")
aList.reloadButton.text:SetPoint("CENTER")
aList.reloadButton.text:SetText("Reload UI")
aList.reloadButton:SetScript("OnClick", function() ReloadUI() end)
aList.reloadButton:HookScript("OnEnter", function(self)
		self:SetBackdropBorderColor(1,1,1)	
end)
aList.reloadButton:HookScript("OnLeave", function(self)
		self:SetBackdropBorderColor(0,0,0)	
end)
aList.reloadButton:SetFrameLevel(aList:GetFrameLevel()+1)
aList.reloadButton:SetFrameStrata("MEDIUM")

local function UpdateAddons()
	local addons = {}
	for i=1, GetNumAddOns() do
		addons[i] = select(1, GetAddOnInfo(i))
	end
	table.sort(addons)
	local oldb
	for i,v in pairs(addons) do
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(v)
		local button = CreateFrame("Button", v.."_Button", aList.scrollAnchor, "SecureActionButtonTemplate")
		button:SetFrameLevel(aList.scrollFrame:GetFrameLevel() + 1)
		button:Size(16, 16)
		button:SetTemplate("Transparent")

		-- to make sure the border is colored the right color on reload 
		if enabled then
			button:SetBackdropBorderColor(0,1,0)
		else
			button:SetBackdropBorderColor(1,0,0)
		end

		if i==1 then
			button:Point("TOPLEFT", aList.scrollAnchor, "TOPLEFT", 0, 0)
		else
			button:Point("TOP", oldb, "BOTTOM", 0, -7)
		end
		button:FontString("text", C.media.pixelfont, 12, "MONOCHROMEOUTLINE")
		button.text:Point("LEFT", button, "RIGHT", 8, 0)
		button.text:Point("RIGHT", aList.scrollAnchor, "RIGHT", 0, 0)
		button.text:SetText(title)

		button:SetScript("OnMouseDown", function()
			if enabled then
				button:SetBackdropBorderColor(1,0,0)
				DisableAddOn(name)
				enabled = false
			else
				button:SetBackdropBorderColor(0,1,0)
				EnableAddOn(name)
				enabled = true
			end
		end)

		oldb = button
	end
end

UpdateAddons()

-- Slash commands
SLASH_ALOAD1 = "/am"
SlashCmdList.ALOAD = function (msg)
	AddonManager:Show()
end