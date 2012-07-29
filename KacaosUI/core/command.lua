local T, C, L, G = unpack(Tukui)

-- switch to heal layout via a command
SLASH_TUKUIHEAL1 = "/heal"
SlashCmdList.TUKUIHEAL = function()
	DisableAddOn("KacaosUI_Raid")
	EnableAddOn("KacaosUI_Raid_Healing")
	ReloadUI()
end

-- switch to dps layout via a command
SLASH_TUKUIDPS1 = "/dps"
SlashCmdList.TUKUIDPS = function()
	DisableAddOn("KacaosUI_Raid_Healing")
	EnableAddOn("KacaosUI_Raid")
	ReloadUI()
end