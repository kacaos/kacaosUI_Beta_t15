local T, C, L = unpack(Tukui)

if( C["bags"].enable ~= true ) then return end

TukuiBags:ClearAllPoints()
TukuiBags:SetPoint( "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -6, 143)

local function BagsPosition( self, value )
	local bag = _G["Tukui" .. value]
	if( value == "Bank" ) then
		bag:ClearAllPoints()
		bag:SetPoint( "BOTTOMLEFT", UIParent, "BOTTOMLEFT", 3, 118)
		bag:SetMovable(true)
		bag:SetScript("OnMouseDown", function() bag:ClearAllPoints() bag:StartMoving() end)
		bag:SetScript("OnMouseUp", function() bag:StopMovingOrSizing() end)
	end
end

hooksecurefunc( Stuffing, "CreateBagFrame", BagsPosition )