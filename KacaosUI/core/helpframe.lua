local T, C, L = unpack(Tukui)

-- main frame
local DuffedUIMainFrame = CreateFrame("Frame", "DuffedUIMainFrame", UIParent)
DuffedUIMainFrame:SetSize(650, 350)
DuffedUIMainFrame:SetPoint("CENTER")
DuffedUIMainFrame:SetTemplate("Transparent")
DuffedUIMainFrame:CreateShadow("Default")
DuffedUIMainFrame:Hide()
DuffedUIMainFrame:SetFrameLevel(10)
DuffedUIMainFrame:SetFrameStrata("HIGH")
DuffedUIMainFrame:SetMovable(true)
DuffedUIMainFrame:SetScript("OnMouseDown", function() DuffedUIMainFrame:ClearAllPoints() DuffedUIMainFrame:StartMoving() end)
DuffedUIMainFrame:SetScript("OnMouseUp", function() DuffedUIMainFrame:StopMovingOrSizing() end)

local DuffedUIMainFrameTitle = CreateFrame("Frame", "TukuiInstallTitle", DuffedUIMainFrame)
--DuffedUIMainFrameTitle:CreatePanel("Transparent", DuffedUIMainFrame:GetWidth( ) - 92, 30, "BOTTOM", DuffedUIMainFrame, "TOP", 0, 3)
DuffedUIMainFrameTitle:SetSize(DuffedUIMainFrame:GetWidth() - 92, 30)
DuffedUIMainFrameTitle:SetTemplate("Transparent")
DuffedUIMainFrameTitle:SetPoint("BOTTOM", DuffedUIMainFrame, "TOP", 0, 3)
DuffedUIMainFrameTitle:SetFrameStrata("HIGH")

DuffedUIMainFrameTitle:CreateShadow("Default")
local DuffedUIMainFrameTitleText = DuffedUIMainFrameTitle:CreateFontString(nil, "OVERLAY")
DuffedUIMainFrameTitleText:SetFont(C.media.help, 16, "THINOUTLINE")
DuffedUIMainFrameTitleText:SetPoint("CENTER", DuffedUIMainFrameTitle, 0, 0)
DuffedUIMainFrameTitleText:SetText(L.duffeduihelp_header.." "..T.kacaosrelease)

-- main frame - navigation
local DuffedUIMainFrameNavigation = CreateFrame("Frame", "DuffedUIMainFrameNavigation", DuffedUIMainFrame)
DuffedUIMainFrameNavigation:SetSize(180, 342)
DuffedUIMainFrameNavigation:SetPoint("LEFT", 4, 0)
DuffedUIMainFrameNavigation:SetTemplate("Transparent")

-- main frame - content
local DuffedUIMainFrameContent = CreateFrame("Frame", "DuffedUIMainFrameContent", DuffedUIMainFrame)
DuffedUIMainFrameContent:SetSize(458, 342)
DuffedUIMainFrameContent:SetPoint("RIGHT", -4, 0)
DuffedUIMainFrameContent:SetTemplate("Transparent")

local DuffedUIMainFrameContentScrollFrame = CreateFrame("ScrollFrame", "DuffedUIMainFrameContentScrollFrame", DuffedUIMainFrameContent, "UIPanelScrollFrameTemplate")
DuffedUIMainFrameContentScrollFrame:SetPoint("TOPLEFT", DuffedUIMainFrameContent, "TOPLEFT", 10, -10)
DuffedUIMainFrameContentScrollFrame:SetPoint("BOTTOMRIGHT", DuffedUIMainFrameContent, "BOTTOMRIGHT", -30, 10)
T.SkinScrollBar(DuffedUIMainFrameContentScrollFrameScrollBar)

local DuffedUIMainFrameContentScrollFrameBackground = CreateFrame("Frame", "DuffedUIMainFrameContentScrollFrameBackground", DuffedUIMainFrameContentScrollFrame)
DuffedUIMainFrameContentScrollFrameBackground:SetPoint("TOPLEFT")
DuffedUIMainFrameContentScrollFrameBackground:SetWidth(DuffedUIMainFrameContentScrollFrame:GetWidth())
DuffedUIMainFrameContentScrollFrameBackground:SetHeight(DuffedUIMainFrameContentScrollFrame:GetHeight())
DuffedUIMainFrameContentScrollFrame:SetScrollChild(DuffedUIMainFrameContentScrollFrameBackground)

local DuffedUIMainFrameContentTitle = DuffedUIMainFrameContentScrollFrameBackground:CreateFontString(nil, "OVERLAY")
DuffedUIMainFrameContentTitle:SetFont(C.media.help, 14, "THINOUTLINE")
DuffedUIMainFrameContentTitle:SetPoint("TOP", DuffedUIMainFrameContentScrollFrameBackground, "TOP", 0, -10)

