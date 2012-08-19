local T, C, L, G = unpack(Tukui)
if not C.actionbar.enable == true then return end
if C.actionbar.style ~= 2 then return end

local bar = G.ActionBars.Stance
bar:HookScript("OnEvent", function(self, event, unit)
	if event == "PLAYER_ENTERING_WORLD" then
		
		for i = 1, NUM_STANCE_SLOTS do
		local button = _G["StanceButton"..i]
			button:Size(T.buttonsize, T.buttonsize)
			button:SetFrameStrata("LOW")
			if i ~= 1 then
				local previous = _G["StanceButton"..i-1]
				button:SetPoint("LEFT", previous, "RIGHT", T.buttonspacing, 0)
			end
			local _, name = GetShapeshiftFormInfo(i)
			if name then
				button:Show()
			else
				button:Hide()
			end
			
		G.ActionBars.Stance["Button"..i] = button
	
		end
	end
end)