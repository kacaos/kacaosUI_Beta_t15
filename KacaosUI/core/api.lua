local T, C, L = unpack(Tukui)
local oUF = oUFTukui or oUF

---------------------------------------------------------
--oUF name Tag function
---------------------------------------------------------

-- new name tag for smaller name in dpslayout
local utf7sub = function(string, i, dots)
	if not string then return end
	local bytes = string:len()
	if (bytes <= i) then
		return string
	else
		local len, pos = 0, 1
		while(pos <= bytes) do
			len = len + 1
			local c = string:byte(pos)
			if (c > 0 and c <= 127) then
				pos = pos + 1
			elseif (c >= 192 and c <= 223) then
				pos = pos + 2
			elseif (c >= 224 and c <= 239) then
				pos = pos + 3
			elseif (c >= 240 and c <= 247) then
				pos = pos + 4
			end
			if (len == i) then break end
		end

		if (len == i and pos <= bytes) then
			return string:sub(1, pos - 1)..(dots and '...' or '')
		else
			return string
		end
	end
end

oUF.Tags.Events['Tukui:namemini'] = 'UNIT_NAME_UPDATE'
oUF.Tags.Methods['Tukui:namemini'] = function(unit)
	local name = UnitName(unit)
	return utf7sub(name, 3, false)
end
--------------------------------------------------------
-- Api
--------------------------------------------------------
local function CreateBorder(f, i, o)
	if i then
		if f.iborder then return end
		local border = CreateFrame("Frame", f:GetName() and f:GetName() .. "InnerBorder" or nil, f)
		border:Point("TOPLEFT", T.mult, -T.mult)
		border:Point("BOTTOMRIGHT", -T.mult, T.mult)
		border:SetBackdrop({
		edgeFile = C["media"].blank,
		edgeSize = T.mult,
		insets = { left = T.mult, right = T.mult, top = T.mult, bottom = T.mult }
		})
		border:SetBackdropBorderColor(unpack(C["media"].backdropcolor))
		f.iborder = border
	end

	if o then
		if f.oborder then return end
		local border = CreateFrame("Frame", f:GetName() and f:GetName() .. "OuterBorder" or nil, f)
		border:Point("TOPLEFT", -T.mult, T.mult)
		border:Point("BOTTOMRIGHT", T.mult, -T.mult)
		border:SetFrameLevel(f:GetFrameLevel() + 1)
		border:SetBackdrop({
		edgeFile = C["media"].blank,
		edgeSize = T.mult,
		insets = { left = T.mult, right = T.mult, top = T.mult, bottom = T.mult }
		})
		border:SetBackdropBorderColor(unpack(C["media"].backdropcolor))
		f.oborder = border
	end
end

local function SetBorder(f)
	if f:GetFrameStrata() == "BACKGROUND" then f:SetFrameStrata("LOW") end
	f:SetBackdropColor(.075, .075, .075, 0.7)
	f:SetBackdropBorderColor(unpack(C["media"].bordercolor))
	local border = CreateFrame("Frame", nil, f)
	border:SetPoint("TOPLEFT", f, "TOPLEFT", T.Scale(-1), T.Scale(1))
	border:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", T.Scale(1), T.Scale(-1))
	border:SetFrameStrata("BACKGROUND")
	border:SetFrameLevel(1)
	border:SetBackdrop { edgeFile = C["media"].blank, edgeSize = T.Scale(3), insets = {left = 0, right = 0, top = 0, bottom = 0} }
	border:SetBackdropColor(unpack(C["media"].backdropcolor))
	border:SetBackdropBorderColor(unpack(C["media"].backdropcolor))
end

local function AllPoints(obj, frame, inset)
if not inset then inset = 0 end
obj:SetPoint("TOPLEFT", frame, "TOPLEFT", inset, -inset)
obj:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -inset, inset)
end

local function CreateOverlay(f)
if f.overlay then return end

	local overlay = f:CreateTexture(f:GetName() and f:GetName().."Overlay" or nil, "BORDER", f)
	overlay:ClearAllPoints()
	overlay:Point("TOPLEFT", 2, -2)
	overlay:Point("BOTTOMRIGHT", -2, 2)
	overlay:SetTexture(C.media.blank)
	overlay:SetVertexColor(.05, .05, .05)
	f.overlay = overlay
