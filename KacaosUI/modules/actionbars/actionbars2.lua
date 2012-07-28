local T, C, L = unpack(Tukui)
if not C.actionbar.enable == true then return end
if C.actionbar.style ~= 2 then return end

--move buttons
TukuiBar3Button:ClearAllPoints()
TukuiBar3Button:SetPoint("LEFT", ActionButton6, "RIGHT", 5, 15)
TukuiBar2Button:ClearAllPoints()
TukuiBar2Button:SetPoint("RIGHT", ActionButton1, "LEFT", -5, 15)
TukuiBar3Button.ClearAllPoints = T.dummy
TukuiBar3Button.SetPoint = T.dummy
TukuiBar2Button.ClearAllPoints = T.dummy
TukuiBar2Button.SetPoint = T.dummy

--kill buttons
TukuiBar4Button:Kill()
TukuiBar5ButtonTop:Kill()
TukuiBar5ButtonBottom:Kill()

-- Kill backdrop of bars
TukuiBar2:SetBackdrop(nil)
TukuiBar3:SetBackdrop(nil)
TukuiBar4:SetBackdrop(nil)
TukuiBar5:SetBackdrop(nil)
TukuiBar1:SetBackdrop(nil)
TukuiPetBar:SetBackdrop(nil)

-- sidebar on mouseover
if C.actionbar.sidebar1mouseover then
	TukuiBar5:OnMouseOver("MultiBarRightButton", 12, 0, 1)
else
	TukuiBar5:Show()
end

--move bars
--TukuiBar1:ClearAllPoints()
--TukuiBar1:SetPoint("CENTER", , "CENTER", 0, -230)
TukuiBar5:ClearAllPoints()
TukuiBar5:SetPoint("RIGHT", UIParent, -8, 20)
TukuiBar3:ClearAllPoints()
TukuiBar3:SetPoint("TOPLEFT", ActionButton12, "TOPRIGHT", 10, 3)
TukuiBar2:ClearAllPoints()
TukuiBar2:SetPoint("TOPRIGHT", ActionButton7, "TOPLEFT", -10, 3)

-- kill some buttons for bar4
TukuiBar4:Kill()


--------------------------------------------------------------
-- make tukuibar1 2x6
--------------------------------------------------------------
local bar = TukuiBar1
--[[
Bonus bar classes id

DRUID: Caster: 0, Cat: 1, Tree of Life: 0, Bear: 3, Moonkin: 4
WARRIOR: Battle Stance: 1, Defensive Stance: 2, Berserker Stance: 3
ROGUE: Normal: 0, Stealthed: 1
PRIEST: Normal: 0, Shadowform: 1

When Possessing a Target: 5
]]--

local shd = 7
if C.actionbar.ownshdbar then shd = 10 end

local Page = {
["DRUID"] = "[bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 8; [bonusbar:2] 8; [bonusbar:3] 9; [bonusbar:4] 10;",
["WARRIOR"] = "[bonusbar:1] 7; [bonusbar:2] 8; [bonusbar:3] 9;",
["PRIEST"] = "[bonusbar:1] 7;",
["ROGUE"] = "[bonusbar:1] 7; [form:3] "..shd..";",
["DEFAULT"] = "[bonusbar:5] 11; [bar:2] 2; [bar:3] 3; [bar:4] 4; [bar:5] 5; [bar:6] 6;",
}

local function GetBar()
local condition = Page["DEFAULT"]
local class = T.myclass
local page = Page[class]
if page then
condition = condition.." "..page
end
condition = condition.." 1"
return condition
end

