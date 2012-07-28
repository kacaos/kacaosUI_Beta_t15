local T, C, L, G = unpack( Tukui )

if C["unitframes"].raidunitdebuffwatch == true then
	-- Class buffs { spell ID, position [, {r,g,b,a}][, anyUnit] }
	-- It use oUF_AuraWatch lib, for grid indicator
	do
		T.buffids = {
			PRIEST = {
				{6788, "TOPRIGHT", {1, 0, 0}, true},			-- Weakened Soul
				{33076, "BOTTOMRIGHT", {0.2, 0.7, 0.2}},		-- Prayer of Mending
				{139, "BOTTOMLEFT", {0.4, 0.7, 0.2}}, 			-- Renew
				{17, "TOPLEFT", {0.81, 0.85, 0.1}, true},		-- Power Word: Shield
				{10060, "RIGHT", {0.89, 0.1, 0.1}},				-- Power Infusion
				{33206, "LEFT", {0.89, 0.1, 0.1}, true},		-- Pain Suppress
				{47788, "LEFT", {0.86, 0.52, 0}, true},			-- Guardian Spirit
			},
			DRUID = {
				{774, "TOPRIGHT", {0.8, 0.4, 0.8}},				-- Rejuvenation
				{8936, "BOTTOMLEFT", {0.2, 0.8, 0.2}},			-- Regrowth
				{94447, "TOPLEFT", {0.4, 0.8, 0.2}},			-- Lifebloom
				{48438, "BOTTOMRIGHT", {0.8, 0.4, 0}},			-- Wild Growth
			},
			PALADIN = {
				{53563, "TOPRIGHT", {0.7, 0.3, 0.7}},			-- Beacon of Light
				{1022, "BOTTOMRIGHT", {0.2, 0.2, 1}, true},		-- Hand of Protection
				{1044, "BOTTOMRIGHT", {0.89, 0.45, 0}, true},	-- Hand of Freedom
				{1038, "BOTTOMRIGHT", {0.93, 0.75, 0}, true},	-- Hand of Salvation
				{6940, "BOTTOMRIGHT", {0.89, 0.1, 0.1}, true},	-- Hand of Sacrifice
			},
			SHAMAN = {
				{61295, "TOPRIGHT", {0.7, 0.3, 0.7}},			-- Riptide 
				{974, "BOTTOMLEFT", {0.2, 0.7, 0.2}, true},		-- Earth Shield
				--{16236, "TOPLEFT", {0.4, 0.7, 0.2}},			-- Ancestral Fortitude is gone
				{51945, "BOTTOMRIGHT", {0.7, 0.4, 0}},			-- Earthliving
			},
			
			MONK = {
				{119611, "TOPLEFT", {0.8, 0.4, 0.8}},			--Erneuernder Nebel
				{116849, "TOPRIGHT", {0.2, 0.8, 0.2}},			-- Lebenskokon 
				{124682, "BOTTOMLEFT", {0.4, 0.8, 0.2}}, 		-- Erneuernder Nebel
				{115176, "RIGHT", {0.81, 0.85, 0.1}, true}, 	-- Zenmeditation
				{124081, "BOTTOMRIGHT", {0.7, 0.4, 0}}, 		-- Zensphäre
			},
			ALL = {
				{14253, "RIGHT", {0, 1, 0}}, 					-- Abolish Poison
				{23333, "LEFT", {1, 0, 0}}, 					-- Warsong flag xD
			},
		}
	end
	
	-- Dispellable & Important Raid Debuffs we want to show on Grid!
	-- It use oUF_RaidDebuffs lib for tracking dispellable / important
	do
		local ORD = oUF_RaidDebuffs

		if not ORD then return end
		
		ORD.ShowDispelableDebuff = true
		ORD.FilterDispellableDebuff = true
		ORD.MatchBySpellName = true
		ORD.DeepCorruption = true
		
		local function SpellName(id)
			local name = select(1, GetSpellInfo(id))
			return name	
		end

		T.debuffids = {
		-----------------------------------------------------------------
		-- Pandaria
		-----------------------------------------------------------------
		-- Heart of Fear
			-- Imperial Vizier Zor'lok
			SpellName(122761),		-- Exhale
			SpellName(122760), 		-- Exhale
			SpellName(122740),		-- Convert
			SpellName(123812),		-- Pheromones of Zeal
			-- Blade Lord Ta'yak
			SpellName(123180),		-- Wind Step
			SpellName(123474),		-- Overwhelming Assault
			-- Garalon
			SpellName(122835),		-- Pheromones
			SpellName(123081),		-- Pungency
			-- Wind Lord Mel'jarak
			SpellName(122125),		-- Corrosive Resin Pool
			SpellName(121885), 		-- Amber Prison (10 Men)
			-- Amber-Shaper Un'sok
			SpellName(121949),		-- Parasitic Growth
			-- Grand Empress Shek'zeer
		-- Mogu'shan Vaults
			-- The Stone Guard
			SpellName(116281),		-- Cobalt Mine Blast
			-- Feng the Accursed
			SpellName(116784),		-- Wildfire Spark
			SpellName(116417),		-- Arcane Resonance
			SpellName(116942),		-- Flaming Spear
			-- Gara'jal the Spiritbinder
			SpellName(116161),		-- Crossed Over
			-- The Spirit Kings
			SpellName(117708),		-- Maddening Shout
			SpellName(118303),		-- Fixate
			SpellName(118048),		-- Pillaged
			SpellName(118135),		-- Pinned Down
			-- Elegon
			SpellName(117878),		-- Overcharged
			SpellName(117949),		-- Closed Circuit
			-- Will of the Emperor
			SpellName(116835),		-- Devastating Arc
			SpellName(116778),		-- Focused Defense
			SpellName(116525),		-- Focused Assault
		-- Terrace of Endless Spring
			-- Protectors of the Endless
			SpellName(117436),		-- Lightning Prison
			SpellName(118091),		-- Defiled Ground
			SpellName(117519),		-- Touch of Sha
			-- Sha of Anger
			-- Salyis's Warband
			-- Tsulong
			SpellName(122752),		-- Shadow Breath
			SpellName(123011),		-- Terrorize
			SpellName(116161),		-- Crossed Over
			-- Lei Shi
			SpellName(123121),		-- Spray
			-- Sha of Fear
			SpellName(119985),		-- Dread Spray
			SpellName(119086),		-- Penetrating Bolt
			SpellName(119775),		-- Reaching Attack
			SpellName(6788), -- Test!!!!!!!!
		}

		T.ReverseTimer = {

		},
		
		ORD:RegisterDebuffs(T.debuffids)
	end
end