end

local function FadeIn(f)
UIFrameFadeIn(f, .4, f:GetAlpha(), 1)
end

local function FadeOut(f)
UIFrameFadeOut(f, .8, f:GetAlpha(), 0)
end

local function OnMouseOver(bar, button, num, baralpha, fadealpha)
	if bar and bar:IsShown() then
		if not bar:EnableMouse() == true then
		bar:EnableMouse(true)
	end
		bar:SetAlpha(baralpha)
		bar:SetScript("OnEnter", function(self) self:SetAlpha(fadealpha) end)
		bar:SetScript("OnLeave", function(self) self:SetAlpha(baralpha) end)

	for i = 1, num do
		local btn = _G[button..i]
		btn:SetScript("OnEnter", function() bar:SetAlpha(fadealpha) end)
		btn:SetScript("OnLeave", function() bar:SetAlpha(baralpha) end)
		end
	end
end

local function innerBorder(f)
	if f.innerborder then f.innerborder:Show() return end
	f.innerborder = CreateFrame("Frame", nil, f)
	f.innerborder:SetPoint("TOPLEFT", 1, -1)
	f.innerborder:SetPoint("BOTTOMRIGHT", -1, 1)
	f.innerborder:SetBackdrop({
		edgeFile = C["media"].blank, 
		edgeSize = 1, 
		insets = { left = 1, right = 1, top = 1, bottom = 1 }
	})
	f.innerborder:SetBackdropBorderColor(0,0,0)

end

local function outerBorder(f)
	if f.outerborder then f.outerborder:Show() return end
	f.outerborder = CreateFrame("Frame", nil, f)
	f.outerborder:SetPoint("TOPLEFT", -1, 1)
	f.outerborder:SetPoint("BOTTOMRIGHT", 1, -1)
	f.outerborder:SetBackdrop({
		edgeFile = C["media"].blank, 
		edgeSize = 1, 
		insets = { left = 1, right = 1, top = 1, bottom = 1 }
	})
	f.outerborder:SetBackdropBorderColor(0,0,0)

end

local function ThickBorder(f, force)
	if f.backdrop and not force then
		outerBorder(f)
		innerBorder(f)
	end
end

-- Now easier to create borders *_*
local function AddBorder(f)
	local frame = CreateFrame("Frame", nil, f)
	frame:Point("TOPLEFT", f, "TOPLEFT", -1, 1)
	frame:Point("BOTTOMRIGHT", f, "BOTTOMRIGHT", 1, -1)
	frame:SetTemplate("Default")
	frame:SetFrameLevel(f:GetFrameLevel())
	f.Border = frame
end


local function addapi(object)
	local mt = getmetatable(object).__index
	if not object.CreateBorder then mt.CreateBorder = CreateBorder end
	if not object.SetBorder then mt.SetBorder = SetBorder end
	if not object.AllPoints then mt.AllPoints = AllPoints end
	if not object.CreateOverlay then mt.CreateOverlay = CreateOverlay end
	if not object.FadeIn then mt.FadeIn = FadeIn end
	if not object.FadeOut then mt.FadeOut = FadeOut end
	if not object.OnMouseOver then mt.OnMouseOver = OnMouseOver end
	if not object.ThickBorder then mt.ThickBorder = ThickBorder end
	if not object.InnerBorder then mt.Innerborder = innerBorder end
	if not object.OuterBorder then mt.Outerborder = outerBorder end
	if not object.AddBorder then mt.AddBorder = AddBorder end
end

local handled = {["Frame"] = true}
local object = CreateFrame("Frame")
addapi(object)
addapi(object:CreateTexture())
addapi(object:CreateFontString())

object = EnumerateFrames()
while object do
	if not handled[object:GetObjectType()] then
	addapi(object)
	handled[object:GetObjectType()] = true
end

	object = EnumerateFrames(object)
end