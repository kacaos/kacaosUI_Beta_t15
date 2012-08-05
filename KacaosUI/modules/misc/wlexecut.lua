local T, C, L, G = unpack(Tukui)
if T.myclass == "WARLOCK" then

---------------------------------------------------------
-- create icon
---------------------------------------------------------
local dummy	= CreateFrame("Frame", "Testdummy", UIParent)
local execut = CreateFrame("Frame", "TukuiExecuteIcon", UIParent)
execut:SetSize(36, 36)
execut:SetPoint("CENTER", UIParent, "CENTER", 0, 95)
execut:SetTemplate("Default")
execut:Hide()
dummy:RegisterEvent("PLAYER_ENTERING_WORLD")
dummy:RegisterEvent("UNIT_HEALTH")
dummy:RegisterEvent("PLAYER_TARGET_CHANGED")

---------------------------------------------------------
-- set icon (spell)
---------------------------------------------------------
local spec = GetSpecialization()
local SPEC_WARLOCK_DEMONOLOGY = SPEC_WARLOCK_DEMONOLOGY
local SPEC_WARLOCK_DESTRUCTION = SPEC_WARLOCK_DESTRUCTION
local SPEC_WARLOCK_AFFLICTION = SPEC_WARLOCK_AFFLICTION
local execute_icon = execut:CreateTexture(nil, "OVERLAY")
execute_icon:SetPoint("TOPLEFT", execut, 1, -1)
execute_icon:SetPoint("BOTTOMRIGHT", execut, -1, 1)
execute_icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

if spec == SPEC_WARLOCK_AFFLICTION then
	execute_icon:SetTexture(select(3, GetSpellInfo(1120)))

elseif spec == SPEC_WARLOCK_DESTRUCTION then
	execute_icon:SetTexture(select(3, GetSpellInfo(17877)))

elseif spec == SPEC_WARLOCK_DEMONOLOGY then
	execute_icon:SetTexture(select(3, GetSpellInfo(6353)))
end

----------------------------------------------------------
-- set % when active
----------------------------------------------------------

--affli
if spec == SPEC_WARLOCK_AFFLICTION then
dummy:SetScript("OnEvent", function(self, event)
	if(event == "UNIT_HEALTH") then
		if UnitIsEnemy("player","target") then
			if not UnitIsDead("target") then
				if (((UnitHealth("target") / UnitHealthMax("target") )*100) < 21) then
					execut:Show()
				else
					execut:Hide()
				end
			end
		end
	elseif(event == "PLAYER_TARGET_CHANGED") then
		execut:Hide()
	end
end)

-- destro
elseif spec == SPEC_WARLOCK_DESTRUCTION then
dummy:SetScript("OnEvent", function(self, event)
	if(event == "UNIT_HEALTH") then
		if UnitIsEnemy("player","target") then
			if not UnitIsDead("target") then
				if (((UnitHealth("target") / UnitHealthMax("target") )*100) < 21) then
					execut:Show()
				else
					execut:Hide()
				end
			end
		end
	elseif(event == "PLAYER_TARGET_CHANGED") then
		execut:Hide()
	end
end)

--demo
elseif spec == SPEC_WARLOCK_DEMONOLOGY then
dummy:SetScript("OnEvent", function(self, event)
	if(event == "UNIT_HEALTH") then
		if UnitIsEnemy("player","target") then
			if not UnitIsDead("target") then
				if (((UnitHealth("target") / UnitHealthMax("target") )*100) < 26) then
					execut:Show()
				else
					execut:Hide()
				end
			end
		end
	elseif(event == "PLAYER_TARGET_CHANGED") then
		execut:Hide()
	end
end)
end
end