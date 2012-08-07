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
		G.UnitFrames.TargetTarget.Health:Size( 60, 15 )
		G.UnitFrames.TargetTarget.Health:SetStatusBarTexture(C["media"].normTex)
		G.UnitFrames.TargetTarget.Health:SetFrameLevel( 5 )
		G.UnitFrames.TargetTarget.Health:CreateBorder(false, true)
		G.UnitFrames.TargetTarget.Health.bg:SetTexture( 0.6, 0.6, 0.6 )

		G.UnitFrames.TargetTarget.Name:Point("CENTER", 0,0) 
		G.UnitFrames.TargetTarget.Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		G.UnitFrames.TargetTarget.Name:SetShadowOffset( 1.25, -1.25 )
	end
--------------------------------------------------------------
-- size
--------------------------------------------------------------
	do
		G.UnitFrames.TargetTarget:Size( 60, 15 )
	end
end
end