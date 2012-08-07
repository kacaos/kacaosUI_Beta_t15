local T, C, L, G = unpack(Tukui)
if not C.unitframes.enable == true then return end
if C.unitframes.style ~= 2 then return end

--------------------------------------------------------------
-- Boss
--------------------------------------------------------------

do
	for i = 1, MAX_BOSS_FRAMES do
		do
			G.UnitFrames["Boss"..i]:SetBackdrop(nil)
			G.UnitFrames["Boss"..i]:SetBackdropColor(0, 0, 0)
			G.UnitFrames["Boss"..i].shadow:Kill()
		end

--------------------------------------------------------------
-- health
--------------------------------------------------------------
		do
			G.UnitFrames["Boss"..i].Health:Size(200, 12)
			G.UnitFrames["Boss"..i].Health:SetStatusBarTexture(C["media"].normTex)
			G.UnitFrames["Boss"..i].Health:SetFrameLevel(5)
			G.UnitFrames["Boss"..i].Health:CreateBorder(false, true) 
			G.UnitFrames["Boss"..i].Health.bg:SetTexture(0.6, 0.6, 0.6)

			G.UnitFrames["Boss"..i].Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			G.UnitFrames["Boss"..i].Name:SetShadowOffset(1.25, -1.25)
			G.UnitFrames["Boss"..i].Name:Point("LEFT", G.UnitFrames["Boss" .. i].Health, 3, 0)

			G.UnitFrames["Boss"..i].Health.value = T.SetFontString(G.UnitFrames["Boss"..i].Health,C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			G.UnitFrames["Boss"..i].Health.value:Point("RIGHT", G.UnitFrames["Boss"..i].Health)
		end
--------------------------------------------------------------
-- power
--------------------------------------------------------------
		do
			G.UnitFrames["Boss"..i].Power:Size(200, 2)
			G.UnitFrames["Boss"..i].Power:SetStatusBarTexture(C["media"].normTex)
			G.UnitFrames["Boss"..i].Power:ClearAllPoints()
			G.UnitFrames["Boss"..i].Power:Point("BOTTOM", G.UnitFrames["Boss"..i].Health, 0, -5)
			G.UnitFrames["Boss"..i].Power:SetFrameLevel( G.UnitFrames["Boss"..i].Health:GetFrameLevel() + 2)
			G.UnitFrames["Boss"..i].Power:CreateBorder(false, true)

			G.UnitFrames["Boss"..i].Power.value:Kill()
		end
--------------------------------------------------------------
-- castbar
---------------------------------------------------------------
		do
			if( C["unitframes"].unitcastbar == true ) then
				G.UnitFrames["Boss"..i].Castbar:ClearAllPoints()
				G.UnitFrames["Boss"..i].Castbar:SetHeight(6)
				G.UnitFrames["Boss"..i].Castbar:SetWidth(200)
				G.UnitFrames["Boss"..i].Castbar:Point("BOTTOM", G.UnitFrames["Boss"..i].Health, 0, -15)
				G.UnitFrames["Boss"..i].Castbar:CreateBorder(false, true)

				G.UnitFrames["Boss"..i].Castbar.Time:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
				--G.UnitFrames["Boss"..i].Castbar.Time:Point("RIGHT", G.UnitFrames["Boss"..i].Castbar, "RIGHT", -2, 1 )

				G.UnitFrames["Boss"..i].Castbar.Text:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
				--G.UnitFrames["Boss"..i].Castbar.Text:Point("LEFT", G.UnitFrames["Boss"..i].Castbar, "LEFT", 2, 1)

				G.UnitFrames["Boss"..i].Castbar.PostCastStart = T.PostCastStart
				G.UnitFrames["Boss"..i].Castbar.PostChannelStart = T.PostCastStart

				if(C["unitframes"].cbicons == true) then
					G.UnitFrames["Boss"..i].Castbar.button:ClearAllPoints()
					G.UnitFrames["Boss"..i].Castbar.button:SetPoint("LEFT", G.UnitFrames["Boss" .. i], "RIGHT", 5, -8)
					G.UnitFrames["Boss"..i].Castbar.button:Size(29)
					G.UnitFrames["Boss"..i].Castbar.button:SetTemplate("Default")
					G.UnitFrames["Boss"..i].Castbar.button:CreateBorder(false, true)
					
					G.UnitFrames["Boss"..i].Castbar.icon:SetPoint("TOPLEFT", G.UnitFrames["Boss" .. i].Castbar.button, 0, 0)
					G.UnitFrames["Boss"..i].Castbar.icon:SetPoint("TOPLEFT", G.UnitFrames["Boss" .. i].Castbar.button, 0, 0)
				else
					G.UnitFrames["Boss"..i].Castbar.button:Kill()
				end
			end
		end

--------------------------------------------------------------
-- buffs, debuffs
--------------------------------------------------------------
		do
			G.UnitFrames["Boss"..i].Debuffs:Kill()

			G.UnitFrames["Boss"..i].Buffs:Kill()

		end

--------------------------------------------------------------
-- altpowerbar
--------------------------------------------------------------
		do
			G.UnitFrames["Boss"..i].AltPowerBar:SetStatusBarTexture(C["media"].normTex)
		end

		------------------------------
		-- size
		------------------------------
		do
			G.UnitFrames["Boss"..i]:Size(200, 12)
		end
	end
end