local T, C, L = unpack(Tukui)
if not C.actionbar.enable == true then return end
if C.actionbar.style ~= 1 then return end

-- Kill backdrop
TukuiPetBar:SetBackdrop(nil)

if C.actionbar.hpetbar == false then
----------------------------------------------------
-- add mover
----------------------------------------------------
	local mover = CreateFrame("Frame", "TukuiPetBarMover", UIParent)
	mover:Width(20)
	mover:Height(100)
	mover:Point("RIGHT", UIParent, -85, -39)
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

------------------------------------------------------
-- move the bar
------------------------------------------------------
	TukuiPetBar:ClearAllPoints()
	TukuiPetBar:SetPoint("LEFT", mover, 0, 0)


else
-----------------------------------------------------
-- make horizontal bar
-----------------------------------------------------
	local bar = TukuiPetBar
	
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
--------------------------------------------------------
--create mover
--------------------------------------------------------
	local mover = CreateFrame("Frame", "TukuiPetBarMover", UIParent)
	mover:Width(100)
	mover:Height(20)
	mover:Point("BOTTOMLEFT", TukuiMinimap, -550, 2)
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
-------------------------------------------------------
-- move the petbar	
-------------------------------------------------------
	TukuiPetBar:ClearAllPoints()
	TukuiPetBar:SetPoint("LEFT", mover, 0, -100)
end