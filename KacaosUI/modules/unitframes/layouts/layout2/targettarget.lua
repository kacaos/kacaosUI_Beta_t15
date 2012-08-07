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
--------------------
-- size
--------------------
	do
		G.UnitFrames.TargetTarget:Size(80, 12)
		G.UnitFrames.TargetTarget:SetBorder(false, true)
	end
	
end