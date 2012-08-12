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
		
		if( C["unitframes"].unicolor == true ) then
			G.UnitFrames["Boss"..i].Health.bg:SetVertexColor(unpack(C["unitframes"].healthBgColor))
		end

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
					G.UnitFrames["Boss"..i].Castbar.button:Point("BOTTOMLEFT", G.UnitFrames["Boss"..i].Castbar, "BOTTOMRIGHT", 5, -1)
					G.UnitFrames["Boss"..i].Castbar.button:SetTemplate()
					G.UnitFrames["Boss"..i].Castbar.button:CreateBorder(false, true)
					G.UnitFrames["Boss"..i].Castbar.button:Size(28)
					G.UnitFrames["Boss"..i].Castbar.icon:Point("TOPLEFT", G.UnitFrames["Boss"..i].Castbar.button, 0, -0)
					G.UnitFrames["Boss"..i].Castbar.icon:Point("BOTTOMRIGHT", G.UnitFrames["Boss"..i].Castbar.button, -0, 0)
				else
					G.UnitFrames["Boss"..i].Castbar.button:Kill()
				end
			end
		end

--------------------------------------------------------------
-- buffs, debuffs
--------------------------------------------------------------
		do
			G.UnitFrames["Boss" .. i].Debuffs:SetHeight(19)
			G.UnitFrames["Boss" .. i].Debuffs:SetWidth(200)
			G.UnitFrames["Boss" .. i].Debuffs.size = 19
			G.UnitFrames["Boss" .. i].Debuffs.num = 3
			G.UnitFrames["Boss" .. i].Debuffs.spacing = 1

			G.UnitFrames["Boss" .. i].Debuffs:ClearAllPoints()
			G.UnitFrames["Boss" .. i].Debuffs:Point( "LEFT", G.UnitFrames["Boss" .. i], "RIGHT", 3, -3)
			G.UnitFrames["Boss" .. i].Debuffs.ClearAllPoints = T.dummy
			G.UnitFrames["Boss" .. i].Debuffs.SetPoint = T.dummy

			G.UnitFrames["Boss" .. i].Buffs:SetHeight(19)
			G.UnitFrames["Boss" .. i].Buffs:SetWidth(200)
			G.UnitFrames["Boss" .. i].Buffs.size = 19
			G.UnitFrames["Boss" .. i].Buffs.num = 3
			G.UnitFrames["Boss" .. i].Buffs.spacing = 1

			G.UnitFrames["Boss" .. i].Buffs:ClearAllPoints()
			G.UnitFrames["Boss" .. i].Buffs:Point( "RIGHT", G.UnitFrames["Boss" .. i], "LEFT", -3, -3)
			G.UnitFrames["Boss" .. i].Buffs.ClearAllPoints = T.dummy
			G.UnitFrames["Boss" .. i].Buffs.SetPoint = T.dummy

			G.UnitFrames["Boss" .. i].Debuffs.initialAnchor = "LEFT"
			G.UnitFrames["Boss" .. i].Debuffs["growth-x"] = "RIGHT"

			G.UnitFrames["Boss" .. i].Buffs.initialAnchor = "RIGHT"
			G.UnitFrames["Boss" .. i].Buffs["growth-x"] = "LEFT"

			if( G.UnitFrames["Boss" .. i].Debuffs or G.UnitFrames["Boss" .. i].Buffs ) then
				for _, frames in pairs( { G.UnitFrames["Boss" .. i].Debuffs, G.UnitFrames["Boss" .. i].Buffs } ) do
					if( not frames ) then return end

					frames:Size(200, 19)
					frames.size = 19
					frames.num = 3

					hooksecurefunc( frames, "PostCreateIcon", T.SkinAura )
				end
			end
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