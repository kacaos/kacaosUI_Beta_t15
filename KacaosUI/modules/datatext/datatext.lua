local T, C, L, G = unpack(Tukui)

---------------------------------------------------------------------------------
-- Data Text
---------------------------------------------------------------------------------

-- our own datatext position function because we made our custom panel

if C.misc.infobottom == true then
local DataTextPosition = function(f, t, o)
	local ibottom = InfoBottom
	local mstat = MinimapStat
	local ip = InfoPanel
	
	if o >= 1 and o <= 20 then
		-- 1 to 3 use a default tukui panel, no need to update
		-- just update 4 to 6
		if o == 4 then
			t:ClearAllPoints()
			t:SetParent(ibottom)
			t:SetHeight(ibottom:GetHeight())
			t:SetPoint("RIGHT", -290 ,0)
			t:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			t:SetShadowOffset(0,0)
		elseif o == 5 then
			t:ClearAllPoints()
			t:SetParent(ibottom)
			t:SetHeight(ibottom:GetHeight())
			t:SetPoint("RIGHT", -170, 0)
			t:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			t:SetShadowOffset(0,0)
		elseif o == 6 then
			t:ClearAllPoints()
			t:SetParent(ibottom)
			t:SetHeight(ibottom:GetHeight())
			t:SetPoint("RIGHT", -50, 0)
			t:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			t:SetShadowOffset(0,0)			
		elseif o == 7 then
			t:ClearAllPoints()
			t:SetParent(ibottom)
			t:SetHeight(ibottom:GetHeight())
			t:SetPoint("LEFT", 50, 0)
			t:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			t:SetShadowOffset(0,0)
		elseif o == 8 then
			t:ClearAllPoints()
			t:SetParent(ibottom)
			t:SetHeight(ibottom:GetHeight())
			t:SetPoint("LEFT", 170, 0)
			t:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			t:SetShadowOffset(0,0)
		elseif o == 9 then
			t:ClearAllPoints()
			t:SetParent(ibottom)
			t:SetHeight(ibottom:GetHeight())
			t:SetPoint("LEFT", 290, 0)
			t:SetFont(C.media.pixelfont, 8,"MONOCHROMEOUTLINE")
			t:SetShadowOffset(0,0)
		elseif o == 10 then
			t:ClearAllPoints()
			t:SetParent(mstat)
			t:SetHeight(mstat:GetHeight())
			t:SetPoint("CENTER", -1, 0)	
			t:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			t:SetShadowOffset(0,0)
		elseif o == 11 then
			t:ClearAllPoints()
			t:SetParent(ip)
			t:SetHeight(ip:GetHeight())
			t:SetPoint("CENTER", 0, 0)
			t:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			t:SetShadowOffset(0,0)
		end
	else
		-- hide everything that we don't use and enabled by default on tukui
		f:Hide()
		t:Hide()
	end
end

-- Tukui DataText List
local datatext = {
	"Guild",
	"Friends",
	"Gold",
	"FPS",
	"System",
	"Bags",
	"Gold",
	"Time",
	"Durability",
	"Heal",
	"Damage",
	"Power",
	"Haste",
	"Crit",
	"Avoidance",
	"Armor",
	"Currency",
	"Hit",
	"Mastery",
	"MicroMenu",
	"Regen",
	"Talent",
	"CallToArms",
}

-- Overwrite & Update Show/Hide/Position of all Datatext
for _, data in pairs(datatext) do
	local t = "TukuiStat"
	local frame = _G[t..data]
	local text = _G[t..data.."Text"]

	if frame and frame.Option then
		DataTextPosition(frame, text, frame.Option)
	end
end
end


--if not infobottom then only get 2 datatexts (top of the screen + minimap)
if C.misc.infobottom == false then

local DataTextPosition = function(f, t, o)
	local ip = InfoPanel
	local mstat = MinimapStat
	
	if o >= 1 and o <= 20 then
		-- 1 to 3 use a default tukui panel, no need to update
		-- just update 4 to 6
		if o == 10 then
			t:ClearAllPoints()
			t:SetParent(mstat)
			t:SetHeight(mstat:GetHeight())
			t:SetPoint("CENTER", -1, 0)	
			t:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			t:SetShadowOffset(0,0)
		elseif o == 11 then
			t:ClearAllPoints()
			t:SetParent(ip)
			t:SetHeight(ip:GetHeight())
			t:SetPoint("CENTER", 0, 0)
			t:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			t:SetShadowOffset(0,0)
		end
	else
		-- hide everything that we don't use and enabled by default on tukui
		f:Hide()
		t:Hide()
	end
end

-- Tukui DataText List
local datatext = {
	"Guild",
	"Friends",
	"Gold",
	"FPS",
	"System",
	"Bags",
	"Gold",
	"Time",
	"Durability",
	"Heal",
	"Damage",
	"Power",
	"Haste",
	"Crit",
	"Avoidance",
	"Armor",
	"Currency",
	"Hit",
	"Mastery",
	"MicroMenu",
	"Regen",
	"Talent",
	"CallToArms",
}

-- Overwrite & Update Show/Hide/Position of all Datatext
for _, data in pairs(datatext) do
	local t = "TukuiStat"
	local frame = _G[t..data]
	local text = _G[t..data.."Text"]

	if frame and frame.Option then
		DataTextPosition(frame, text, frame.Option)
	end
end
end