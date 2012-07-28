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


-----------------------------------------------------------------------
-- Mail addon (from Sinaris)
-----------------------------------------------------------------------
local L_MAIL_STOPPED = ERR_INV_FULL
local L_MAIL_COMPLETE = DONE
local L_MAIL_NEED = "Need a mainbox."
local L_MAIL_MESSAGES = "Posts"
local deletedelay, t = 0.5, 0
local takingOnlyCash = false
local button, button2, waitForMail, doNothing, openAll, openAllCash, openMail, lastopened, stopOpening, onEvent, needsToWait, copper_to_pretty_money, total_cash
local _G = _G
local baseInboxFrame_OnClick
function doNothing() end

function openAll()
	if( GetInboxNumItems() == 0 ) then return end
	button:SetScript( "OnClick", nil )
	button2:SetScript( "OnClick", nil )
	baseInboxFrame_OnClick = InboxFrame_OnClick
	InboxFrame_OnClick = doNothing
	button:RegisterEvent( "UI_ERROR_MESSAGE" )
	openMail( GetInboxNumItems() )
end

function openAllCash()
	takingOnlyCash = true
	openAll()
end

function openMail( index )
	if not InboxFrame:IsVisible() then
		return
		stopOpening( "|cffffff00" .. L_MAIL_NEED )
	end

	if( index == 0 ) then
		MiniMapMailFrame:Hide()
		stopOpening( "|cffffff00" .. L_MAIL_COMPLETE )
		return
	end

	local _, _, _, _, money, COD, _, numItems = GetInboxHeaderInfo( index )
	if( money > 0 ) then
		TakeInboxMoney( index )
		needsToWait = true

		if( total_cash ) then
			total_cash = total_cash - money
		end
	elseif( not takingOnlyCash ) and numItems and ( numItems > 0 ) and COD <= 0 then
		TakeInboxItem( index )
		needsToWait = true
	end

	local items = GetInboxNumItems()
	if( numItems and numItems > 1 ) or ( items > 1 and index <= items ) then
		lastopened = index
		t = 0
		button:SetScript( "OnUpdate", waitForMail )
	else
		stopOpening( "|cffffff00" .. L_MAIL_COMPLETE )
		MiniMapMailFrame:Hide()
	end
end

function waitForMail( self, elapsed )
	t = t + elapsed
	if( not needsToWait ) or ( t > deletedelay ) then
		needsToWait = false
		button:SetScript( "OnUpdate", nil )

		local _, _, _, _, money, COD, _, numItems = GetInboxHeaderInfo( lastopened )
		if( money > 0 or ( ( not takingOnlyCash ) and COD <= 0 and numItems and ( numItems > 0 ) ) ) then
			openMail( lastopened )
		else
			openMail( lastopened - 1 )
		end
	end
end

function stopOpening( msg, ... )
	button:SetScript( "OnUpdate", nil )
	button:SetScript( "OnClick", openAll )
	button2:SetScript( "OnClick", openAllCash )
	if( baseInboxFrame_OnClick ) then
		InboxFrame_OnClick = baseInboxFrame_OnClick
	end
	button:UnregisterEvent( "UI_ERROR_MESSAGE" )
	takingOnlyCash = false
	total_cash = nil
	if( msg ) then DEFAULT_CHAT_FRAME:AddMessage( msg, ... ) end
end

function onEvent( frame, event, arg1, arg2, arg3, arg4 )
	if( event == "UI_ERROR_MESSAGE" ) then
		if( arg1 == ERR_INV_FULL ) then
			stopOpening( "|cffffff00" .. L_MAIL_STOPPED )
		end
	end
end

local function makeButton( id, text, w, h, x, y )
	local button = CreateFrame( "Button", id, InboxFrame, "UIPanelButtonTemplate" )
	button:SetWidth( w )
	button:SetHeight( h )
	button:SetPoint( "CENTER", InboxFrame, "TOP", x, y )
	button:SetText( text )
	return button
end
button = makeButton( "OpenAllButton", ALL, 70, 25, -45, -408 )
button:SetScript( "OnClick", openAll )
button:SetScript( "OnEvent", onEvent )
button2 = makeButton( "OpenAllButton2", "Gold", 70, 25, 28, -408 )
button2:SetScript( "OnClick", openAllCash )

button:SetScript( "OnEnter", function()
	GameTooltip:SetOwner( button, "ANCHOR_RIGHT" )
	GameTooltip:AddLine( string.format( "%d " .. L_MAIL_MESSAGES, GetInboxNumItems() ), 1, 1, 1 )
	GameTooltip:Show()
end )
button:SetScript( "OnLeave", function() GameTooltip:Hide() end )

function copper_to_pretty_money( c )
	if( c > 10000 ) then
		return ( "%d|cffffd700g|r %d|cffc7c7cfs|r %d|cffeda55fc|r" ):format( c / 10000, ( c / 100 ) % 100, c % 100 )
	elseif( c > 100 ) then
		return ( "%d|cffc7c7cfs|r %d|cffeda55fc|r" ):format( ( c / 100 ) % 100, c % 100 )
	else
		return ( "%d|cffeda55fc|r" ):format( c % 100 )
	end
end

button2:SetScript( "OnEnter", function()
	if not total_cash then
		total_cash = 0
		for index = 0, GetInboxNumItems() do
			total_cash = total_cash + select( 5, GetInboxHeaderInfo( index ) )
		end
	end
	GameTooltip:SetOwner( button, "ANCHOR_RIGHT" )
	GameTooltip:AddLine( copper_to_pretty_money( total_cash ), 1, 1, 1 )
	GameTooltip:Show()
end )

button2:SetScript( "OnLeave", function() GameTooltip:Hide() end )