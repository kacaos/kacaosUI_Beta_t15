local T, C, L, G = unpack(Tukui)
if not C.unitframes.enable == true then return end
if C.unitframes.style ~= 2 then return end

--------------------------------------------------------------
-- Target of Target
--------------------------------------------------------------
do
	do
		G.UnitFrames.Pet.shadow:Kill()
		G.UnitFrames.Pet.panel:Kill()
	end
	
--------------------------------------------------------------
-- health
--------------------------------------------------------------
	do
		G.UnitFrames.Pet.Health:Height(12)
		G.UnitFrames.Pet.Health:SetTemplate("Default")
		G.UnitFrames.Pet.Health.bg:SetTexture( 0.6, 0.6, 0.6 )
		
		if( C["unitframes"].unicolor == true ) then
			G.UnitFrames.Pet.Health.bg:SetVertexColor(unpack(C["unitframes"].healthBgColor))
		end
	end

--------------------------------------------------------------
-- health
--------------------------------------------------------------
	do
		G.UnitFrames.Pet.Power:Kill()
	end

--------------------------------------------------------------
-- health
--------------------------------------------------------------
	do
		G.UnitFrames.Pet.Castbar:ClearAllPoints()
		G.UnitFrames.Pet.Castbar:SetParent(TukUIHider)
	end
	
--------------------------------------------------------------
-- name
--------------------------------------------------------------	
	do
		G.UnitFrames.Pet.Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		G.UnitFrames.Pet.Name:SetShadowOffset(0,0)
		G.UnitFrames.Pet.Name:SetParent(G.UnitFrames.Pet.Health)
		G.UnitFrames.Pet.Name:ClearAllPoints()
		G.UnitFrames.Pet.Name:SetPoint("CENTER", 0, 0)
	end
--------------------
-- size
--------------------
	do
		G.UnitFrames.Pet:Size(80, 12)
		G.UnitFrames.Pet:SetBorder(false, true)
	end
	
end