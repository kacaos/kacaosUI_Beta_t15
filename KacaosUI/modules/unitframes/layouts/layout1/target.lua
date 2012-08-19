local T, C, L, G = unpack( Tukui )

if not C.unitframes.enable == true then return end
if C.unitframes.style ~= 1 then return end
--------------------------------------------------------------
-- Target
--------------------------------------------------------------
do
	do
		G.UnitFrames.Target:SetBackdrop( nil )
		G.UnitFrames.Target:SetBackdropColor( 0, 0, 0 )
		G.UnitFrames.Target.shadow:Kill()
		G.UnitFrames.Target.panel:Kill()
		G.UnitFrames.Target:Point("BOTTOM", UIParent, 257, 150)
	end
	
--------------------------------------------------------------
-- health
--------------------------------------------------------------
	do
		G.UnitFrames.Target.Health:Height(20)
		G.UnitFrames.Target.Health:SetFrameLevel(5)
		G.UnitFrames.Target.Health:AddBorder()
		G.UnitFrames.Target.Power:ClearAllPoints()
		G.UnitFrames.Target.Power:Point("BOTTOM", G.UnitFrames.Target.Health, 0,-5)
		G.UnitFrames.Target.Power:Width(175)
		G.UnitFrames.Target.Power:Height(2)
		G.UnitFrames.Target.Power:SetFrameLevel(3)
		G.UnitFrames.Target.Power:AddBorder()
		G.UnitFrames.Target.Health.bg:SetTexture( 0.6, 0.6, 0.6 )
		
		if( C["unitframes"].unicolor == true ) then
			G.UnitFrames.Target.Health.bg:SetVertexColor(unpack(C["unitframes"].healthBgColor))
		end
		
		G.UnitFrames.Target.Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		G.UnitFrames.Target.Name:ClearAllPoints()
		G.UnitFrames.Target.Name:SetPoint("LEFT", G.UnitFrames.Target.Power, "LEFT", 4, -9)
		G.UnitFrames.Target.Name:SetShadowOffset( 1.25, -1.25 )
		
		G.UnitFrames.Target.Health.value = T.SetFontString(G.UnitFrames.Target.Health, C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		G.UnitFrames.Target.Health.value:SetShadowOffset(0,0)
		G.UnitFrames.Target.Health.value:SetPoint("LEFT", G.UnitFrames.Target.Health, 1, 0)

		G.UnitFrames.Target.Power.value = T.SetFontString(G.UnitFrames.Target.Health, C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		G.UnitFrames.Target.Power.value:SetShadowOffset(0,0)
		G.UnitFrames.Target.Power.value:SetPoint("RIGHT", G.UnitFrames.Target.Health, -1, 0)
		
		G.UnitFrames.Target.Name.ClearAllPoints = T.dummy
		G.UnitFrames.Target.Name.SetPoint = T.dummy	
		G.UnitFrames.Target.Health.value.ClearAllPoints = T.dummy
		G.UnitFrames.Target.Health.value.SetPoint = T.dummy
		G.UnitFrames.Target.Power.value.ClearAllPoints = T.dummy
		G.UnitFrames.Target.Power.value.SetPoint = T.dummy	
	end
	
--------------------------------------------------------------
-- castbar
--------------------------------------------------------------
	do
		if( C["unitframes"].unitcastbar == true ) then

		-- castbar
		local mover = CreateFrame("Frame", "TukuiTargetCastbarMover", UIParent)
		mover:Height(C.castbar.tcheight)
		mover:Width(C.castbar.tcwidth)
		mover:Point("CENTER", UIParent, "CENTER", 0, 140)
		mover:SetTemplate()
		mover:SetBackdropBorderColor(1,0,0)
		mover:SetClampedToScreen(true)
		mover:SetMovable(true)
		mover:SetFrameStrata("HIGH")
		mover:Hide()
		mover:FontString("Text", C.media.font, 12)
		mover.Text:SetPoint("CENTER", TukuiTargetCastbarMover, "CENTER", 0, 0)
		mover.Text:SetText(L.mover_castbartarget)
		tinsert(T.AllowFrameMoving, mover)
		
		G.UnitFrames.Target.Castbar:ClearAllPoints()
		G.UnitFrames.Target.Castbar:SetPoint("CENTER", mover)
		G.UnitFrames.Target.Castbar:SetTemplate()
		G.UnitFrames.Target.Castbar:Height(C.castbar.tcheight)
		G.UnitFrames.Target.Castbar:Width(C.castbar.tcwidth)
		G.UnitFrames.Target.Castbar.Text:Point("LEFT", G.UnitFrames.Target.Castbar, "LEFT", 3, -1)
		G.UnitFrames.Target.Castbar.Text:SetFont(C.media.pixelfont, 10, "MONOCHROMEOUTLINE")
		G.UnitFrames.Target.Castbar.Text:SetShadowOffset(0,0)
		G.UnitFrames.Target.Castbar.Time:Point("RIGHT", G.UnitFrames.Target.Castbar, "RIGHT", -3, -1)
		G.UnitFrames.Target.Castbar.Time:SetFont(C.media.pixelfont, 10, "MONOCHROMEOUTLINE")
		G.UnitFrames.Target.Castbar.Time:SetShadowOffset(0,0)
		G.UnitFrames.Target.Castbar:CreateBorder(false, true)
		
		G.UnitFrames.Target.Castbar.button:Kill()
		
		G.UnitFrames.Target.Castbar.PostCastStart = T.PostCastStart
		G.UnitFrames.Target.Castbar.PostChannelStart = T.PostCastStart
		end
	end
	
--------------------------------------------------------------
-- portraits
--------------------------------------------------------------
	do
		if( C["unitframes"].charportrait == true ) then
			G.UnitFrames.Target.Portrait:ClearAllPoints()
			G.UnitFrames.Target.Portrait:SetAllPoints( G.UnitFrames.Target.Health )
			G.UnitFrames.Target.Portrait:SetAlpha(0.25)
			G.UnitFrames.Target.Portrait.SetAlpha = T.dummy
			G.UnitFrames.Target.Health:ClearAllPoints()
			G.UnitFrames.Target.Health:SetPoint( "TOPLEFT", 0, 0 )
			G.UnitFrames.Target.Health:SetPoint( "TOPRIGHT" )
			G.UnitFrames.Target.Portrait:SetFrameLevel( G.UnitFrames.Target.Health:GetFrameLevel() )
		end
	end

--------------------------------------------------------------
-- classicons
--------------------------------------------------------------
	do
		if( C["unitframes"].classicons == true ) then
			local classicon = CreateFrame( "Frame", G.UnitFrames.Target:GetName() .. "_ClassIconBorder", G.UnitFrames.Target )
			classicon:SetTemplate("Default")
			classicon:Size(27, 27)
			classicon:Point("TOPLEFT", G.UnitFrames.Target.Health, "TOPRIGHT", 3, 1)
			local class = classicon:CreateTexture( G.UnitFrames.Target:GetName() .. "_ClassIcon", "ARTWORK" )
			class:Point( "TOPLEFT", 1, -1 )
			class:Point( "BOTTOMRIGHT", -1, 1)
			G.UnitFrames.Target.ClassIcon = class

			G.UnitFrames.Target:EnableElement( "ClassIcon" )
		end
	end
	
--------------------------------------------------------------
-- buffs, debuffs
--------------------------------------------------------------
	do
		if( C["unitframes"].targetauras == true ) then
			G.UnitFrames.Target.Debuffs:SetHeight(21)
			G.UnitFrames.Target.Debuffs:SetWidth(168)
			G.UnitFrames.Target.Debuffs.size = 21
			G.UnitFrames.Target.Debuffs.num = 14
			G.UnitFrames.Target.Debuffs.spacing = 3

			G.UnitFrames.Target.Buffs:SetHeight(21)
			G.UnitFrames.Target.Buffs:SetWidth(168)
			G.UnitFrames.Target.Buffs.size = 21
			G.UnitFrames.Target.Buffs.num = 8
			G.UnitFrames.Target.Buffs.spacing = 3

			G.UnitFrames.Target.Buffs:ClearAllPoints()
			G.UnitFrames.Target.Buffs:Point( "BOTTOMLEFT", G.UnitFrames.Target, "TOPLEFT", -1, 3)
			G.UnitFrames.Target.Buffs.ClearAllPoints = T.dummy
			G.UnitFrames.Target.Buffs.SetPoint = T.dummy

			G.UnitFrames.Target.Debuffs:ClearAllPoints()
			G.UnitFrames.Target.Debuffs:Point( "BOTTOMRIGHT", G.UnitFrames.Target.Buffs, "TOPRIGHT", 7, 3 )
			G.UnitFrames.Target.Debuffs.ClearAllPoints = T.dummy
			G.UnitFrames.Target.Debuffs.SetPoint = T.dummy

			if( G.UnitFrames.Target.Buffs or G.UnitFrames.Target.Debuffs ) then
				for _, frames in pairs( { G.UnitFrames.Target.Buffs, G.UnitFrames.Target.Debuffs } ) do
					if( not frames ) then return end
				if G.UnitFrames.Target.DeBuffs then
					frames:Size( 168, 21)
					frames.size = 21
					frames.num = 8
				elseif G.UnitFrames.Target.buffs then
					frames:Size( 168, 21)
					frames.size = 21
					frames.num = 8					
				end
					hooksecurefunc( frames, "PostCreateIcon", T.SkinAura )
				end
			end
		end
	end	
--------------------------------------------------------------
-- size
--------------------------------------------------------------
	do
		G.UnitFrames.Target:Size( 175, 20 )
	end
end