local T, C, L, G = unpack(Tukui)

StaticPopupDialogs["KACAOSUIDISABLE_RAID"] = {
	text = L.popup_2raidactive,
	button1 = "DPS - TANK",
	button2 = "HEAL",
	OnAccept = function() DisableAddOn("KacaosUI_Raid_Healing") EnableAddOn("KacaosUI_Raid") ReloadUI() end,
	OnCancel = function() EnableAddOn("KacaosUI_Raid_Healing") DisableAddOn("KacaosUI_Raid") ReloadUI() end,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 3,	
}