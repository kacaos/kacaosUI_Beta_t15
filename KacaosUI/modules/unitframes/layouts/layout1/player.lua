local T, C, L, G = unpack( Tukui )

if( C["unitframes"].enable ~= true ) then return end
if C.unitframes.style ~= 1 then return end
--------------------------------------------------------------
-- Player
--------------------------------------------------------------
do
	do
		G.UnitFrames.Player:SetBackdrop( nil )
		G.UnitFrames.Player:SetBackdropColor( 0, 0, 0 )
		G.UnitFrames.Player.shadow:Kill()
		G.UnitFrames.Player.panel:Kill()
	end
--------------------------------------------------------------
-- health
--------------------------------------------------------------
	do
		G.UnitFrames.Player.Health:Height(20)
		G.UnitFrames.Player.Health:SetFrameLevel(5)
		G.UnitFrames.Player.Health:AddBorder()
		G.UnitFrames.Player.Power:ClearAllPoints()
		G.UnitFrames.Player.Power:Point("BOTTOM", G.UnitFrames.Player.Health, 0,-5)
		G.UnitFrames.Player.Power:Width(175)
		G.UnitFrames.Player.Power:Height(2)
		G.UnitFrames.Player.Power:SetFrameLevel(3)
		G.UnitFrames.Player.Power:AddBorder()
		G.UnitFrames.Player.Health.bg:SetTexture( 0.6, 0.6, 0.6 )
		
		if( C["unitframes"].unicolor == true ) then
			G.UnitFrames.Player.Health.bg:SetVertexColor(unpack(C["unitframes"].healthBgColor))
		end
		
		G.UnitFrames.Player.Health.value = T.SetFontString(G.UnitFrames.Player.Health, C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		G.UnitFrames.Player.Health.value:SetShadowOffset(0,0)
		G.UnitFrames.Player.Health.value:SetPoint("RIGHT", G.UnitFrames.Player.Health, -1, 0)

		G.UnitFrames.Player.Power.value = T.SetFontString(G.UnitFrames.Player.Health, C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		G.UnitFrames.Player.Power.value:SetShadowOffset(0,0)
		G.UnitFrames.Player.Power.value:SetPoint("LEFT", G.UnitFrames.Player.Health, 2, 0)
		
		G.UnitFrames.Player.Health.value.ClearAllPoints = T.dummy
		G.UnitFrames.Player.Health.value.SetPoint = T.dummy
		G.UnitFrames.Player.Power.value.ClearAllPoints = T.dummy
		G.UnitFrames.Player.Power.value.SetPoint = T.dummy	
	end
--------------------------------------------------------------
-- mana flash
--------------------------------------------------------------
	do
		G.UnitFrames.Player.FlashInfo:ClearAllPoints()
		G.UnitFrames.Player.FlashInfo:SetAllPoints( G.UnitFrames.Player.Health )
		G.UnitFrames.Player.FlashInfo:SetFrameLevel( G.UnitFrames.Player.Health:GetFrameLevel() + 2 )

		G.UnitFrames.Player.FlashInfo.ManaLevel:ClearAllPoints()
		G.UnitFrames.Player.FlashInfo.ManaLevel:SetPoint( "CENTER", 0, 0 )
		G.UnitFrames.Player.FlashInfo.ManaLevel:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		
	end
		
--------------------------------------------------------------
-- castbar
--------------------------------------------------------------
	do
		if( C["unitframes"].unitcastbar == true ) then

			local mover = CreateFrame("Frame", "TukuiPlayerCastbarMover", UIParent)
			mover:Height(C.castbar.pcheight)
			mover:Width(C.castbar.pcwidth)
			mover:Point("CENTER", UIParent, "CENTER", 0, -201)
			mover:SetTemplate()
			mover:SetBackdropBorderColor(1,0,0)
			mover:SetClampedToScreen(true)
			mover:SetMovable(true)
			mover:SetFrameStrata("HIGH")
			mover:Hide()
			mover:FontString("Text", C.media.font, 12)
			mover.Text:SetPoint("CENTER", TukuiPlayerCastbarMover, "CENTER", 0, 0)
			mover.Text:SetText(L.mover_castbarplayer)
			tinsert(T.AllowFrameMoving, mover)
		
			G.UnitFrames.Player.Castbar:ClearAllPoints()
			G.UnitFrames.Player.Castbar:SetPoint("CENTER", mover)
			G.UnitFrames.Player.Castbar:SetTemplate()
			G.UnitFrames.Player.Castbar:Height(C.castbar.pcheight)
			G.UnitFrames.Player.Castbar:Width(C.castbar.pcwidth)
			G.UnitFrames.Player.Castbar.Text:Point("LEFT", G.UnitFrames.Player.Castbar, "LEFT", 3, -1)
			G.UnitFrames.Player.Castbar.Text:SetFont(C.media.pixelfont, 10, "MONOCHROMEOUTLINE")
			G.UnitFrames.Player.Castbar.Text:SetShadowOffset(0,0)
			G.UnitFrames.Player.Castbar.Time:Point("RIGHT", G.UnitFrames.Player.Castbar, "RIGHT", -3, -1)
			G.UnitFrames.Player.Castbar.Time:SetFont(C.media.pixelfont, 10, "MONOCHROMEOUTLINE")
			G.UnitFrames.Player.Castbar.Time:SetShadowOffset(0,0)
			G.UnitFrames.Player.Castbar:CreateBorder(false, true)
			
			G.UnitFrames.Player.Castbar.button:Kill()
			
			G.UnitFrames.Player.Castbar.PostCastStart = T.PostCastStart
			G.UnitFrames.Player.Castbar.PostChannelStart = T.PostCastStart
			G.UnitFrames.Player.Castbar.CustomTimeText = T.CustomCastTimeText
			G.UnitFrames.Player.Castbar.CustomDelayText = T.CustomCastDelayText

		end
	end
	
--------------------------------------------------------------
-- classicons
--------------------------------------------------------------
	do
		if( C["unitframes"].classicons == true ) then
			local classicon = CreateFrame( "Frame", G.UnitFrames.Player:GetName() .. "_ClassIconBorder", G.UnitFrames.Player )
			classicon:SetTemplate("Default")
			classicon:Size(27, 27)
			classicon:Point("TOPRIGHT", G.UnitFrames.Player.Health, "TOPLEFT", -3, 1)
			local class = classicon:CreateTexture( G.UnitFrames.Player:GetName() .. "_ClassIcon", "ARTWORK" )
			class:Point( "TOPLEFT", 1, -1)
			class:Point( "BOTTOMRIGHT", -1, 1)
			G.UnitFrames.Player.ClassIcon = class

			G.UnitFrames.Player:EnableElement("ClassIcon")
		end
	end
	
--------------------------------------------------------------
-- portraits
--------------------------------------------------------------
	do
		if( C["unitframes"].charportrait == true ) then
			G.UnitFrames.Player.Portrait:ClearAllPoints()
			G.UnitFrames.Player.Portrait:SetAllPoints( G.UnitFrames.Player.Health )
			G.UnitFrames.Player.Portrait:SetAlpha( 0.2 )
			G.UnitFrames.Player.Portrait.SetAlpha = T.dummy
			G.UnitFrames.Player.Health:ClearAllPoints()
			G.UnitFrames.Player.Health:SetPoint( "TOPLEFT", 0, 0 )
			G.UnitFrames.Player.Health:SetPoint( "TOPRIGHT" )
			G.UnitFrames.Player.Portrait:SetFrameLevel( G.UnitFrames.Player.Health:GetFrameLevel() )
		end
	end
	
--------------------------------------------------------------
-- combat icon
--------------------------------------------------------------
	do
		G.UnitFrames.Player.Combat:ClearAllPoints()
		G.UnitFrames.Player.Combat:Point("CENTER", G.UnitFrames.Player.Health, "CENTER")
	end	
--------------------------------------------------------------
-- size
--------------------------------------------------------------
	do
		G.UnitFrames.Player:Size( 175, 20 )
	end
end