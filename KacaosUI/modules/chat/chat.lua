local T, C, L = unpack(Tukui)
if not C["chat"].enable then return end
---------------------------------------------------------------
-- Chats
---------------------------------------------------------------

local function SetTabStyle( frame )
	local id = frame:GetID()
	local chat = frame:GetName()
	local tab = _G[chat .. "Tab"]

	if C.chat.chattabshow then
	_G[chat .. "TabText"]:Show()
	tab:HookScript("OnEnter", function() _G[chat .. "TabText"]:Show() end )
	tab:HookScript("OnLeave", function() _G[chat .. "TabText"]:Show() end )
	else
	_G[chat .. "TabText"]:Hide()
	tab:HookScript("OnEnter", function() _G[chat .. "TabText"]:Show() end )
	tab:HookScript("OnLeave", function() _G[chat .. "TabText"]:Hide() end )
	end

	_G[chat .. "TabText"]:SetTextColor( .6, .6, .6 )
	_G[chat .. "TabText"]:SetFont( C.media.pixelfont, 8, "MONOCHROMEOUTLINE" )
	_G[chat .. "TabText"]:SetShadowOffset(0,0)	
	_G[chat .. "TabText"].SetTextColor = T.dummy
	
	_G[chat]:SetFading(true)
end

local function SetupChatStyle( self )	
	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G[format( "ChatFrame%s", i )]
		SetTabStyle( frame )
	end

	ChatTypeInfo.WHISPER.sticky = 1
	ChatTypeInfo.BN_WHISPER.sticky = 1
	ChatTypeInfo.OFFICER.sticky = 1
	ChatTypeInfo.RAID_WARNING.sticky = 1
	ChatTypeInfo.CHANNEL.sticky = 1
end

TukuiChat:HookScript( "OnEvent", function( self, event, ... )
	for i = 1, NUM_CHAT_WINDOWS do
		local chat = _G[format( "ChatFrame%s", i )]
		local font, size = chat:GetFont()
		SetupChatStyle( chat )
		chat:SetFont(font, size, "OUTLINE")
		chat:SetShadowOffset(0,0)
	end
end )

T.SetDefaultChatPosition = function( frame )
	if( frame ) then
		local id = frame:GetID()
		local name = FCF_GetChatWindowInfo( id )

		if( id == 1 ) then
			frame:ClearAllPoints()
			frame:Point( "BOTTOMLEFT", ChatBackgroundLeft, "BOTTOMLEFT", -5, 5 )
			frame:Point( "BOTTOMRIGHT", ChatBackgroundLeft, "BOTTOMRIGHT", -5, 5 )
			frame:Point( "TOPRIGHT", ChatBackgroundLeft, "TOPRIGHT", -5, -23.5 )
			frame:Point( "TOPLEFT", ChatBackgroundLeft, "TOPLEFT", 5, -23.5 )
		elseif id == 4 and name == LOOT then
			if not frame.isDocked then
				FCF_SetLocked( ChatFrame4, 1 )
				FCF_DockFrame( ChatFrame4 )
			end
		end
		
		FCF_SavePositionAndDimensions( frame )

		if not frame.isLocked then FCF_SetLocked( frame, 1 ) end
	end
end

hooksecurefunc( "FCF_RestorePositionAndDimensions", T.SetDefaultChatPosition )

if C.chat.fadeout then
local fadeout = CreateFrame("Frame")
fadeout:RegisterEvent("PLAYER_ENTERING_WORLD")
fadeout:RegisterEvent("PLAYER_REGEN_ENABLED")
fadeout:RegisterEvent("PLAYER_REGEN_DISABLED")
fadeout:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_REGEN_ENABLED" then
		ChatFrame1Tab:Show()
		ChatFrame3Tab:Show()
		ChatFrame4Tab:Show()
	elseif event == "PLAYER_REGEN_DISABLED" then
		ChatFrame1Tab:Hide()
		ChatFrame3Tab:Hide()
		ChatFrame4Tab:Hide()
	end
end)
end

BNToastFrame:HookScript( "OnShow", function( TukuiTooltipAnchor )
TukuiTooltipAnchor:ClearAllPoints()
TukuiTooltipAnchor:Point( "BOTTOMLEFT", G.Panels.LeftChatBackground, "BOTTOMRIGHT", 3, 0 )
end )

--------------------------------------------------------------------------------
--	Play sound when your name is called in chat -- credit Hydra
--------------------------------------------------------------------------------

if C.chat.namealert then
	local chatFind = CreateFrame("Frame")
	chatFind:RegisterEvent("CHAT_MSG_GUILD")
	chatFind:RegisterEvent("CHAT_MSG_BATTLEGROUND")
	chatFind:RegisterEvent("CHAT_MSG_BATTLEGROUND_LEADER")
	chatFind:RegisterEvent("CHAT_MSG_OFFICER")
	chatFind:RegisterEvent("CHAT_MSG_PARTY")
	chatFind:RegisterEvent("CHAT_MSG_PARTY_LEADER")
	chatFind:RegisterEvent("CHAT_MSG_RAID")
	chatFind:RegisterEvent("CHAT_MSG_RAID_LEADER")
	chatFind:RegisterEvent("CHAT_MSG_SAY")
	chatFind:RegisterEvent("CHAT_MSG_CHANNEL")

	chatFind:SetScript("OnEvent", function(event, msg, sender)
		sender = strlower(sender)

		for _, v in pairs(C.chat.names) do
			if strfind(sender, strlower(UnitName("player"))) or strfind(sender, strlower(v)) then
				PlaySoundFile(C.media.namealert)
				return
			end
		end
	end)
end