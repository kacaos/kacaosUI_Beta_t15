local T, C, L = unpack(Tukui)

-- Overriding defualt Tukui Skin Templates here if I can.
local frames = {
	CharacterFrame,
	CharacterFrameTab1.backdrop,
	CharacterFrameTab2.backdrop,
	CharacterFrameTab3.backdrop,
	CharacterFrameTab4.backdrop,
	FriendsFrame,
	FriendsFrameTab1.backdrop,
	FriendsFrameTab2.backdrop,
	FriendsFrameTab3.backdrop,
	FriendsFrameTab4.backdrop,
	SpellBookFrame,
	SpellBookFrameTabButton1.backdrop,
	SpellBookFrameTabButton2.backdrop,
	SpellBookFrameTabButton3.backdrop,
	SpellBookFrameTabButton4.backdrop,
	SpellBookFrameTabButton5.backdrop,
	QuestLogFrame,
	VideoOptionsFrame,
	InterfaceOptionsFrame,
	WorldMapFrame.backdrop,
	QuestFrame.backdrop,
	GossipFrame.backdrop,
	GameMenuFrame,
	WorldStateScoreFrame,
	MailFrame.backdrop,
	PVPFrame.backdrop,
	MerchantFrame.backdrop,
	MerchantBuyBackItem.backdrop,
}

local OnLoad = CreateFrame("Frame")
OnLoad:RegisterEvent("PLAYER_ENTERING_WORLD")
OnLoad:SetScript("OnEvent", function()
	for _,f in pairs(frames) do
		f:SetTemplate("Transparent")
		--f:SetBorder(false, true)
	end
end)