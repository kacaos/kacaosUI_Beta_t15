local T, C, L, G = unpack(Tukui)
if not C.unitframes.enable == true then return end
if C.unitframes.style ~= 2 then return end

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
		G.UnitFrames.Focus.Health:Height(12)
		G.UnitFrames.Focus.Health:SetFrameLevel(5)
		G.UnitFrames.Focus.Health:CreateBorder(false, true)
		G.UnitFrames.Focus.Health.bg:SetTexture( 0.6, 0.6, 0.6 )
		
		if( C["unitframes"].unicolor == true ) then
			G.UnitFrames.Focus.Health.bg:SetVertexColor(unpack(C["unitframes"].healthBgColor))
		end
		
		G.UnitFrames.Focus.Health.value:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		G.UnitFrames.Focus.Health.value:SetShadowOffset(0,0)
	end
	
--------------------------------------------------------------
-- power
--------------------------------------------------------------
	do
		G.UnitFrames.Focus.Power:ClearAllPoints()
		G.UnitFrames.Focus.Power:Point("BOTTOM", G.UnitFrames.Focus.Health, 0, -4)
		G.UnitFrames.Focus.Power:Height(1)
		G.UnitFrames.Focus.Power:Width(200)
		G.UnitFrames.Focus.Power:SetFrameLevel(3)
		G.UnitFrames.Focus.Power:SetBorder(false, true)
		
		G.UnitFrames.Focus.Power.value:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		G.UnitFrames.Focus.Power.value:SetShadowOffset(0,0)
	end
	
--------------------------------------------------------------
-- power
--------------------------------------------------------------
	do
		G.UnitFrames.Focus.Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		G.UnitFrames.Focus.Name:SetShadowOffset(0,0)
		G.UnitFrames.Focus.Name:ClearAllPoints()
		G.UnitFrames.Focus.Name:Point("CENTER", G.UnitFrames.Focus.Health, 0, -1)
	end
	
--------------------------------------------------------------
-- castbar
--------------------------------------------------------------
	do
		if( C["unitframes"].unitcastbar == true) then
			G.UnitFrames.Focus.Castbar:ClearAllPoints()
			G.UnitFrames.Focus.Castbar:Point("LEFT", G.UnitFrames.Focus.Health, 0, -18)
			G.UnitFrames.Focus.Castbar:Height(6)
			G.UnitFrames.Focus.Castbar:Width(200)
			G.UnitFrames.Focus.Castbar:SetTemplate("Transparent")
			G.UnitFrames.Focus.Castbar:CreateBorder(false, true)
			
			G.UnitFrames.Focus.Castbar.Time:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			G.UnitFrames.Focus.Castbar.Time:SetShadowOffset(0,0)
			
			G.UnitFrames.Focus.Castbar.Text:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			G.UnitFrames.Focus.Castbar.Text:SetShadowOffset(0,0)
		end
		
		if C.unitframes.cbicons == true then
			G.UnitFrames.Focus.Castbar.button:ClearAllPoints()
			G.UnitFrames.Focus.Castbar.button:Size(29)
			G.UnitFrames.Focus.Castbar.button:CreateBorder(false, true)
			G.UnitFrames.Focus.Castbar.button:SetTemplate()
			G.UnitFrames.Focus.Castbar.button:Point("LEFT", G.UnitFrames.Focus, "RIGHT", 5, -8)
			G.UnitFrames.Focus.Castbar.icon:Point("TOPLEFT", G.UnitFrames.Focus.Castbar.button, 0, -0)
			G.UnitFrames.Focus.Castbar.icon:Point("BOTTOMRIGHT", G.UnitFrames.Focus.Castbar.button, -0, 0)
		else
			G.UnitFrames.Focus.Castbar.button:Kill()
		end
		
		G.UnitFrames.Focus.Castbar.CustomTimeText = T.CustomCastTimeText
	    G.UnitFrames.Focus.Castbar.CustomDelayText = T.CustomCastDelayText
        G.UnitFrames.Focus.Castbar.PostCastStart = T.PostCastStart
        G.UnitFrames.Focus.Castbar.PostChannelStart = T.PostCastStart
	end

--------------------------------------------------------------
-- buffs & debuffs
--------------------------------------------------------------
	do
		G.UnitFrames.Focus.Debuffs:SetHeight(18)
		G.UnitFrames.Focus.Debuffs:SetWidth(200)
		G.UnitFrames.Focus.Debuffs.size = 18
		G.UnitFrames.Focus.Debuffs.num = 3
		G.UnitFrames.Focus.Debuffs.spacing = 1

		G.UnitFrames.Focus.Debuffs:ClearAllPoints()
		G.UnitFrames.Focus.Debuffs:Point( "LEFT", G.UnitFrames.Focus, "RIGHT", 3, -2)
		G.UnitFrames.Focus.Debuffs.ClearAllPoints = T.dummy
		G.UnitFrames.Focus.Debuffs.SetPoint = T.dummy

		G.UnitFrames.Focus.Debuffs.initialAnchor = "LEFT"
		G.UnitFrames.Focus.Debuffs["growth-x"] = "RIGHT"

		if( G.UnitFrames.Focus.Debuffs ) then
			for _, frames in pairs( { G.UnitFrames.Focus.Debuffs } ) do
				if( not frames ) then return end

				frames:Size(200, 18)
				frames.size = 18
				frames.num = 3

				hooksecurefunc( frames, "PostCreateIcon", T.SkinAura )
			end
		end
	end
	
--------------------------------------------------------------
-- size
--------------------------------------------------------------
	do
		G.UnitFrames.Focus:Size(200, 12)
	end
end