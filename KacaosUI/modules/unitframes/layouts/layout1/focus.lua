local T, C, L, G = unpack( Tukui )

if( C["unitframes"].enable ~= true ) then return end
if C.unitframes.style ~= 1 then return end
--------------------------------------------------------------
-- Focus
--------------------------------------------------------------
do
	do
		G.UnitFrames.Focus:SetBackdrop( nil )
		G.UnitFrames.Focus:SetBackdropColor( 0, 0, 0 )
		G.UnitFrames.Focus.shadow:Kill()
	end

--------------------------------------------------------------
-- health
--------------------------------------------------------------
	do
		G.UnitFrames.Focus.Health:Size(175, 20)
		G.UnitFrames.Focus.Health:SetStatusBarTexture(C["media"].normTex)
		G.UnitFrames.Focus.Health:SetFrameLevel( 5 )
		G.UnitFrames.Focus.Health:AddBorder()
		G.UnitFrames.Focus.Health.bg:SetTexture( 0.6, 0.6, 0.6 )
		
		if( C["unitframes"].unicolor == true ) then
			G.UnitFrames.Focus.Health.bg:SetVertexColor(unpack(C["unitframes"].healthBgColor))
		end

		G.UnitFrames.Focus.Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		G.UnitFrames.Focus.Name:SetShadowOffset( 1.25, -1.25 )
		G.UnitFrames.Focus.Name:Point( "CENTER", G.UnitFrames.Focus.Health, "CENTER", 0, 1 )

		G.UnitFrames.Focus.Health.value = T.SetFontString( G.UnitFrames.Focus.Health,C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		G.UnitFrames.Focus.Health.value:Point( "RIGHT", G.UnitFrames.Focus.Health, "RIGHT", -4, 1 )
	end

--------------------------------------------------------------
-- power
--------------------------------------------------------------
	do
		G.UnitFrames.Focus.Power:Size( 175, 2 )
		G.UnitFrames.Focus.Power:SetStatusBarTexture(C["media"].normTex)
		G.UnitFrames.Focus.Power:ClearAllPoints()
		G.UnitFrames.Focus.Power:Point( "TOPRIGHT", G.UnitFrames.Focus.Health, "BOTTOMRIGHT", 0, -3 )
		G.UnitFrames.Focus.Power:SetFrameLevel( G.UnitFrames.Focus.Health:GetFrameLevel() + 2 )
		G.UnitFrames.Focus.Power:AddBorder()

		G.UnitFrames.Focus.Power.value = T.SetFontString( G.UnitFrames.Focus.Health,C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		G.UnitFrames.Focus.Power.value:Point( "LEFT", G.UnitFrames.Focus.Health, "LEFT", 4, 1 )
	end

--------------------------------------------------------------
-- castbar
--------------------------------------------------------------
	do
		if( C["unitframes"].unitcastbar == true ) then
			G.UnitFrames.Focus.Castbar:ClearAllPoints()
			G.UnitFrames.Focus.Castbar:SetHeight( 9 )
			G.UnitFrames.Focus.Castbar:Point( "TOPLEFT", G.UnitFrames.Focus, "BOTTOMLEFT", 0, -9 )
			G.UnitFrames.Focus.Castbar:AddBorder()

			G.UnitFrames.Focus.Castbar.bg:Kill()

			G.UnitFrames.Focus.Castbar.bg = G.UnitFrames.Focus.Castbar:CreateTexture( nil, "BORDER" )
			G.UnitFrames.Focus.Castbar.bg:SetAllPoints( G.UnitFrames.Focus.Castbar )
			G.UnitFrames.Focus.Castbar.bg:SetTexture( C["media"].normTex)
			G.UnitFrames.Focus.Castbar.bg:SetVertexColor( 0.05, 0.05, 0.05 )

			G.UnitFrames.Focus.Castbar.Time = T.SetFontString( G.UnitFrames.Focus.Castbar,C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			G.UnitFrames.Focus.Castbar.Time:Point( "RIGHT", G.UnitFrames.Focus.Castbar, "RIGHT", -4, 0)
			G.UnitFrames.Focus.Castbar.Time:SetShadowOffset(0,0)
			
			G.UnitFrames.Focus.Castbar.Text = T.SetFontString( G.UnitFrames.Focus.Castbar,C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			G.UnitFrames.Focus.Castbar.Text:Point( "LEFT", G.UnitFrames.Focus.Castbar, "LEFT", 4, 0)
			G.UnitFrames.Focus.Castbar.Text:SetShadowOffset(0,0)

			G.UnitFrames.Focus.Castbar.PostCastStart = T.PostCastStart
			G.UnitFrames.Focus.Castbar.PostChannelStart = T.PostCastStart

			G.UnitFrames.Focus.Castbar:Width(175)
			G.UnitFrames.Focus.Castbar.button:Kill()
		end
	end

--------------------------------------------------------------
-- buffs, debuffs
--------------------------------------------------------------
	do
		G.UnitFrames.Focus.Debuffs:SetHeight(27)
		G.UnitFrames.Focus.Debuffs:SetWidth(175)
		G.UnitFrames.Focus.Debuffs.size = 27
		G.UnitFrames.Focus.Debuffs.num = 3
		G.UnitFrames.Focus.Debuffs.spacing = 1

		G.UnitFrames.Focus.Debuffs:ClearAllPoints()
		G.UnitFrames.Focus.Debuffs:Point( "TOPLEFT", G.UnitFrames.Focus.Health, "TOPRIGHT", 3, 1)
		G.UnitFrames.Focus.Debuffs.ClearAllPoints = T.dummy
		G.UnitFrames.Focus.Debuffs.SetPoint = T.dummy

		G.UnitFrames.Focus.Debuffs.initialAnchor = "LEFT"
		G.UnitFrames.Focus.Debuffs["growth-x"] = "RIGHT"

		if( G.UnitFrames.Focus.Debuffs ) then
			for _, frames in pairs( { G.UnitFrames.Focus.Debuffs } ) do
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
		G.UnitFrames.Focus:Size( 175, 20 )
	end
end