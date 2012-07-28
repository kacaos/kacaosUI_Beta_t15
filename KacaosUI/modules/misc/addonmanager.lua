local T, C, L = unpack(Tukui)

local T, C, L = unpack(Tukui)

local color = RAID_CLASS_COLORS[T.myclass]
cStart = ("|cff%.2x%.2x%.2x"):format(color.r * 255, color.g * 255, color.b * 255)

-- Slash commands
SLASH_ALOAD1 = "/am"
SlashCmdList.ALOAD = function (msg)
addonBG:Show()
end

local function ModifiedBackdrop(self)
local color = RAID_CLASS_COLORS[T.myclass]
self:SetBackdropColor(color.r*.15, color.g*.15, color.b*.15)
self:SetBackdropBorderColor(color.r, color.g, color.b)
end

local function OriginalBackdrop(self)
self:SetTemplate("Default")
end

-- Create BG
local addonBG = CreateFrame("Frame", "addonBG", UIParent)
addonBG:SetTemplate("Transparent")
addonBG:Size(T.InfoLeftRightWidth, 500)
addonBG:Point("CENTER", UIParent, "CENTER", 0, 0)
addonBG:EnableMouse(true)
addonBG:SetMovable(true)
addonBG:SetUserPlaced(true)
addonBG:SetClampedToScreen(true)
addonBG:SetScript("OnMouseDown", function(self) self:StartMoving() end)
addonBG:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
addonBG:SetFrameStrata("HIGH")
tinsert(UISpecialFrames, "addonBG")
addonBG:FadeIn()
addonBG:Hide()

local addonHeader = CreateFrame("Frame", "addonHeader", addonBG)
addonHeader:SetTemplate("Transparent")
addonHeader:Size(addonBG:GetWidth(), 23)
addonHeader:Point("BOTTOM", addonBG, "TOP", 0, 3, true)
addonHeader.Text = T.SetFontString(addonHeader, C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
addonHeader.Text:SetPoint("CENTER", 0, 1)
addonHeader.Text:SetText(cStart.."AddOns List"..": "..cStart..T.myname)

-- Create scroll frame
local scrollFrame = CreateFrame("ScrollFrame", "scrollFrame", addonBG, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", addonBG, "TOPLEFT", 10, -10)
scrollFrame:SetPoint("BOTTOMRIGHT", addonBG, "BOTTOMRIGHT", -30, 40)
T.SkinScrollBar(scrollFrame)


-- Create inside BG (uses scroll frame)
local buttonsBG = CreateFrame("Frame", "buttonsBG", scrollFrame)
buttonsBG:SetPoint("TOPLEFT")
buttonsBG:SetWidth(scrollFrame:GetWidth())
buttonsBG:SetHeight(scrollFrame:GetHeight())
scrollFrame:SetScrollChild(buttonsBG)

local saveButton = CreateFrame("Button", "saveButton", addonBG)
saveButton:SetTemplate("Default")
saveButton:Size(130, 20)
saveButton:Point("BOTTOMLEFT", addonBG, "BOTTOMLEFT", 10, 10, true)
saveButton:SetFrameStrata("TOOLTIP")
saveButton:CreateOverlay(saveButton)
saveButton:SetScript("OnClick", function() ReloadUI() end)
saveButton:HookScript("OnEnter", ModifiedBackdrop)
saveButton:HookScript("OnLeave", OriginalBackdrop)

saveButton.Text = T.SetFontString(saveButton, C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
saveButton.Text:Point("CENTER", saveButton, "CENTER", 1, 1)
saveButton.Text:SetText(cStart.."Save Changes")


local closeButton = CreateFrame("Button", "closeButton", addonBG)
closeButton:SetTemplate("Default")
closeButton:Size(130, 20)
closeButton:Point("BOTTOMRIGHT", addonBG, "BOTTOMRIGHT", -10, 10, true)
closeButton:SetFrameStrata("TOOLTIP")
closeButton:CreateOverlay(closeButton)
closeButton:SetScript("OnClick", function() addonBG:Hide() end)
closeButton:HookScript("OnEnter", ModifiedBackdrop)
closeButton:HookScript("OnLeave", OriginalBackdrop)

closeButton.Text = T.SetFontString(closeButton, C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
closeButton.Text:Point("CENTER", closeButton, "CENTER", 1, 1)
closeButton.Text:SetText(cStart.."Cancel")

local function UpdateAddons()
local addons = {}
for i=1, GetNumAddOns() do
addons[i] = select(1, GetAddOnInfo(i))
end
table.sort(addons)
local oldb
for i,v in pairs(addons) do
local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(v)
local button = CreateFrame("Button", v.."_Button", buttonsBG, "SecureActionButtonTemplate")
button:SetFrameLevel(buttonsBG:GetFrameLevel() + 1)
button:Size(50, 16)
button:SetTemplate("Default")
button:CreateOverlay()

-- to make sure the border is colored the right color on reload
if enabled then
button:SetBackdropBorderColor(0,1,0)
else
button:SetBackdropBorderColor(1,0,0)
end

if i==1 then
button:Point("TOPLEFT", buttonsBG, "TOPLEFT", 0, 0)
else
button:Point("TOP", oldb, "BOTTOM", 0, -7)
end
local text = T.SetFontString(button, C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
text:Point("LEFT", button, "RIGHT", 8, 0)
text:SetText(title)

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

T.SkinScrollBar(scrollFrameScrollBar)

-- local showb = CreateFrame("Button", "GameMenuButtonAddonManager" , GameMenuFrame, "GameMenuButtonTemplate")
-- T.SkinButton(GameMenuButtonAddonManager)
-- _G["GameMenuButtonAddonManagerLeft"]:SetAlpha(0)
-- _G["GameMenuButtonAddonManagerMiddle"]:SetAlpha(0)
-- _G["GameMenuButtonAddonManagerRight"]:SetAlpha(0)
-- showb:SetText(ADDONS)
-- showb:Point("TOP", GameMenuButtonKeybindings, "BOTTOM", 0, -1)
-- GameMenuButtonMacros:ClearAllPoints()
-- GameMenuButtonMacros:Point("TOP", showb, "BOTTOM", 0, -1)

-- GameMenuFrame:SetHeight(GameMenuFrame:GetHeight() + showb:GetHeight())


-- showb:SetScript("OnClick", function()
-- PlaySound("igMainMenuOption")
-- HideUIPanel(GameMenuFrame)
-- addonBG:Show()
-- end)