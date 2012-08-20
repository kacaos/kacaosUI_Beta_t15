local T, C, L, G = unpack(Tukui)
if not C.misc.datapanels == true then return end

--------------------------------------------------------------
-- create datapanels
--------------------------------------------------------------
local data = CreateFrame("Frame", "Data", UIParent)
for i = 1, 5 do
	data[i] = CreateFrame("Frame", "data"..i, UIParent)
	data[i]:SetTemplate("Default")
	data[i]:Height(15)
	data[i]:Width(90)
	if i == 1 then
		data[i]:Point("TOPLEFT", UIParent, "TOPLEFT", 3, -3)
	elseif i == 2 then
		data[i]:Point("TOPRIGHT", data1, "BOTTOMRIGHT", 0, -1)
	elseif i == 3 then
		data[i]:Point("TOPRIGHT", data2, "BOTTOMRIGHT", 0, -1)
	elseif i == 4 then
		data[i]:Point("TOPRIGHT", data3, "BOTTOMRIGHT", 0, -1)
	elseif i == 5 then
		data[i]:Point("TOPRIGHT", data4, "BOTTOMRIGHT", 0, -1)
	end
end

-------------------------------------------------------------
-- set datatext points in datapanels
-------------------------------------------------------------
local DataTextPosition = function(f, t, o)
	
	if o >= 1 and o <= 20 then
		-- 1 to 3 use a default tukui panel, no need to update
		-- just update 4 to 6
		if o == 15 then
			t:ClearAllPoints()
			t:SetParent(data1)
			t:SetHeight(data1:GetHeight())
			t:SetPoint("CENTER", 0, 0)	
			t:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			t:SetShadowOffset(0,0)
		elseif o == 16 then
			t:ClearAllPoints()
			t:SetParent(data2)
			t:SetHeight(data2:GetHeight())
			t:SetPoint("CENTER", 0, 0)
			t:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			t:SetShadowOffset(0,0)
		elseif o == 17 then
			t:ClearAllPoints()
			t:SetParent(data3)
			t:SetHeight(data3:GetHeight())
			t:SetPoint("CENTER", 0, 0)
			t:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			t:SetShadowOffset(0,0)
		elseif o == 18 then
			t:ClearAllPoints()
			t:SetParent(data4)
			t:SetHeight(data4:GetHeight())
			t:SetPoint("CENTER", 0, 0)
			t:SetFont(C.media.pixelfont, 8, "MONOCHROMEOUTLINE")
			t:SetShadowOffset(0,0)
		elseif o == 19 then
			t:ClearAllPoints()
			t:SetParent(data5)
			t:SetHeight(data5:GetHeight())
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

-----------------------------------------------------
-- set tooltip for datatext
-----------------------------------------------------
T.DataTextTooltipAnchor = function(self)
	local panel = self:GetParent()
	local anchor = "ANCHOR_TOPRIGHT"
	local xoff = 5
	local yoff = 15
	
	if panel == data[i] then
		anchor = "ANCHOR_TOPRIGHT"
		yoff = 15
		xoff = 5
	elseif panel == data1 then
		anchor = "ANCHOR_BOTTOMRIGHT"
		yoff = 15
		xoff = 5
	elseif panel == data2 then
		anchor = "ANCHOR_BOTTOMRIGHT"
		yoff = 31
		xoff = 5
	elseif panel == data3 then
		anchor = "ANCHOR_BOTTOMRIGHT"
		yoff = 47
		xoff = 5
	elseif panel == data4 then
		anchor = "ANCHOR_BOTTOMRIGHT"
		yoff = 63
		xoff = 5
	elseif panel == data5 then
		anchor = "ANCHOR_BOTTOMRIGHT"
		yoff = 79
		xoff = 5
	end
	return anchor, panel, xoff, yoff
end