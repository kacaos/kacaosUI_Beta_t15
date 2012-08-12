local T, C, L, G = unpack( Tukui )

if( C["unitframes"].enable ~= true ) then return end
if C.unitframes.style ~= 1 then return end
if C.unitframes.totshow == false then

		G.UnitFrames.TargetTarget:Hide()
else
--------------------------------------------------------------
-- Target of Target
--------------------------------------------------------------

do
	do
		G.UnitFrames.TargetTarget:SetBackdrop( nil )
		G.UnitFrames.TargetTarget:SetBackdropColor( 0, 0, 0 )
		G.UnitFrames.TargetTarget.shadow:Kill()
		G.UnitFrames.TargetTarget.panel:Kill()
	end

--------------------------------------------------------------
-- health
--------------------------------------------------------------
	do
		G.UnitFrames.TargetTarget.Health:Size( 80, 15 )
		G.UnitFrames.TargetTarget.Health:SetStatusBarTexture(C["media"].normTex)
		G.UnitFrames.TargetTarget.Health:SetFrameLevel( 5 )
		G.UnitFrames.TargetTarget.Health:CreateBorder(false, true)
		G.UnitFrames.TargetTarget.Health.bg:SetTexture( 0.6, 0.6, 0.6 )
		
		if( C["unitframes"].unicolor == true ) then
			G.UnitFrames.TargetTarget.Health.bg:SetVertexColor(unpack(C["unitframes"].healthBgColor))
		end

		G.UnitFrames.TargetTarget.Name:Point("CENTER", 0,0) 
		G.UnitFrames.TargetTarget.Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		G.UnitFrames.TargetTarget.Name:SetShadowOffset( 1.25, -1.25 )
	end
	
--------------------------------------------------------------
-- buffs, debuffs
--------------------------------------------------------------
	do
		if( C["unitframes"].totdebuffs == true ) then
			G.UnitFrames.TargetTarget.Debuffs:SetHeight(25)
			G.UnitFrames.TargetTarget.Debuffs:SetWidth(80)
			G.UnitFrames.TargetTarget.Debuffs.size = 22
			G.UnitFrames.TargetTarget.Debuffs.num = 3
			G.UnitFrames.TargetTarget.Debuffs.spacing = 3

			G.UnitFrames.TargetTarget.Debuffs:ClearAllPoints()
			G.UnitFrames.TargetTarget.Debuffs:Point("TOPRIGHT", G.UnitFrames.TargetTarget, "BOTTOMRIGHT", -29, -3)
			G.UnitFrames.TargetTarget.Debuffs.ClearAllPoints = T.dummy
			G.UnitFrames.TargetTarget.Debuffs.SetPoint = T.dummy

			G.UnitFrames.TargetTarget.Debuffs.initialAnchor = "BOTTOM"
			G.UnitFrames.TargetTarget.Debuffs["growth-x"] = "RIGHT"

			if( G.UnitFrames.TargetTarget.Debuffs ) then
				for _, frames in pairs( { G.UnitFrames.TargetTarget.Debuffs } ) do
					if( not frames ) then return end

					frames:Size(80, 25)
					frames.size = 25
					frames.num = 3

					hooksecurefunc( frames, "PostCreateIcon", T.SkinAura )
				end
			end
		end
	end
	
--------------------------------------------------------------
-- size
--------------------------------------------------------------
	do
		G.UnitFrames.TargetTarget:Size( 80, 15 )
	end
end
end