local DuffedUIMainFrameContentText1 = DuffedUIMainFrameContentScrollFrameBackground:CreateFontString(nil, "OVERLAY")
DuffedUIMainFrameContentText1:SetJustifyH("LEFT")
DuffedUIMainFrameContentText1:SetFont(C.media.help, 14, "THINOUTLINE")
DuffedUIMainFrameContentText1:SetWidth(DuffedUIMainFrameContentScrollFrameBackground:GetWidth() - 20)
DuffedUIMainFrameContentText1:SetPoint("TOPLEFT", DuffedUIMainFrameContentScrollFrameBackground, "TOPLEFT", 20, -45)

local DuffedUIMainFrameContentText2 = DuffedUIMainFrameContentScrollFrameBackground:CreateFontString(nil, "OVERLAY")
DuffedUIMainFrameContentText2:SetJustifyH("LEFT")
DuffedUIMainFrameContentText2:SetFont(C.media.help, 14, "THINOUTLINE")
DuffedUIMainFrameContentText2:SetWidth(DuffedUIMainFrameContentScrollFrameBackground:GetWidth() - 30)
DuffedUIMainFrameContentText2:SetPoint("TOPLEFT", DuffedUIMainFrameContentText1, "BOTTOMLEFT", 0, -20)

local DuffedUIMainFrameContentText3 = DuffedUIMainFrameContentScrollFrameBackground:CreateFontString(nil, "OVERLAY")
DuffedUIMainFrameContentText3:SetJustifyH("LEFT")
DuffedUIMainFrameContentText3:SetFont(C.media.help, 14, "THINOUTLINE")
DuffedUIMainFrameContentText3:SetWidth(DuffedUIMainFrameContentScrollFrameBackground:GetWidth() - 30)
DuffedUIMainFrameContentText3:SetPoint("TOPLEFT", DuffedUIMainFrameContentText2, "BOTTOMLEFT", 0, -20)

local DuffedUIMainFrameContentText4 = DuffedUIMainFrameContentScrollFrameBackground:CreateFontString(nil, "OVERLAY")
DuffedUIMainFrameContentText4:SetJustifyH("LEFT")
DuffedUIMainFrameContentText4:SetFont(C.media.help, 14, "THINOUTLINE")
DuffedUIMainFrameContentText4:SetWidth(DuffedUIMainFrameContentScrollFrameBackground:GetWidth() - 30)
DuffedUIMainFrameContentText4:SetPoint("TOPLEFT", DuffedUIMainFrameContentText3, "BOTTOMLEFT", 0, -20)

-- main frame - navigation - buttons
local DuffedUIMainFrameNavigationButtonAttributes = {
	[1] = {"/kuihelp 1"},
	[2] = {"/kuihelp 2"},
	[3] = {"/kuihelp 3"},
	[4] = {"/kuihelp 4"},
	[5] = {"/kuihelp 5"},
	[6] = {"/kuihelp 6"},
	[7] = {"/kuihelp 7"},
	[8] = {"/kuihelp 8"},
	[9] = {"/kuihelp 9"},
}

local DuffedUIMainFrameNavigationButtonTexts = {
	[1] = {T.RGBToHex(unpack(C["media"].datatextcolor2))..L.duffeduihelp_button1},
	[2] = {T.RGBToHex(unpack(C["media"].datatextcolor2))..L.duffeduihelp_button2},
	[3] = {T.RGBToHex(unpack(C["media"].datatextcolor2))..L.duffeduihelp_button3},
	[4] = {T.RGBToHex(unpack(C["media"].datatextcolor2))..L.duffeduihelp_button4},
	[5] = {T.RGBToHex(unpack(C["media"].datatextcolor2))..L.duffeduihelp_button5},
	[6] = {T.RGBToHex(unpack(C["media"].datatextcolor2))..L.duffeduihelp_button6},
	[7] = {T.RGBToHex(unpack(C["media"].datatextcolor2))..L.duffeduihelp_button7},
	[8] = {T.RGBToHex(unpack(C["media"].datatextcolor2))..L.duffeduihelp_button8},
	[9] = {T.RGBToHex(unpack(C["media"].datatextcolor2))..L.duffeduihelp_button9},
}

