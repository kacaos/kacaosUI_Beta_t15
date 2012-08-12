local T, C, L = unpack(Tukui)

--------------------------------------------------------
-- moveui
--------------------------------------------------------

local ENABLE_MOVE = false --Used for MoveUI

local function MoveUI()
	if InCombatLockdown() then return end
	if ENABLE_MOVE then ENABLE_MOVE = false else ENABLE_MOVE = true end
	
	local movers = {RaidCD, FilgerPlayerPvEDebuffMover, FilgerPlayerCDMover, FilgerPlayerProccsMover, FilgerPlayerDebuffsMover, FilgerPlayerBuffsMover, tbMover, TukuiTargetCastbarMover, TukuiPlayerCastbarMover, DebuffsMover, TukuiBar1Mover, TukuiBar2Mover, TukuiBar3Mover, TukuiBar4Mover, TukuiBar5Mover, TukuiPetBarMover}
	if RaidCD or FilgerPlayerPvEDebuffMover or FilgerPlayerCDMover or FilgerPlayerProccsMover or FilgerPlayerDebuffsMover or FilgerPlayerBuffsMover or tbMover or TukuiTargetCastbarMover or TukuiPlayerCastbarMover or DebuffsMover or TukuiBar1Mover or TukuiBar2Mover or TukuiBar3Mover or TukuiBar4Mover or TukuiBar5Mover or TukuiPetBarMover then
			if ENABLE_MOVE then
				for _, panels in pairs(movers) do
					panels:Show()
				end

			else
				for _, panels in pairs(movers ) do
					panels:Hide()
				end
			end
	end
	
if( InCombatLockdown() ) then print( ERR_NOT_IN_COMBAT ) return end

	local w = tonumber( string.match( ( {GetScreenResolutions()} )[GetCurrentResolution()], "(%d+)x+%d" ) )
	local h = tonumber( string.match( ( {GetScreenResolutions()} )[GetCurrentResolution()], "%d+x(%d+)" ) )
	local x = 16

	function Grid()
		ali = CreateFrame( "Frame", nil, UIParent )
		ali:SetFrameLevel( 0 )
		ali:SetFrameStrata( "TOOLTIP" )
		
		ali1 = CreateFrame("Frame", "ali1", UIParent)
		ali1:Height(5000)
		ali1:Width(2)
		ali1:SetTemplate()
		ali1:Point("CENTER", UIParent, "CENTER")
		
		ali2 = CreateFrame("Frame", "ali2", UIParent)
		ali2:Height(2)
		ali2:Width(5000)
		ali2:SetTemplate()
		ali2:Point("CENTER", UIParent, "CENTER")

		for i = -( w / x / 2 ), w / x / 2 do
			local Aliv = ali:CreateTexture( nil, "BACKGROUND" )
			Aliv:SetTexture( .3, 0, 0, .7 )
			Aliv:Point( "CENTER", UIParent, "CENTER", i * x, 0 )
			Aliv:SetSize( 1, h )
		end

		for i = -( h / x / 2 ), h / x / 2 do
			local Alih = ali:CreateTexture( nil, "BACKGROUND" )
			Alih:SetTexture( .3, 0, 0, .7 )
			Alih:Point( "CENTER", UIParent, "CENTER", 0, i * x )
			Alih:SetSize( w, 1 )
		end
	end

	if not ali and not ali1 and not ali2 then
		Grid()
	elseif( ali:IsShown() ) then
		ali:Hide()
		ali1:Hide()
		ali2:Hide()
	else
		Grid()
	end
	
end
	
hooksecurefunc(_G.SlashCmdList, "MOVING", MoveUI)

-----------------------------------------------------
-- make some elements moveable
-----------------------------------------------------
TukuiBags:SetMovable(true)
TukuiBags:SetScript("OnMouseDown", function() TukuiBags:ClearAllPoints() TukuiBags:StartMoving() end)
TukuiBags:SetScript("OnMouseUp", function() TukuiBags:StopMovingOrSizing() end)

GameMenuFrame:SetMovable(true)
GameMenuFrame:SetScript("OnMouseDown", function() GameMenuFrame:ClearAllPoints() GameMenuFrame:StartMoving() end)
GameMenuFrame:SetScript("OnMouseUp", function() GameMenuFrame:StopMovingOrSizing() end)

VideoOptionsFrame:SetMovable(true)
VideoOptionsFrame:SetScript("OnMouseDown", function() VideoOptionsFrame:ClearAllPoints() VideoOptionsFrame:StartMoving() end)
VideoOptionsFrame:SetScript("OnMouseUp", function() VideoOptionsFrame:StopMovingOrSizing() end)

InterfaceOptionsFrame:SetMovable(true)
InterfaceOptionsFrame:SetScript("OnMouseDown", function() InterfaceOptionsFrame:ClearAllPoints() InterfaceOptionsFrame:StartMoving() end)
InterfaceOptionsFrame:SetScript("OnMouseUp", function() InterfaceOptionsFrame:StopMovingOrSizing() end)

HelpFrame:SetMovable(true)
HelpFrame:SetScript("OnMouseDown", function() HelpFrame:ClearAllPoints() HelpFrame:StartMoving() end)
HelpFrame:SetScript("OnMouseUp", function() HelpFrame:StopMovingOrSizing() end)