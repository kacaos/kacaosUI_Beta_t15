local T, C, L, G = unpack(Tukui)
if not C.unitframes.enable == true then return end


--------------------------------------------------------------
-- target name
--------------------------------------------------------------
	G.UnitFrames.Target:Tag(G.UnitFrames.Target.Name, "[Tukui:getnamecolor][Tukui:nameshort] [Tukui:diffcolor][level]")

--------------------------------------------------------------
-- pet name
--------------------------------------------------------------
	G.UnitFrames.Pet:Tag(G.UnitFrames.Pet.Name, "[Tukui:getnamecolor][Tukui:namemini]")
	
--------------------------------------------------------------
-- tot name
--------------------------------------------------------------
	G.UnitFrames.TargetTarget:Tag(G.UnitFrames.TargetTarget.Name, "[Tukui:getnamecolor][Tukui:nameshort]")