local DuffedUIMainFrameNavigationButton = CreateFrame("Button", "DuffedUIMainFrameNavigationButton", DuffedUIMainFrameNavigation)
for i = 1, 9 do
	DuffedUIMainFrameNavigationButton[i] = CreateFrame("Button", "DuffedUIMainFrameNavigationButton" .. i, DuffedUIMainFrameNavigation, "SecureActionButtonTemplate")
	--DuffedUIMainFrameNavigationButton[i]:CreatePanel("Default", DuffedUIMainFrameNavigation:GetWidth() - 8, 24, "TOP", DuffedUIMainFrameNavigation, "TOP", 0, -4, true)
	DuffedUIMainFrameNavigationButton[i]:SetSize(DuffedUIMainFrameNavigation:GetWidth() - 8, 24)
	DuffedUIMainFrameNavigationButton[i]:SetPoint("TOP", DuffedUIMainFrameNavigation, "TOP", 0, -4, true)
	DuffedUIMainFrameNavigationButton[i]:SetTemplate("Default")
	DuffedUIMainFrameNavigationButton[i].Text = T.SetFontString(DuffedUIMainFrameNavigationButton[i], C.media.help, 14, "THINOUTLINE")
	DuffedUIMainFrameNavigationButton[i]:SetFrameLevel(DuffedUIMainFrameNavigation:GetFrameLevel() + 1)
	DuffedUIMainFrameNavigationButton[i]:SetFrameStrata("HIGH")
	DuffedUIMainFrameNavigationButton[i].Text:Point("CENTER", DuffedUIMainFrameNavigationButton[i], "CENTER", 0, 1)
	DuffedUIMainFrameNavigationButton[i].Text:SetText(unpack( DuffedUIMainFrameNavigationButtonTexts[i]))

	if i == 1 then
		DuffedUIMainFrameNavigationButton[i]:Point("TOP", DuffedUIMainFrameNavigation, "TOP", 0, -5)
	else
		DuffedUIMainFrameNavigationButton[i]:Point("TOP", DuffedUIMainFrameNavigationButton[i - 1], "BOTTOM", 0, -3)
	end
	DuffedUIMainFrameNavigationButton[i]:SetAttribute("type", "macro")
	DuffedUIMainFrameNavigationButton[i]:SetAttribute("macrotext", unpack(DuffedUIMainFrameNavigationButtonAttributes[i]))
	DuffedUIMainFrameNavigationButton[i]:CreateOverlay(DuffedUIMainFrameNavigationButton[i])
	DuffedUIMainFrameNavigationButton[i]:HookScript("OnEnter", function(self)
		self:SetBackdropBorderColor(1,1,1)	
	end)
	DuffedUIMainFrameNavigationButton[i]:HookScript("OnLeave", function(self)
		self:SetBackdropBorderColor(0,0,0)
	end)
end

---------------------------------------------------------------------------------------------
-- functions
---------------------------------------------------------------------------------------------
local dhelpcontentclose = CreateFrame("Button", "DuffedUIMainFrameContentCloseButton", DuffedUIMainFrameContentScrollFrameBackground, "UIPanelCloseButton")
dhelpcontentclose:SetPoint("TOPRIGHT", DuffedUIMainFrameContentScrollFrameBackground, "TOPRIGHT")
T.SkinCloseButton(dhelpcontentclose)
dhelpcontentclose:SetScript("OnClick", function()
	DuffedUIMainFrame:Hide()
end )

local dhelpcontent = function()
	DuffedUIMainFrameContentTitle:SetText(L.duffeduihelp_content0_title)
	DuffedUIMainFrameContentText1:SetText(L.duffeduihelp_content0_line1)
	DuffedUIMainFrameContentText2:SetText(L.duffeduihelp_content0_line2)
	DuffedUIMainFrameContentText3:SetText(L.duffeduihelp_content0_line3)
	DuffedUIMainFrameContentText4:SetText(L.duffeduihelp_content0_line4)
end

local dhelp9content = function()
	DuffedUIMainFrameContentTitle:SetText(L.duffeduihelp_content9_title)
	DuffedUIMainFrameContentText1:SetText(L.duffeduihelp_content9_line1)
	DuffedUIMainFrameContentText2:SetText(L.duffeduihelp_content9_line2)
	DuffedUIMainFrameContentText3:SetText(L.duffeduihelp_content9_line3)
	DuffedUIMainFrameContentText4:SetText(L.duffeduihelp_content9_line4)
end

local dhelp8content = function()
	DuffedUIMainFrameContentTitle:SetText(L.duffeduihelp_content8_title)
	DuffedUIMainFrameContentText1:SetText(L.duffeduihelp_content8_line1)
	DuffedUIMainFrameContentText2:SetText(L.duffeduihelp_content8_line2)
	DuffedUIMainFrameContentText3:SetText(L.duffeduihelp_content8_line3)
	DuffedUIMainFrameContentText4:SetText(L.duffeduihelp_content8_line4)
end

local dhelp7content = function()
	DuffedUIMainFrameContentTitle:SetText(L.duffeduihelp_content7_title)
	DuffedUIMainFrameContentText1:SetText(L.duffeduihelp_content7_line1)
	DuffedUIMainFrameContentText2:SetText(L.duffeduihelp_content7_line2)
	DuffedUIMainFrameContentText3:SetText(L.duffeduihelp_content7_line3)
	DuffedUIMainFrameContentText4:SetText(L.duffeduihelp_content7_line4)
