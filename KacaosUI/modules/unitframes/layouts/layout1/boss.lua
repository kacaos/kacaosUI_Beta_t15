local T, C, L, G = unpack( Tukui )

if( C["unitframes"].enable ~= true ) then return end
if C.unitframes.style ~= 1 then return end
--------------------------------------------------------------
-- Boss
--------------------------------------------------------------

do
	for i = 1, MAX_BOSS_FRAMES do
		do
			G.UnitFrames["Boss" .. i]:SetBackdrop( nil )
			G.UnitFrames["Boss" .. i]:SetBackdropColor( 0, 0, 0 )
			G.UnitFrames["Boss" .. i].shadow:Kill()
		end

--------------------------------------------------------------
-- health
--------------------------------------------------------------
		do
			G.UnitFrames["Boss" .. i].Health:Size( 175, 20 )
			G.UnitFrames["Boss" .. i].Health:SetStatusBarTexture(C["media"].normTex)
			G.UnitFrames["Boss" .. i].Health:SetFrameLevel( 5 )
			G.UnitFrames["Boss" .. i].Health:AddBorder()
			G.UnitFrames["Boss" .. i].Health.bg:SetTexture( 0.6, 0.6, 0.6 )

			if( C["unitframes"].unicolor == true ) then
				G.UnitFrames["Boss" .. i].Health.colorTapping = false
				G.UnitFrames["Boss" .. i].Health.colorDisconnected = false
				G.UnitFrames["Boss" .. i].Health.colorClass = false
				G.UnitFrames["Boss" .. i].Health:SetStatusBarColor(.3, .3, .3, 1)
			else
				G.UnitFrames["Boss" .. i].Health.colorDisconnected = true
				G.UnitFrames["Boss" .. i].Health.colorTapping = true
				G.UnitFrames["Boss" .. i].Health.colorClass = true
				G.UnitFrames["Boss" .. i].Health.colorReaction = true
			end

			G.UnitFrames["Boss" .. i].Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			G.UnitFrames["Boss" .. i].Name:SetShadowOffset( 1.25, -1.25 )
			G.UnitFrames["Boss" .. i].Name:Point( "CENTER", G.UnitFrames["Boss" .. i].Health, "CENTER", 0, 0 )

			G.UnitFrames["Boss" .. i].Health.value = T.SetFontString( G.UnitFrames["Boss" .. i].Health, C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			G.UnitFrames["Boss" .. i].Health.value:Point( "RIGHT", G.UnitFrames["Boss" .. i].Health, "RIGHT", -4, 0 )
		end
--------------------------------------------------------------
-- power
--------------------------------------------------------------
		do
			G.UnitFrames["Boss" .. i].Power:Size( 175, 2 )
			G.UnitFrames["Boss" .. i].Power:SetStatusBarTexture(C["media"].normTex)
			G.UnitFrames["Boss" .. i].Power:ClearAllPoints()
			G.UnitFrames["Boss" .. i].Power:Point( "TOPRIGHT", G.UnitFrames["Boss" .. i].Health, "BOTTOMRIGHT", 0, -3 )
			G.UnitFrames["Boss" .. i].Power:SetFrameLevel( G.UnitFrames["Boss" .. i].Health:GetFrameLevel() + 2 )
			G.UnitFrames["Boss" .. i].Power:AddBorder()

			G.UnitFrames["Boss" .. i].Power.value = T.SetFontString( G.UnitFrames["Boss" .. i].Health,C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			G.UnitFrames["Boss" .. i].Power.value:Point( "LEFT", G.UnitFrames["Boss" .. i].Health, "LEFT", 4, 1 )
		end
--------------------------------------------------------------
-- castbar
---------------------------------------------------------------
		do
			if( C["unitframes"].unitcastbar == true ) then
				G.UnitFrames["Boss" .. i].Castbar:ClearAllPoints()
				G.UnitFrames["Boss" .. i].Castbar:SetHeight(9)
				G.UnitFrames["Boss" .. i].Castbar:Point( "TOPRIGHT", G.UnitFrames["Boss" .. i], "BOTTOMRIGHT", 0, -9 )
				G.UnitFrames["Boss" .. i].Castbar:AddBorder()

				G.UnitFrames["Boss" .. i].Castbar.bg:Kill()

				G.UnitFrames["Boss" .. i].Castbar.bg = G.UnitFrames["Boss" .. i].Castbar:CreateTexture( nil, "BORDER" )
				G.UnitFrames["Boss" .. i].Castbar.bg:SetAllPoints( G.UnitFrames["Boss" .. i].Castbar )
				G.UnitFrames["Boss" .. i].Castbar.bg:SetTexture( C["media"].normTex)
				G.UnitFrames["Boss" .. i].Castbar.bg:SetVertexColor( 0.05, 0.05, 0.05 )

				G.UnitFrames["Boss" .. i].Castbar.Time = T.SetFontString( G.UnitFrames["Boss" .. i].Castbar,C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
				G.UnitFrames["Boss" .. i].Castbar.Time:Point( "RIGHT", G.UnitFrames["Boss" .. i].Castbar, "RIGHT", -4, 1 )

				G.UnitFrames["Boss" .. i].Castbar.Text = T.SetFontString( G.UnitFrames["Boss" .. i].Castbar,C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
				G.UnitFrames["Boss" .. i].Castbar.Text:Point( "LEFT", G.UnitFrames["Boss" .. i].Castbar, "LEFT", 4, 1 )

				G.UnitFrames["Boss" .. i].Castbar.PostCastStart = T.PostCastStart
				G.UnitFrames["Boss" .. i].Castbar.PostChannelStart = T.PostCastStart


				G.UnitFrames["Boss" .. i].Castbar:Width(175)
				G.UnitFrames["Boss" .. i].Castbar.button:Kill()
			end
		end

--------------------------------------------------------------
-- buffs, debuffs
--------------------------------------------------------------
		do
			G.UnitFrames["Boss" .. i].Debuffs:SetHeight( 20 )
			G.UnitFrames["Boss" .. i].Debuffs:SetWidth( 175 )
			G.UnitFrames["Boss" .. i].Debuffs.size = 20
			G.UnitFrames["Boss" .. i].Debuffs.num = 5
			G.UnitFrames["Boss" .. i].Debuffs.spacing = 3

			G.UnitFrames["Boss" .. i].Debuffs:ClearAllPoints()
			G.UnitFrames["Boss" .. i].Debuffs:Point( "LEFT", G.UnitFrames["Boss" .. i], "RIGHT", 5, 0 )
			G.UnitFrames["Boss" .. i].Debuffs.ClearAllPoints = T.dummy
			G.UnitFrames["Boss" .. i].Debuffs.SetPoint = T.dummy

			G.UnitFrames["Boss" .. i].Buffs:SetHeight( 20 )
			G.UnitFrames["Boss" .. i].Buffs:SetWidth( 175 )
			G.UnitFrames["Boss" .. i].Buffs.size = 20
			G.UnitFrames["Boss" .. i].Buffs.num = 5
			G.UnitFrames["Boss" .. i].Buffs.spacing = 3

			G.UnitFrames["Boss" .. i].Buffs:ClearAllPoints()
			G.UnitFrames["Boss" .. i].Buffs:Point( "RIGHT", G.UnitFrames["Boss" .. i], "LEFT", -5, 0 )
			G.UnitFrames["Boss" .. i].Buffs.ClearAllPoints = T.dummy
			G.UnitFrames["Boss" .. i].Buffs.SetPoint = T.dummy

			G.UnitFrames["Boss" .. i].Debuffs.initialAnchor = "LEFT"
			G.UnitFrames["Boss" .. i].Debuffs["growth-x"] = "RIGHT"

			G.UnitFrames["Boss" .. i].Buffs.initialAnchor = "RIGHT"
			G.UnitFrames["Boss" .. i].Buffs["growth-x"] = "LEFT"

			if( G.UnitFrames["Boss" .. i].Debuffs or G.UnitFrames["Boss" .. i].Buffs ) then
				for _, frames in pairs( { G.UnitFrames["Boss" .. i].Debuffs, G.UnitFrames["Boss" .. i].Buffs } ) do
					if( not frames ) then return end

					frames:Size( 175, 20 )
					frames.size = 20
					frames.num = 5

					hooksecurefunc( frames, "PostCreateIcon", T.SkinAura )
				end
			end
		end

--------------------------------------------------------------
-- altpowerbar
--------------------------------------------------------------
		do
			G.UnitFrames["Boss" .. i].AltPowerBar:SetStatusBarTexture(C["media"].normTex)
		end

		------------------------------
		-- size
		------------------------------
		do
			G.UnitFrames["Boss" .. i]:Size(175, 20)
		end
	end
end