local T, C, L, G = unpack(Tukui)
if not C.unitframes.enable == true then return end
if not C.unitframes.showfocustarget == true then return end
if C.unitframes.style ~= 2 then return end

--------------------------------------------------------------
-- Focus
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
		G.UnitFrames.FocusTarget.Health:Height(12)
		G.UnitFrames.FocusTarget.Health:SetFrameLevel(5)
		G.UnitFrames.FocusTarget.Health:CreateBorder(false, true)
		G.UnitFrames.FocusTarget.Health.bg:SetTexture( 0.6, 0.6, 0.6 )
		
		if( C["unitframes"].unicolor == true ) then
			G.UnitFrames.FocusTarget.Health.bg:SetVertexColor(unpack(C["unitframes"].healthBgColor))
		end
		
		G.UnitFrames.FocusTarget.Health.value:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		G.UnitFrames.FocusTarget.Health.value:SetShadowOffset(0,0)
	end
	
--------------------------------------------------------------
-- power
--------------------------------------------------------------
	do
		G.UnitFrames.FocusTarget.Power:ClearAllPoints()
		G.UnitFrames.FocusTarget.Power:Point("BOTTOM", G.UnitFrames.FocusTarget.Health, 0, -4)
		G.UnitFrames.FocusTarget.Power:Height(1)
		G.UnitFrames.FocusTarget.Power:Width(200)
		G.UnitFrames.FocusTarget.Power:SetFrameLevel(3)
		G.UnitFrames.FocusTarget.Power:SetBorder(false, true)
		
		G.UnitFrames.FocusTarget.Power.value:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		G.UnitFrames.FocusTarget.Power.value:SetShadowOffset(0,0)
	end
	
--------------------------------------------------------------
-- power
--------------------------------------------------------------
	do
		G.UnitFrames.FocusTarget.Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		G.UnitFrames.FocusTarget.Name:SetShadowOffset(0,0)
		G.UnitFrames.FocusTarget.Name:ClearAllPoints()
		G.UnitFrames.FocusTarget.Name:Point("CENTER", G.UnitFrames.FocusTarget.Health, 0, -1)
	end
	
--------------------------------------------------------------
-- castbar
--------------------------------------------------------------
	do
		if( C["unitframes"].unitcastbar == true) then
			G.UnitFrames.FocusTarget.Castbar:ClearAllPoints()
			G.UnitFrames.FocusTarget.Castbar:Point("LEFT", G.UnitFrames.FocusTarget.Health, 0, -18)
			G.UnitFrames.FocusTarget.Castbar:Height(6)
			G.UnitFrames.FocusTarget.Castbar:Width(200)
			G.UnitFrames.FocusTarget.Castbar:SetTemplate("Transparent")
			G.UnitFrames.FocusTarget.Castbar:CreateBorder(false, true)
			
			G.UnitFrames.FocusTarget.Castbar.Time:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			G.UnitFrames.FocusTarget.Castbar.Time:SetShadowOffset(0,0)
			
			G.UnitFrames.FocusTarget.Castbar.Text:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			G.UnitFrames.FocusTarget.Castbar.Text:SetShadowOffset(0,0)
		end
		
		if C.unitframes.cbicons == true then
			G.UnitFrames.FocusTarget.Castbar.button:ClearAllPoints()
			G.UnitFrames.FocusTarget.Castbar.button:Size(29)
			G.UnitFrames.FocusTarget.Castbar.button:CreateBorder(false, true)
			G.UnitFrames.FocusTarget.Castbar.button:SetTemplate()
			G.UnitFrames.FocusTarget.Castbar.button:Point("LEFT", G.UnitFrames.FocusTarget, "RIGHT", 5, -8)
			G.UnitFrames.FocusTarget.Castbar.icon:Point("TOPLEFT", G.UnitFrames.FocusTarget.Castbar.button, 0, -0)
			G.UnitFrames.FocusTarget.Castbar.icon:Point("BOTTOMRIGHT",G.UnitFrames.FocusTarget.Castbar.button, -0, 0)
		else
			G.UnitFrames.FocusTarget.Castbar.button:Kill()
		end
		
		G.UnitFrames.FocusTarget.Castbar.CustomTimeText = T.CustomCastTimeText
	    G.UnitFrames.FocusTarget.Castbar.CustomDelayText = T.CustomCastDelayText
        G.UnitFrames.FocusTarget.Castbar.PostCastStart = T.PostCastStart
        G.UnitFrames.FocusTarget.Castbar.PostChannelStart = T.PostCastStart
	end

--------------------------------------------------------------
-- buffs & debuffs
--------------------------------------------------------------
	do
		G.UnitFrames.FocusTarget.Debuffs:SetHeight(19)
		G.UnitFrames.FocusTarget.Debuffs:SetWidth(200)
		G.UnitFrames.FocusTarget.Debuffs.size = 19
		G.UnitFrames.FocusTarget.Debuffs.num = 3
		G.UnitFrames.FocusTarget.Debuffs.spacing = 1

		G.UnitFrames.FocusTarget.Debuffs:ClearAllPoints()
		G.UnitFrames.FocusTarget.Debuffs:Point( "LEFT", G.UnitFrames.FocusTarget, "RIGHT", 3, -2)
		G.UnitFrames.FocusTarget.Debuffs.ClearAllPoints = T.dummy
		G.UnitFrames.FocusTarget.Debuffs.SetPoint = T.dummy

		G.UnitFrames.FocusTarget.Debuffs.initialAnchor = "LEFT"
		G.UnitFrames.FocusTarget.Debuffs["growth-x"] = "RIGHT"

		if( G.UnitFrames.FocusTarget.Debuffs ) then
			for _, frames in pairs( { G.UnitFrames.FocusTarget.Debuffs } ) do
				if( not frames ) then return end

				frames:Size(200, 19)
				frames.size = 19
				frames.num = 3

				hooksecurefunc( frames, "PostCreateIcon", T.SkinAura )
			end
		end
	end
	
--------------------------------------------------------------
-- size
--------------------------------------------------------------
	do
		G.UnitFrames.FocusTarget:Size(200, 12)
	end
end