end

local dhelp6content = function()
	DuffedUIMainFrameContentTitle:SetText(L.duffeduihelp_content6_title)
	DuffedUIMainFrameContentText1:SetText(L.duffeduihelp_content6_line1)
	DuffedUIMainFrameContentText2:SetText(L.duffeduihelp_content6_line2)
	DuffedUIMainFrameContentText3:SetText(L.duffeduihelp_content6_line3)
	DuffedUIMainFrameContentText4:SetText(L.duffeduihelp_content6_line4)
end

local dhelp5content = function()
	DuffedUIMainFrameContentTitle:SetText(L.duffeduihelp_content5_title)
	DuffedUIMainFrameContentText1:SetText(L.duffeduihelp_content5_line1)
	DuffedUIMainFrameContentText2:SetText(L.duffeduihelp_content5_line2)
	DuffedUIMainFrameContentText3:SetText(L.duffeduihelp_content5_line3)
	DuffedUIMainFrameContentText4:SetText(L.duffeduihelp_content5_line4)
end

local dhelp4content = function()
	DuffedUIMainFrameContentTitle:SetText(L.duffeduihelp_content4_title)
	DuffedUIMainFrameContentText1:SetText(L.duffeduihelp_content4_line1)
	DuffedUIMainFrameContentText2:SetText(L.duffeduihelp_content4_line2)
	DuffedUIMainFrameContentText3:SetText(L.duffeduihelp_content4_line3)
	DuffedUIMainFrameContentText4:SetText(L.duffeduihelp_content4_line4)
end

local dhelp3content = function()
	DuffedUIMainFrameContentTitle:SetText(L.duffeduihelp_content3_title)
	DuffedUIMainFrameContentText1:SetText(L.duffeduihelp_content3_line1)
	DuffedUIMainFrameContentText2:SetText(L.duffeduihelp_content3_line2)
	DuffedUIMainFrameContentText3:SetText(L.duffeduihelp_content3_line3)
	DuffedUIMainFrameContentText4:SetText(L.duffeduihelp_content3_line4)
end

local dhelp2content = function()
	DuffedUIMainFrameContentTitle:SetText(L.duffeduihelp_content2_title)
	DuffedUIMainFrameContentText1:SetText(L.duffeduihelp_content2_line1)
	DuffedUIMainFrameContentText2:SetText(L.duffeduihelp_content2_line2)
	DuffedUIMainFrameContentText3:SetText(L.duffeduihelp_content2_line3)
	DuffedUIMainFrameContentText4:SetText(L.duffeduihelp_content2_line4)
end

local dhelp1content = function()
	DuffedUIMainFrameContentTitle:SetText(L.duffeduihelp_content1_title)
	DuffedUIMainFrameContentText1:SetText(L.duffeduihelp_content1_line1)
	DuffedUIMainFrameContentText2:SetText(L.duffeduihelp_content1_line2)
	DuffedUIMainFrameContentText3:SetText(L.duffeduihelp_content1_line3)
	DuffedUIMainFrameContentText4:SetText(L.duffeduihelp_content1_line4)
end

-- slash command
local dhelp = DuffedUIHelp or function() end
DuffedUIHelp = function(msg)
	if InCombatLockdown() then print(ERR_NOT_IN_COMBAT) return end

	if msg == "1" then
		if not DuffedUIMainFrame:IsVisible() then return end
		dhelp1content()
	elseif msg == "2" then
		if not DuffedUIMainFrame:IsVisible() then return end
		dhelp2content()
	elseif msg == "3" then
		if not DuffedUIMainFrame:IsVisible() then return end
		dhelp3content()
	elseif msg == "4" then
		if not DuffedUIMainFrame:IsVisible() then return end
		dhelp4content()
	elseif msg == "5" then
		if not DuffedUIMainFrame:IsVisible() then return end
		dhelp5content()
	elseif msg == "6" then
		if not DuffedUIMainFrame:IsVisible() then return end
		dhelp6content()
	elseif msg == "7" then
		if not DuffedUIMainFrame:IsVisible() then return end
		dhelp7content()
	elseif msg == "8" then
		if not DuffedUIMainFrame:IsVisible() then return end
		dhelp8content()
	elseif msg == "9" then
		if not DuffedUIMainFrame:IsVisible() then return end
		dhelp9content()
	else
		if DuffedUIMainFrame:IsVisible() then
			DuffedUIMainFrame:Hide()
		else
			DuffedUIMainFrame:Show()
			dhelpcontent()
		end
	end
end

SlashCmdList.DuffedUIHelp = DuffedUIHelp
SLASH_DuffedUIHelp1 = "/kuihelp"