bar:RegisterEvent("PLAYER_LOGIN")
bar:RegisterEvent("PLAYER_ENTERING_WORLD")
bar:RegisterEvent("KNOWN_CURRENCY_TYPES_UPDATE")
bar:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
bar:RegisterEvent("BAG_UPDATE")
bar:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
bar:SetScript("OnEvent", function(self, event, ...)
if event == "PLAYER_LOGIN" then
local button
for i = 1, NUM_ACTIONBAR_BUTTONS do
button = _G["ActionButton"..i]
self:SetFrameRef("ActionButton"..i, button)
end

self:Execute([[
buttons = table.new()
for i = 1, 12 do
table.insert(buttons, self:GetFrameRef("ActionButton"..i))
end
]])

self:SetAttribute("_onstate-page", [[
for i, button in ipairs(buttons) do
button:SetAttribute("actionpage", tonumber(newstate))
end
]])

RegisterStateDriver(self, "page", GetBar())
elseif event == "PLAYER_ENTERING_WORLD" then
if T.toc < 40200 then MainMenuBar_UpdateKeyRing() end

local button
for i = 1, 12 do
button = _G["ActionButton"..i]
button:SetSize(T.buttonsize, T.buttonsize)
button:ClearAllPoints()
button:SetParent(bar)
button:SetFrameStrata("BACKGROUND")
button:SetFrameLevel(15)
if i == 1 then
button:SetPoint("BOTTOMLEFT", T.buttonspacing, 0)
elseif i == 7 then
button:SetPoint("BOTTOMLEFT", bar, T.buttonspacing, (T.buttonsize+T.buttonspacing))
else
local previous = _G["ActionButton"..i-1]
button:SetPoint("LEFT", previous, "RIGHT", T.buttonspacing, 0)
end
end
elseif event == "ACTIVE_TALENT_GROUP_CHANGED" then
-- attempt to fix blocked glyph change after switching spec.
LoadAddOn("Blizzard_GlyphUI")
else
MainMenuBar_OnEvent(self, event, ...)
end
end)

---------------------------------------------------------------------------
-- setup PetActionBar
---------------------------------------------------------------------------

if C.actionbar.hpetbar == false then

local mover = CreateFrame("Frame", "TukuiPetBarMover", UIParent)
mover:Width(20)
mover:Height(100)
mover:Point("RIGHT", UIParent, -35, -30)
mover:SetTemplate("Transparent")
mover:SetBackdropBorderColor(0,1,0)
mover:SetClampedToScreen(true)
mover:SetMovable(true)
mover:SetFrameStrata("HIGH")
mover:Hide()
mover:FontString("Text", C.media.font, 12)
mover.Text:SetPoint("CENTER", TukuiPetBarMover, "CENTER", 0, 0)
mover.Text:SetText(L.mover_petbar)
tinsert(T.AllowFrameMoving, mover)
TukuiPetBar:ClearAllPoints()
TukuiPetBar:SetPoint("LEFT", mover, 0, 0)

else

local bar = TukuiPetBar
bar:SetAlpha(0.8)
	
