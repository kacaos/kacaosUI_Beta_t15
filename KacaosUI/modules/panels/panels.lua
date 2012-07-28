local T, C, L = unpack(Tukui)

---------------------------------------------------------------
-- Panels
---------------------------------------------------------------
-- I want to hide some panels, because I don't like it
local panels = {TukuiInfoRight, TukuiInfoLeftLineVertical, TukuiInfoRightLineVertical, TukuiCubeLeft, TukuiCubeRight, TukuiLineToABLeft, TukuiLineToABRight, TukuiLineToPetActionBarBackground}
for _, panel in pairs(panels) do
	panel:Kill()
end

-- bottom panel
if C.misc.infobottom then
local ibottom = CreateFrame("Frame", "InfoBottom", UIParent)
--ibottom:CreatePanel("Default", T.screenwidth, 13, "BOTTOM", UIParent, "BOTTOM", 0, 0)
ibottom:SetTemplate("Default")
ibottom:Height(13)
ibottom:Width(T.screenwidth)
ibottom:Point("BOTTOM", UIParent, "BOTTOM", 0, 0)
ibottom:SetFrameStrata("BACKGROUND")
ibottom:SetBackdropColor(.06,.06,.06,.7)
ibottom:SetBackdropBorderColor(0,0,0,.7)
end

-- chatbackround left
local clWidth = C.chat.chatbackgroundwidth
local clHeight = C.chat.chatbackgroundheight

