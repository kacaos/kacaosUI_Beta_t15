local T, C, L, G, _ = unpack(Tukui)
if C.actionbar.enable ~= true then return end

if C.actionbar.micromenu then
----------------------------------------------------------------------------------------
--	Micro menu(by Elv22)
----------------------------------------------------------------------------------------
local microbuttons = {
	"CharacterMicroButton",
	"SpellbookMicroButton",
	"TalentMicroButton",
	"AchievementMicroButton",
	"QuestLogMicroButton",
	"GuildMicroButton",
	"PVPMicroButton",
	"LFDMicroButton",
	"CompanionsMicroButton",
	"EJMicroButton",
	"MainMenuMicroButton",
	"HelpMicroButton"
}

local framemover = CreateFrame("Frame","MicroAnchormover",UIParent, "SecureHandlerStateTemplate")
framemover:SetTemplate("Transparent")
framemover:Point("TOPLEFT", data1, "TOPRIGHT", 3, 0)
framemover:SetMovable(true)
framemover:SetFrameLevel(10)
framemover:SetBackdropBorderColor(0,1,0)
framemover.text = T.SetFontString(framemover, C.media.font, 12, "OUTLINE")
framemover.text:SetPoint("CENTER")
framemover.text:SetText("Move Micromenu")
framemover:Hide()
tinsert(T.AllowFrameMoving, framemover)

local frame = CreateFrame("Frame", "MicroAnchor", UIParent)

frame:Width(((CharacterMicroButton:GetWidth() + 4) * 9) + 12)
frame:Height(CharacterMicroButton:GetHeight() - 28)
frame.shown = false
if C.actionbar.micromenumouseover == true then frame:SetAlpha(0) end

framemover:Size(frame:GetWidth(), frame:GetHeight())
frame:Point("CENTER", framemover, "CENTER",  0, 0)
UpdateMicroButtonsParent(frame)

local function CheckFade(self, elapsed)
	local mouseactive
	for i, button in pairs(microbuttons) do
		local b = _G[button]
		if b.mouseover == true then
			mouseactive = true
		end
	end

	if C.actionbar.micromenumouseover ~= true then return end

	if frame.mouseover == true then
		mouseactive = true
		if GameTooltip:IsShown() then
			GameTooltip:Hide()
		end
	end

	if mouseactive == true then
		if frame.shown ~= true then
			frame:SetAlpha(1)
			frame.shown = true
		end
	else
		if frame.shown == true then
			frame:SetAlpha(0)
			frame.shown = false
		end
	end
end
frame:SetScript("OnUpdate", CheckFade)

function tabardupdate()
	GuildMicroButtonTabard:ClearAllPoints()
	GuildMicroButtonTabard:SetPoint("TOP", GuildMicroButton, "TOP", 0, -5)
	
	MicroButtonPortrait:ClearAllPoints()
	MicroButtonPortrait:Point("TOPLEFT", CharacterMicroButton.frame, "TOPLEFT", 2, -2)
	MicroButtonPortrait:Point("BOTTOMRIGHT", CharacterMicroButton.frame, "BOTTOMRIGHT", -2, 2)
end
hooksecurefunc("UpdateMicroButtons", tabardupdate)

for i, button in pairs(microbuttons) do
	local m = _G[button]
	local pushed = m:GetPushedTexture()
	local normal = m:GetNormalTexture()
	local disabled = m:GetDisabledTexture()

	m:SetParent(frame)
	m.SetParent = T.dummy
	_G[button.."Flash"]:SetTexture("")
	m:SetHighlightTexture("")
	m.SetHighlightTexture = T.dummy

	local f = CreateFrame("Frame", nil, m)
	f:SetFrameLevel(1)
	f:SetFrameStrata("BACKGROUND")
	f:Point("BOTTOMLEFT", m, "BOTTOMLEFT", 2, 0)
	f:Point("TOPRIGHT", m, "TOPRIGHT", -2, -28)
	f:SetTemplate("Default", true)
	m.frame = f

	pushed:SetTexCoord(0.17, 0.87, 0.5, 0.908)
	pushed:ClearAllPoints()
	pushed:Point("TOPLEFT", m.frame, "TOPLEFT", 1, -1)
	pushed:Point("BOTTOMRIGHT", m.frame, "BOTTOMRIGHT", -1, 1)

	normal:SetTexCoord(0.17, 0.87, 0.5, 0.908)
	normal:ClearAllPoints()
	normal:Point("TOPLEFT", m.frame, "TOPLEFT", 1, -1)
	normal:Point("BOTTOMRIGHT", m.frame, "BOTTOMRIGHT", -1, 1)

	if disabled then
		disabled:SetTexCoord(0.17, 0.87, 0.5, 0.908)
		disabled:ClearAllPoints()
		disabled:Point("TOPLEFT", m.frame, "TOPLEFT", 1, -1)
		disabled:Point("BOTTOMRIGHT", m.frame, "BOTTOMRIGHT", -1, 1)
	end

	m.mouseover = false
	m:HookScript("OnEnter", function(self)
		self.frame:SetBackdropBorderColor(1,1,1)
		self.mouseover = true
	end)
	m:HookScript("OnLeave", function(self)
		self.frame:SetBackdropBorderColor(unpack(C.media.bordercolor))
		self.mouseover = false
	end)
end

CharacterMicroButton:ClearAllPoints()
CharacterMicroButton:Point("BOTTOMLEFT", frame, "BOTTOMLEFT", -2, 0)
CharacterMicroButton.SetPoint = T.dummy
CharacterMicroButton.ClearAllPoints = T.dummy
end