local T, C, L, G = unpack(Tukui)
if T.myclass == "Warlock" then
local dummy	= CreateFrame("Frame", "Testdummy", UIParent)

local execut = CreateFrame("Frame", "TukuiExecuteIcon", UIParent)
execut:SetSize(36, 36)
execut:SetPoint("CENTER", UIParent, "CENTER", -50, -50)
execut:SetTemplate("Default")
execut:Hide()
dummy:RegisterEvent("PLAYER_ENTERING_WORLD")
dummy:RegisterEvent("UNIT_HEALTH")
dummy:RegisterEvent("PLAYER_TARGET_CHANGED")

local execute_icon = execut:CreateTexture(nil, "OVERLAY")
execute_icon:SetTexture(select(3, GetSpellInfo(1120)))
execute_icon:SetPoint("TOPLEFT", execut, 1, -1)
execute_icon:SetPoint("BOTTOMRIGHT", execut, -1, 1)
execute_icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

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
end