if not C.misc.infobottom == true then
	if C.chat.chatbackground then
		local chatbleft = CreateFrame("Frame", "ChatBackgroundLeft", UIParent)
			--chatbleft:CreatePanel("Default", clWidth, clHeight, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", 0, 0)
			chatbleft:Height(clHeight)
			chatbleft:Width(clWidth)
			chatbleft:Point("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 0, 0)
			chatbleft:SetTemplate("Default")
			chatbleft:SetFrameLevel(0)
			chatbleft:SetFrameStrata("BACKGROUND")
			chatbleft:SetBackdropColor(.06,.06,.06,.7)
		else	
		local chatbleft = CreateFrame("Frame", "ChatBackgroundLeft", UIParent)
			--chatbleft:CreatePanel("Default", clWidth, clHeight, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", 0, 0)
			chatbleft:Height(clHeight)
			chatbleft:Width(clWidth)
			chatbleft:Point("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 0, 0)
			chatbleft:SetTemplate("Default")
			chatbleft:SetAlpha(0)

			TukuiInfoLeft:ClearAllPoints()
			TukuiInfoLeft:SetPoint("BOTTOM", ChatBackgroundLeft, "TOP", 0, 1)
			TukuiInfoLeft:Width(ChatBackgroundLeft:GetWidth())
			TukuiInfoLeft:Height(12)
			TukuiInfoLeft:SetAlpha(0)
	end
	
	elseif C.chat.chatbackground then
		local chatbleft = CreateFrame("Frame", "ChatBackgroundLeft", UIParent)
		--	chatbleft:CreatePanel("Default", clWidth, clHeight, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", 3, 18)
			chatbleft:Height(clHeight)
			chatbleft:Width(clWidth)
			chatbleft:Point("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 3, 18)
			chatbleft:SetTemplate("Default")
			chatbleft:SetFrameLevel(0)
			chatbleft:SetFrameStrata("BACKGROUND")
			chatbleft:SetBackdropColor(.06,.06,.06,.7)
		else
		
		local chatbleft = CreateFrame("Frame", "ChatBackgroundLeft", UIParent)
			--chatbleft:CreatePanel("Default", clWidth, clHeight, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", 3, 18)
			chatbleft:Height(clHeight)
			chatbleft:Width(clWidth)
			chatbleft:Point("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 3, 18)
			chatbleft:SetTemplate("Default")
			chatbleft:SetAlpha(0)	
end

-- TukuiInfoLeft as chattabpanel - and editbox over the chatbackground
if C.chat.chattab then
	TukuiInfoLeft:ClearAllPoints()
	TukuiInfoLeft:SetPoint("BOTTOM", ChatBackgroundLeft, "TOP", 0, -15)
	TukuiInfoLeft:Width(ChatBackgroundLeft:GetWidth()-4)
	TukuiInfoLeft:Height(12)
	TukuiInfoLeft:SetBackdropColor(.06,.06,.06,.7)
else
	TukuiInfoLeft:ClearAllPoints()
	TukuiInfoLeft:SetPoint("BOTTOM", ChatBackgroundLeft, "TOP", 0, 1)
	TukuiInfoLeft:Width(ChatBackgroundLeft:GetWidth())
	TukuiInfoLeft:Height(12)
	TukuiInfoLeft:SetAlpha(0)
end

-- minimap stat (time default)
local minimapstat = CreateFrame("Frame", "MinimapStat", TukuiMinimap)
--minimapstat:CreatePanel("Default", 50, 15, "TOP", TukuiMinimap, "TOP", 0, 13)
minimapstat:Height(15)
minimapstat:Width(50)
minimapstat:SetTemplate("Default")
minimapstat:Point("TOP", TukuiMinimap, "TOP", 0, 13)
minimapstat:SetFrameLevel(2)
minimapstat:SetFrameStrata("HIGH")
minimapstat:SetBackdropColor(0,0,0,0)
minimapstat:SetBackdropBorderColor(0,0,0,0)

local fadeout = CreateFrame("Frame")
fadeout:RegisterEvent("PLAYER_ENTERING_WORLD")
fadeout:RegisterEvent("PLAYER_REGEN_ENABLED")
fadeout:RegisterEvent("PLAYER_REGEN_DISABLED")
fadeout:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_REGEN_ENABLED" then
			MinimapStat:Show()
	elseif event == "PLAYER_REGEN_DISABLED" then
			MinimapStat:Hide()
	end
end)

if C.chat.fadeout then
local fadeout = CreateFrame("Frame")
fadeout:RegisterEvent("PLAYER_ENTERING_WORLD")
fadeout:RegisterEvent("PLAYER_REGEN_ENABLED")
fadeout:RegisterEvent("PLAYER_REGEN_DISABLED")
fadeout:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_REGEN_ENABLED" then
			MinimapStat:Show()
			ChatBackgroundLeft:Show()
			TukuiInfoLeft:Show()
	elseif event == "PLAYER_REGEN_DISABLED" then
			MinimapStat:Hide()
			ChatBackgroundLeft:Hide()
			TukuiInfoLeft:Hide()
	end
end)
end


--InfoPanel in top of the screen
local ip = CreateFrame("Frame", "InfoPanel", UIParent)
--ip:CreatePanel("Transparent", 159, 10, "TOP", UIParent, "TOP", 0, -8)
ip:Height(10)
ip:Width(159)
ip:Point("TOP", UIParent, "TOP", 0, -8)
ip:SetTemplate("Transparent")
ip:SetFrameStrata("BACKGROUND")

--Line left (ip)
local ipl = CreateFrame("Frame", "InfoPanelLeftLine", UIParent)
--ipl:CreatePanel("Transparent", 2, 9, "TOP", UIParent, "TOP", -59, 1)
ipl:Height(9)
ipl:Width(2)
ipl:Point("TOP", UIParent, "TOP", -59, 1)
ipl:SetTemplate("Transparent")

--Line right (ip)
local ipr = CreateFrame("Frame", "InfoPanelRightLine", UIParent)
--ipr:CreatePanel("Transparent", 2, 9, "TOP", UIParent, "TOP", 59, 1)
ipr:Height(9)
ipr:Width(2)
ipr:Point("TOP", UIParent, "TOP", 59, 1)
ipr:SetTemplate("Transparent")

----------------------------------------------------------
-- Vehicle Exit Button
----------------------------------------------------------

-- move the left button the the chatbackground
TukuiExitVehicleButtonLeft:ClearAllPoints()
TukuiExitVehicleButtonLeft:Point("BOTTOMLEFT", ChatBackgroundLeft, "BOTTOMRIGHT", 2, 0)
TukuiExitVehicleButtonLeft:Height(30)
TukuiExitVehicleButtonLeft:Width(30)
TukuiExitVehicleButtonLeft:SetTemplate("Transparent")
TukuiExitVehicleButtonLeft:SetFrameStrata("Background")

-- kill the right exit button
TukuiExitVehicleButtonRight:Kill()

------------------------------------------------------------
--Filger Panels
------------------------------------------------------------
local fpbmover = CreateFrame("Frame", "FilgerPlayerBuffsMover", UIParent)
fpbmover:Width(150)
fpbmover:Height(36)
fpbmover:Point("CENTER", UIParent, "CENTER", 0, 0)
fpbmover:SetTemplate("Transparent")
fpbmover:SetBackdropBorderColor(0,1,0)
fpbmover:SetClampedToScreen(true)
fpbmover:SetMovable(true)
fpbmover:Hide()
fpbmover:FontString("Text", C.media.font, 12)
fpbmover.Text:SetPoint("CENTER", FilgerPlayerBuffsMover, "CENTER", 0, 0)
fpbmover.Text:SetText("FilgerPlayerBuffs")
tinsert(T.AllowFrameMoving, fpbmover)


local fpdmover = CreateFrame("Frame","FilgerPlayerDebuffsMover", UIParent)
fpdmover:SetTemplate("Transparent")
fpdmover:Size(150,36)
fpdmover:Point("CENTER", UIParent, "CENTER", 0, 0)
fpdmover:SetMovable(true)
fpdmover:SetClampedToScreen(true)
fpdmover:SetBackdropBorderColor(1,0,0)
fpdmover:FontString("Text", C.media.font, 12)
fpdmover.Text:SetPoint("CENTER", FilgerPlayerDebuffsMover, "CENTER", 0, 0)
fpdmover.Text:SetText("FilgerPlayerDeBuffs")
fpdmover:Hide()
tinsert(T.AllowFrameMoving, fpdmover)

local fppmover = CreateFrame("Frame","FilgerPlayerProccsMover", UIParent)
fppmover:SetTemplate("Transparent")
fppmover:Size(150,36)
fppmover:Point("CENTER", UIParent, "CENTER", 0, 0)
fppmover:SetMovable(true)
fppmover:SetClampedToScreen(true)
fppmover:SetBackdropBorderColor(1,0,0)
fppmover:FontString("Text", C.media.font, 12)
fppmover.Text:SetPoint("CENTER", FilgerPlayerProccsMover, "CENTER", 0, 0)
fppmover.Text:SetText("FilgerPlayerProccs")
fppmover:Hide()
tinsert(T.AllowFrameMoving, fppmover)

local fpcdmover = CreateFrame("Frame","FilgerPlayerCDMover",UIParent)
fpcdmover:SetTemplate("Transparent")
fpcdmover:Size(150,36)
fpcdmover:Point("CENTER", UIParent, "CENTER", 0, 0)
fpcdmover:SetMovable(true)
fpcdmover:SetClampedToScreen(true)
fpcdmover:SetBackdropBorderColor(1,0,0)
fpcdmover:FontString("Text", C.media.font, 12)
fpcdmover.Text:SetPoint("CENTER", FilgerPlayerCDMover, "CENTER", 0, 0)
fpcdmover.Text:SetText("FilgerPlayerCDs")
fpcdmover:Hide()
tinsert(T.AllowFrameMoving, fpcdmover)