local T, C, L, G = unpack( Tukui )

local function SpellName( id )
	local name, _, _, _, _, _, _, _, _ = GetSpellInfo( id )
	if( not name ) then
		print( 'SpellID is not valid!' )
		return 'Impale'
	else
		return name
	end
end

T.ChannelTicks = {
	--Warlock
	[SpellName( 1120 )] = 5, --"Drain Soul"
	[SpellName( 689 )] = 3, -- "Drain Life"
	[SpellName( 5740 )] = 4, -- "Rain of Fire"
	[SpellName( 755 )] = 3, -- Health Funnel
	[GetSpellInfo(1949)] = 15,	-- Hellfire
	[SpellName( 103103 )] = 3, -- Malefic Grasp

	--Druid
	[SpellName( 44203 )] = 4, -- "Tranquility"
	[SpellName( 16914 )] = 10, -- "Hurricane"
	--Priest
	[SpellName( 15407 )] = 3, -- "Mind Flay"
	[SpellName( 48045 )] = 5, -- "Mind Sear"
	[SpellName( 47540 )] = 2, -- "Penance"
	[SpellName( 64901 )] = 4, -- Hymn of Hope
	[SpellName( 64843 )] = 4, -- Divine Hymn
	--Mage
	[SpellName( 5143 )] = 5, -- "Arcane Missiles"
	[SpellName( 10 )] = 5, -- "Blizzard"
	[SpellName( 12051 )] = 4, -- "Evocation"

	[GetSpellInfo(115175)] = 9,	-- Soothing Mist

}

--Spells Effected By Haste
T.HastedChannelTicks = {
	[SpellName( 64901 )] = true, -- Hymn of Hope
	[SpellName( 64843 )] = true, -- Divine Hymn
	[SpellName( 1120 )] = true, -- Drain Soul
}

------------------------------
-- castbar
------------------------------
local oUF = oUFTukui

local ticks = {}
function T.HideTicks()
	for _, tick in pairs(ticks) do
		tick:Hide()
	end		
end

function T.SetCastTicks(frame, numTicks)
	T.HideTicks()
	if(numTicks and numTicks > 0 ) then
		local d = frame:GetWidth() / numTicks
		for i = 1, numTicks do
			if not ticks[i] then
				ticks[i] = frame:CreateTexture(nil, "OVERLAY")
				ticks[i]:SetTexture(C["media"].normTex)
				ticks[i]:SetVertexColor(0, 0, 0)
				ticks[i]:SetWidth(2)
				ticks[i]:SetHeight(frame:GetHeight())
			end
			ticks[i]:ClearAllPoints()
			ticks[i]:SetPoint("CENTER", frame, "LEFT", d * i, 0)
			ticks[i]:Show()
		end
	end
end

-- color castbar
T.PostCastStart = function(self, unit, name, rank, castid)
	if unit == "vehicle" then unit = "player" end
	--Fix blank castbar with opening text
	if name == "Opening" then
		self.Text:SetText("Opening")
	end

	if self.interrupt and unit ~= "player" then
		if UnitCanAttack("player", unit) then
			self:SetStatusBarColor(unpack(C["castbar"].nointerruptcolor))
		else
			self:SetStatusBarColor(unpack(C["castbar"].nointerruptcolor))	
		end
	else
        if C["castbar"].classcolor then
            self:SetStatusBarColor(unpack(oUF.colors.class[select(2, UnitClass(unit))]))
        else
            self:SetStatusBarColor(unpack(C["castbar"].castbarcolor))
        end

		if(C["castbar"].ticks == true and unit == "player") then
			local baseTicks = T.ChannelTicks[name]
			if(baseTicks and T.HastedChannelTicks[name] ) then
				local tickIncRate = 1 / baseTicks
				local curHaste = UnitSpellHaste("player") * 0.01
				local firstTickInc = tickIncRate / 2
				local bonusTicks = 0
				if(curHaste >= firstTickInc) then
					bonusTicks = bonusTicks + 1
				end

				local x = tonumber(T.Round(firstTickInc + tickIncRate, 2))
				while curHaste >= x do
					x = tonumber(T.Round(firstTickInc + (tickIncRate * bonusTicks), 2))
					if(curHaste >= x) then
						bonusTicks = bonusTicks + 1
					end
				end

				T.SetCastTicks(self, baseTicks + bonusTicks)
			elseif(baseTicks) then
				T.SetCastTicks(self, baseTicks)
			else
				T.HideTicks()
			end
		elseif(unit == "player") then
			T.HideTicks()
		end
	end	
end	