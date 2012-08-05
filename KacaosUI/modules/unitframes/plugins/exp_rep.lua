T, C, L, G = unpack(Tukui)
if not C.unitframes.enable == true then return end

------------------------------
-- experience
------------------------------
local cbWidth = C.chat.chatbackgroundwidth
		if(T.level ~= MAX_PLAYER_LEVEL) then
			G.UnitFrames.Player.Experience:ClearAllPoints()
			G.UnitFrames.Player.Experience:SetStatusBarColor( 0, 0.4, 1, 0.8 )

			G.UnitFrames.Player.Experience:Size((cbWidth-1), 3)
			G.UnitFrames.Player.Experience:Point("BOTTOM", ChatBackgroundLeft, "TOP", 0, 2)
			G.UnitFrames.Player.Experience:SetFrameLevel(12)
			G.UnitFrames.Player.Experience:SetAlpha(1)

			G.UnitFrames.Player.Experience:HookScript("OnLeave", function(self) self:SetAlpha(1) end)

			G.UnitFrames.Player.Experience.Text = G.UnitFrames.Player.Experience:CreateFontString(nil, "OVERLAY")
			G.UnitFrames.Player.Experience.Text:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			G.UnitFrames.Player.Experience.Text:SetPoint("CENTER", 0, 1)
			G.UnitFrames.Player.Experience.Text:SetShadowOffset(0, 0)
			G.UnitFrames.Player.Experience.Text = G.UnitFrames.Player.Experience.Text
			G.UnitFrames.Player.Experience.PostUpdate = T.ExperienceText

			G.UnitFrames.Player.Resting:ClearAllPoints()
			G.UnitFrames.Player.Resting:SetPoint( "BOTTOMRIGHT", G.UnitFrames.Player, "TOPLEFT", 6, 7 )
		end

	------------------------------
	-- reputation
	------------------------------
		if(T.level == MAX_PLAYER_LEVEL) then
			G.UnitFrames.Player.Reputation:ClearAllPoints()
			G.UnitFrames.Player.Reputation:SetStatusBarColor( 0, 0.4, 1, 0.8 )

			G.UnitFrames.Player.Reputation:Size((cbWidth-1), 3)
			G.UnitFrames.Player.Reputation:Point("BOTTOM", ChatBackgroundLeft, "TOP", 0, 2)
			G.UnitFrames.Player.Reputation:SetFrameLevel(12)
			G.UnitFrames.Player.Reputation:SetAlpha(1)

			G.UnitFrames.Player.Reputation:HookScript("OnLeave", function(self) self:SetAlpha(1) end)

			G.UnitFrames.Player.Reputation.Text = G.UnitFrames.Player.Reputation:CreateFontString(nil, "OVERLAY")
			G.UnitFrames.Player.Reputation.Text:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			G.UnitFrames.Player.Reputation.Text:SetPoint("CENTER", 0, 1)
			G.UnitFrames.Player.Reputation.Text:SetShadowOffset(0, 0)
			G.UnitFrames.Player.Reputation.Text = G.UnitFrames.Player.Reputation.Text
			G.UnitFrames.Player.Reputation.PostUpdate = T.UpdateReputationColor
		end
