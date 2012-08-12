local T, C, L, G = unpack( Tukui )
if C.unitframes.style ~= 1 then return end
if( C["unitframes"].enable ~= true ) then return end

--------------------------------------------------------------
-- Position
--------------------------------------------------------------
local FramePositions = CreateFrame( "Frame" )
FramePositions:RegisterEvent( "PLAYER_ENTERING_WORLD" )
FramePositions:SetScript( "OnEvent", function( self, event, addon )
	G.UnitFrames.Player:ClearAllPoints()
	G.UnitFrames.Target:ClearAllPoints()
	G.UnitFrames.TargetTarget:ClearAllPoints()
	G.UnitFrames.Pet:ClearAllPoints()
	G.UnitFrames.Focus:ClearAllPoints()
	G.UnitFrames.FocusTarget:ClearAllPoints()
	
	if C.actionbar.b2bottom then
		G.UnitFrames.Player:SetPoint( "TOP", UIParent, "BOTTOM", -257, 150)
	end
	G.UnitFrames.Target:SetPoint( "TOP", UIParent, "BOTTOM", 257, 150)

	G.UnitFrames.TargetTarget:SetPoint( "TOPRIGHT", G.UnitFrames.Target, "BOTTOMRIGHT", 0, -10)
	G.UnitFrames.Pet:SetPoint( "TOPLEFT", G.UnitFrames.Player, "BOTTOMLEFT", 0, -10)
	G.UnitFrames.Focus:SetPoint( "CENTER", UIParent, "CENTER", -400, -150)
	G.UnitFrames.FocusTarget:SetPoint( "TOP", G.UnitFrames.Focus.Health, "BOTTOM", 0 , -43 )

	for i = 1, MAX_BOSS_FRAMES do
		G.UnitFrames["Boss" .. i]:ClearAllPoints()
		if( i == 1 ) then
			G.UnitFrames["Boss"..i]:SetPoint("CENTER", UIParent, 600, -150)
		else
			G.UnitFrames["Boss"..i]:SetPoint("CENTER", G.UnitFrames["Boss" .. i - 1], 0, 50)
		end
	end

	for i = 1, 5 do
		G.UnitFrames["Arena" .. i]:ClearAllPoints()
		if( i == 1 ) then
			G.UnitFrames["Arena" .. i]:SetPoint( "TOP", UIParent, "BOTTOM", 450, 600 )
		else
			G.UnitFrames["Arena" .. i]:SetPoint( "TOP", G.UnitFrames["Arena" .. i - 1], "BOTTOM", 0, -43 )
		end
	end

end )