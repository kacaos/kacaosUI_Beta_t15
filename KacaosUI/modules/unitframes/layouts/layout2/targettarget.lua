local T, C, L, G = unpack(Tukui)
if not C.unitframes.enable == true then return end
if C.unitframes.style ~= 2 then return end

--------------------------------------------------------------
-- Target of Target
--------------------------------------------------------------
do
	do
		G.UnitFrames.TargetTarget.shadow:Kill()
		G.UnitFrames.TargetTarget.panel:Kill()
	end
	
--------------------------------------------------------------
-- health
--------------------------------------------------------------
	do
		G.UnitFrames.TargetTarget.Health:Height(12)
		G.UnitFrames.TargetTarget.Health:SetTemplate("Default")
		G.UnitFrames.TargetTarget.Health.bg:SetTexture( 0.6, 0.6, 0.6 )
		
		if( C["unitframes"].unicolor == true ) then
			G.UnitFrames.TargetTarget.Health.bg:SetVertexColor(unpack(C["unitframes"].healthBgColor))
		end
	end

--------------------------------------------------------------
-- name
--------------------------------------------------------------	
	do
		G.UnitFrames.TargetTarget.Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		G.UnitFrames.TargetTarget.Name:SetShadowOffset(0,0)
		G.UnitFrames.TargetTarget.Name:SetParent(G.UnitFrames.TargetTarget.Health)
		G.UnitFrames.TargetTarget.Name:ClearAllPoints()
		G.UnitFrames.TargetTarget.Name:SetPoint("CENTER", 0, 0)
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
			G.UnitFrames.TargetTarget.Debuffs:Point("BOTTOMRIGHT", G.UnitFrames.TargetTarget, "TOPRIGHT", 28, 3)
			G.UnitFrames.TargetTarget.Debuffs.ClearAllPoints = T.dummy
			G.UnitFrames.TargetTarget.Debuffs.SetPoint = T.dummy

			G.UnitFrames.TargetTarget.Debuffs.initialAnchor = "BOTTOM"
			G.UnitFrames.TargetTarget.Debuffs["growth-x"] = "LEFT"

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
	
--------------------
-- size
--------------------
	do
		G.UnitFrames.TargetTarget:Size(80, 12)
		G.UnitFrames.TargetTarget:SetBorder(false, true)
	end
	
end