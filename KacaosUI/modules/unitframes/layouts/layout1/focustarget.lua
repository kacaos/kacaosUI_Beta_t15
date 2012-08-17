local T, C, L, G = unpack( Tukui )

if( C["unitframes"].enable ~= true ) then return end
if C.unitframes.style ~= 1 then return end
--------------------------------------------------------------
-- Focus Target
--------------------------------------------------------------
do
	do
		G.UnitFrames.FocusTarget:SetBackdrop( nil )
		G.UnitFrames.FocusTarget:SetBackdropColor( 0, 0, 0 )
		G.UnitFrames.FocusTarget.shadow:Kill()
	end

--------------------------------------------------------------
-- health
--------------------------------------------------------------
	do
		G.UnitFrames.FocusTarget.Health:Size(175, 20)
		G.UnitFrames.FocusTarget.Health:SetStatusBarTexture(C["media"].normTex)
		G.UnitFrames.FocusTarget.Health:SetFrameLevel( 5 )
		G.UnitFrames.FocusTarget.Health:AddBorder()
		G.UnitFrames.FocusTarget.Health.bg:SetTexture( 0.6, 0.6, 0.6 )
		
		if( C["unitframes"].unicolor == true ) then
			G.UnitFrames.FocusTarget.Health.bg:SetVertexColor(unpack(C["unitframes"].healthBgColor))
		end

		G.UnitFrames.FocusTarget.Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		G.UnitFrames.FocusTarget.Name:SetShadowOffset( 1.25, -1.25 )
		G.UnitFrames.FocusTarget.Name:Point( "CENTER", G.UnitFrames.FocusTarget.Health, "CENTER", 0, 1 )

		G.UnitFrames.FocusTarget.Health.value = T.SetFontString( G.UnitFrames.FocusTarget.Health,C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		G.UnitFrames.FocusTarget.Health.value:Point( "RIGHT", G.UnitFrames.FocusTarget.Health, "RIGHT", -4, 1 )
	end

--------------------------------------------------------------
-- power
--------------------------------------------------------------
	do
		G.UnitFrames.FocusTarget.Power:Size( 175, 2 )
		G.UnitFrames.FocusTarget.Power:SetStatusBarTexture(C["media"].normTex)
		G.UnitFrames.FocusTarget.Power:ClearAllPoints()
		G.UnitFrames.FocusTarget.Power:Point( "TOPRIGHT", G.UnitFrames.FocusTarget.Health, "BOTTOMRIGHT", 0, -3 )
		G.UnitFrames.FocusTarget.Power:SetFrameLevel( G.UnitFrames.FocusTarget.Health:GetFrameLevel() + 2 )
		G.UnitFrames.FocusTarget.Power:AddBorder()

		G.UnitFrames.FocusTarget.Power.value = T.SetFontString( G.UnitFrames.FocusTarget.Health,C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		G.UnitFrames.FocusTarget.Power.value:Point( "LEFT", G.UnitFrames.FocusTarget.Health, "LEFT", 4, 1 )
	end

--------------------------------------------------------------
-- castbar
--------------------------------------------------------------
	do
		if( C["unitframes"].unitcastbar == true ) then
			G.UnitFrames.FocusTarget.Castbar:ClearAllPoints()
			G.UnitFrames.FocusTarget.Castbar:SetHeight( 9 )
			G.UnitFrames.FocusTarget.Castbar:Point( "TOPLEFT", G.UnitFrames.FocusTarget, "BOTTOMLEFT", 0, -9 )
			G.UnitFrames.FocusTarget.Castbar:AddBorder()

			G.UnitFrames.FocusTarget.Castbar.Time = T.SetFontString( G.UnitFrames.FocusTarget.Castbar,C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			G.UnitFrames.FocusTarget.Castbar.Time:Point( "RIGHT", G.UnitFrames.FocusTarget.Castbar, "RIGHT", -4, 0)
			G.UnitFrames.FocusTarget.Castbar.Time:SetShadowOffset(0,0)

			G.UnitFrames.FocusTarget.Castbar.Text = T.SetFontString( G.UnitFrames.FocusTarget.Castbar,C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			G.UnitFrames.FocusTarget.Castbar.Text:Point( "LEFT", G.UnitFrames.FocusTarget.Castbar, "LEFT", 4, 0)
			G.UnitFrames.FocusTarget.Castbar.Text:SetShadowOffset(0,0)

			G.UnitFrames.FocusTarget.Castbar.PostCastStart = T.PostCastStart
			G.UnitFrames.FocusTarget.Castbar.PostChannelStart = T.PostCastStart


			G.UnitFrames.FocusTarget.Castbar:Width(175)
			G.UnitFrames.FocusTarget.Castbar.button:Kill()
		end
	end

--------------------------------------------------------------
-- buffs, debuffs
--------------------------------------------------------------
	do
		G.UnitFrames.FocusTarget.Debuffs:SetHeight(27)
		G.UnitFrames.FocusTarget.Debuffs:SetWidth(175)
		G.UnitFrames.FocusTarget.Debuffs.size = 27
		G.UnitFrames.FocusTarget.Debuffs.num = 3
		G.UnitFrames.FocusTarget.Debuffs.spacing = 1

		G.UnitFrames.FocusTarget.Debuffs:ClearAllPoints()
		G.UnitFrames.FocusTarget.Debuffs:Point( "TOPLEFT", G.UnitFrames.FocusTarget.Health, "TOPRIGHT", 3, 1)
		G.UnitFrames.FocusTarget.Debuffs.ClearAllPoints = T.dummy
		G.UnitFrames.FocusTarget.Debuffs.SetPoint = T.dummy

		G.UnitFrames.FocusTarget.Debuffs.initialAnchor = "LEFT"
		G.UnitFrames.FocusTarget.Debuffs["growth-x"] = "RIGHT"

		if( G.UnitFrames.FocusTarget.Debuffs ) then
			for _, frames in pairs( { G.UnitFrames.FocusTarget.Debuffs } ) do
				if( not frames ) then return end

				frames:Size(175, 27)
				frames.size = 27
				frames.num = 3

				hooksecurefunc( frames, "PostCreateIcon", T.SkinAura )
			end
		end
	end

--------------------------------------------------------------
-- size
--------------------------------------------------------------
	do
		G.UnitFrames.FocusTarget:Size( 175, 20 )
	end
end