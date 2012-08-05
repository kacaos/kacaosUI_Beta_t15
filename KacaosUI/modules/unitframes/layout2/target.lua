local T, C, L, G = unpack(Tukui)
if not C.unitframes.enable == true then return end
if C.unitframes.style ~= 2 then return end

--------------------------------------------------------------
-- Target
--------------------------------------------------------------
do
	do
		G.UnitFrames.Target:SetBackdrop( nil )
		G.UnitFrames.Target:SetBackdropColor( 0, 0, 0 )
		G.UnitFrames.Target.shadow:Kill()
		G.UnitFrames.Target.panel:Kill()
	end

--------------------------------------------------------------
-- health
--------------------------------------------------------------
	do
		G.UnitFrames.Target.Health:Height(12)
		G.UnitFrames.Target.Health:CreateBorder(false, true)
		
		if C.unitframes.hpshowp then
			G.UnitFrames.Target.Health.value = T.SetFontString(G.UnitFrames.Target.Health, C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			G.UnitFrames.Target.Health.value:SetShadowOffset(0,0)
			G.UnitFrames.Target.Health.value:Point("LEFT", G.UnitFrames.Target.Health, 1, 0)
		else
			G.UnitFrames.Target.Health.value:Hide()
		end
	end

--------------------------------------------------------------
-- power
--------------------------------------------------------------		
	do
		G.UnitFrames.Target.Power:ClearAllPoints()
		G.UnitFrames.Target.Power:Height(1)
		G.UnitFrames.Target.Power:Width(200)
		G.UnitFrames.Target.Power:Point("BOTTOM", G.UnitFrames.Target.Health, 0, -4)
		G.UnitFrames.Target.Power:SetFrameLevel(3)
		G.UnitFrames.Target.Power:SetBorder(false, true)
		
		if C.unitframes.hpshowp then
			G.UnitFrames.Target.Power.value = T.SetFontString(G.UnitFrames.Target.Health, C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			G.UnitFrames.Target.Power.value:SetShadowOffset(0,0)
			G.UnitFrames.Target.Power.value:Point("RIGHT", G.UnitFrames.Target.Health, -1, 0)
		else
			G.UnitFrames.Target.Power.value:Hide()
		end
	end
	
--------------------------------------------------------------
-- portraits
--------------------------------------------------------------
	do
		if( C["unitframes"].charportrait == true) then
			G.UnitFrames.Target.Portrait:ClearAllPoints()
			G.UnitFrames.Target.Portrait:SetAllPoints(G.UnitFrames.Target)
			G.UnitFrames.Target.Portrait:SetAlpha(0.25)
			G.UnitFrames.Target.Portrait.SetAlpha = T.dummy
			G.UnitFrames.Target.Health:SetPoint("TOPLEFT", 0, 0)
			G.UnitFrames.Target.Health:SetPoint("TOPRIGHT")
			G.UnitFrames.Target.Portrait:SetFrameLevel(G.UnitFrames.Target.Health:GetFrameLevel())
		end
	end
	
--------------------------------------------------------------
-- castbar
--------------------------------------------------------------
	do
		if( C["unitframes"].unitcastbar == true) then
			local mover = CreateFrame("Frame", "TukuiTargetCastbarMover", UIParent)
			mover:Height(8)
			mover:Width(200)
			mover:Point("BOTTOM",G.UnitFrames.Target, "BOTTOM", 0, -16)
			mover:SetTemplate()
			mover:SetBackdropBorderColor(1,0,0)
			mover:SetClampedToScreen(true)
			mover:SetMovable(true)
			mover:SetFrameStrata("HIGH")
			mover:Hide()
			mover:FontString("Text", C.media.font, 12)
			mover.Text:SetPoint("CENTER", TukuiTargetCastbarMover, "CENTER", 0, 0)
			mover.Text:SetText(L.mover_castbarplayer)
			tinsert(T.AllowFrameMoving, mover)

		G.UnitFrames.Target.Castbar:ClearAllPoints()
		G.UnitFrames.Target.Castbar:Height(8)
		G.UnitFrames.Target.Castbar:Width(200)
		G.UnitFrames.Target.Castbar:SetTemplate("Transparent")
		G.UnitFrames.Target.Castbar:SetPoint("CENTER", mover)
		G.UnitFrames.Target.Castbar:CreateBorder(false, true)
		
		G.UnitFrames.Target.Castbar.Text:Point("LEFT", G.UnitFrames.Target.Castbar, "LEFT", 3, -1)
		G.UnitFrames.Target.Castbar.Text:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		G.UnitFrames.Target.Castbar.Text:SetShadowOffset(0,0)
		
		G.UnitFrames.Target.Castbar.Time:Point("RIGHT", G.UnitFrames.Target.Castbar, "RIGHT", -3, -1)
		G.UnitFrames.Target.Castbar.Time:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		G.UnitFrames.Target.Castbar.Time:SetShadowOffset(0,0)
		
		if C.unitframes.cbicons == true then
			G.UnitFrames.Target.Castbar.button:ClearAllPoints()
			G.UnitFrames.Target.Castbar.button:Point("BOTTOMLEFT", G.UnitFrames.Target.Castbar, "BOTTOMRIGHT", 5, 0)
			G.UnitFrames.Target.Castbar.button:SetTemplate()
			G.UnitFrames.Target.Castbar.button:CreateBorder(false, true)
			G.UnitFrames.Target.Castbar.button:Size(28)
			G.UnitFrames.Target.Castbar.icon:Point("TOPLEFT", G.UnitFrames.Target.Castbar.button, 0, -0)
			G.UnitFrames.Target.Castbar.icon:Point("BOTTOMRIGHT", G.UnitFrames.Target.Castbar.button, -0, 0)
		end
		
		G.UnitFrames.Target.Castbar.CustomTimeText = T.CustomCastTimeText
	    G.UnitFrames.Target.Castbar.CustomDelayText = T.CustomCastDelayText
        G.UnitFrames.Target.Castbar.PostCastStart = T.PostCastStart
        G.UnitFrames.Target.Castbar.PostChannelStart = T.PostCastStart
		
		end
	end
	
--------------------------------------------------------------
-- buffs, debuffs
--------------------------------------------------------------
	do
		--if( C["unitframes"].targetauras == true ) then
			if C.unitframes.showdb then
				G.UnitFrames.Target.Debuffs:ClearAllPoints()
				G.UnitFrames.Target.Debuffs:Point("BOTTOMRIGHT", G.UnitFrames.Target.Health, "BOTTOMRIGHT", 2, 52)
				G.UnitFrames.Target.Debuffs.size = 21
				G.UnitFrames.Target.Debuffs:Width(193)
				G.UnitFrames.Target.Debuffs.num = 14
				G.UnitFrames.Target.Debuffs.spacing = 2
				G.UnitFrames.Target.Debuffs.PostCreateIcon = T.PostCreateAura
				G.UnitFrames.Target.Debuffs.PostUpdateIcon = T.PostUpdateAura
		else
				G.UnitFrames.Target.Debuffs:Hide()
		end
				G.UnitFrames.Target.Buffs:ClearAllPoints()
				G.UnitFrames.Target.Buffs:SetPoint("BOTTOMLEFT", G.UnitFrames.Target.Health, "TOPLEFT", -1, 17)
				G.UnitFrames.Target.Buffs:SetHeight(21)
				G.UnitFrames.Target.Buffs:SetWidth(193)
				G.UnitFrames.Target.Buffs.size = 21
				G.UnitFrames.Target.Buffs.num = 9
				G.UnitFrames.Target.Buffs.spacing = 2
				G.UnitFrames.Target.Buffs.PostCreateIcon = T.PostCreateAura
				G.UnitFrames.Target.Buffs.PostUpdateIcon = T.PostUpdateAura
		
		G.UnitFrames.Target.Buffs.ClearAllPoints = T.dummy
		G.UnitFrames.Target.Buffs.SetPoint = T.dummy
		G.UnitFrames.Target.Buffs.Point = T.dummy
		G.UnitFrames.Target.Debuffs.ClearAllPoints = T.dummy
		G.UnitFrames.Target.Debuffs.SetPoint = T.dummy
		G.UnitFrames.Target.Debuffs.Point = T.dummy
	end	
--------------------------------------------------------------
-- name
--------------------------------------------------------------
	do
		G.UnitFrames.Target.Name:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
		G.UnitFrames.Target.Name:SetShadowOffset(0,0)
		G.UnitFrames.Target.Name:ClearAllPoints()
		G.UnitFrames.Target.Name:SetPoint("LEFT", G.UnitFrames.Target.Health, 0, 12)
		G.UnitFrames.Target.Name.ClearAllPoints = T.dummy
		G.UnitFrames.Target.Name.SetPoint = T.dummy	
	 end
------------------------------
-- size
------------------------------
	do
		G.UnitFrames.Target:Height(12)
		G.UnitFrames.Target:Width(200)
	end
	
end