bar:RegisterEvent("PLAYER_LOGIN")
bar:RegisterEvent("PLAYER_CONTROL_LOST")
bar:RegisterEvent("PLAYER_CONTROL_GAINED")
bar:RegisterEvent("PLAYER_ENTERING_WORLD")
bar:RegisterEvent("PLAYER_FARSIGHT_FOCUS_CHANGED")
bar:RegisterEvent("PET_BAR_UPDATE")
bar:RegisterEvent("PET_BAR_UPDATE_USABLE")
bar:RegisterEvent("PET_BAR_UPDATE_COOLDOWN")
bar:RegisterEvent("PET_BAR_HIDE")
bar:RegisterEvent("UNIT_PET")
bar:RegisterEvent("UNIT_FLAGS")
bar:RegisterEvent("UNIT_AURA")
bar:SetScript("OnEvent", function(self, event, arg1)
	if event == "PLAYER_LOGIN" then	
		-- bug reported by Affli on t12 BETA
		PetActionBarFrame.showgrid = 1 -- hack to never hide pet button. :X
		
		local button		
		for i = 1, 10 do
			button = _G["PetActionButton"..i]
			button:ClearAllPoints()
			button:SetParent(TukuiPetBar)

			button:SetSize(T.petbuttonsize, T.petbuttonsize)
			if i == 1 then
				if C.actionbar.bgPanel then
					button:SetPoint("TOPLEFT", T.petbuttonspacing, -T.petbuttonspacing)
				else
					button:SetPoint("TOPLEFT")
				end
			else
				button:SetPoint("LEFT", _G["PetActionButton"..(i - 1)], "RIGHT", T.buttonspacing, 0)
			end
			button:Show()
			self:SetAttribute("addchild", button)
		end
		RegisterStateDriver(self, "visibility", "[pet,novehicleui,nobonusbar:5] show; hide")
		hooksecurefunc("PetActionBar_Update", T.PetBarUpdate)
	elseif event == "PET_BAR_UPDATE" or event == "UNIT_PET" and arg1 == "player" 
	or event == "PLAYER_CONTROL_LOST" or event == "PLAYER_CONTROL_GAINED" or event == "PLAYER_FARSIGHT_FOCUS_CHANGED" or event == "UNIT_FLAGS"
	or arg1 == "pet" and (event == "UNIT_AURA") then
		T.PetBarUpdate()
	elseif event == "PET_BAR_UPDATE_COOLDOWN" then
		PetActionBar_UpdateCooldowns()
	else
		T.StylePet()
	end
end)

local mover = CreateFrame("Frame", "TukuiPetBarMover", UIParent)
mover:Width(100)
mover:Height(20)
mover:Point("BOTTOMLEFT", UIParent, 70, 130)
mover:SetTemplate("Transparent")
mover:SetBackdropBorderColor(0,1,0)
mover:SetClampedToScreen(true)
mover:SetMovable(true)
mover:SetFrameStrata("HIGH")
mover:Hide()
mover:FontString("Text", C.media.font, 12)
mover.Text:SetPoint("CENTER", TukuiPetBarMover, "CENTER", 0, 0)
mover.Text:SetText(L.mover_petbar)
tinsert(T.AllowFrameMoving, mover)
TukuiPetBar:ClearAllPoints()
TukuiPetBar:SetPoint("LEFT", mover, 0, -100)
end

-----------------------------------------------------
-- add movers to actionbars
-----------------------------------------------------

--bar 1 mover
local mover = CreateFrame("Frame", "TukuiBar1Mover", UIParent)
mover:Width(162)
mover:Height(51)
mover:Point("CENTER", UIParent, "CENTER", 0, -210)
mover:SetTemplate("Transparent")
mover:SetBackdropBorderColor(0,1,0)
mover:SetClampedToScreen(true)
mover:SetMovable(true)
mover:SetFrameStrata("HIGH")
mover:Hide()
mover:FontString("Text", C.media.font, 12)
mover.Text:SetPoint("CENTER", TukuiBar1Mover, "CENTER", 0, 0)
mover.Text:SetText(L.mover_bar1)
tinsert(T.AllowFrameMoving, mover)
TukuiBar1:ClearAllPoints()
TukuiBar1:SetPoint("BOTTOMLEFT", mover, 0, 0)

--bar 5 mover
local mover = CreateFrame("Frame", "TukuiBar5Mover", UIParent)
mover:Width(27)
mover:Height(324)
mover:Point("RIGHT", UIParent, -8, 20)
mover:SetTemplate("Transparent")
mover:SetBackdropBorderColor(0,1,0)
mover:SetClampedToScreen(true)
mover:SetMovable(true)
mover:SetFrameStrata("HIGH")
mover:Hide()
mover:FontString("Text", C.media.font, 12)
mover.Text:SetPoint("CENTER", TukuiBar5Mover, "CENTER", 0, 0)
mover.Text:SetText(L.mover_bar5)
tinsert(T.AllowFrameMoving, mover)
TukuiBar5:ClearAllPoints()
TukuiBar5:SetPoint("LEFT", mover, 0, 0)
