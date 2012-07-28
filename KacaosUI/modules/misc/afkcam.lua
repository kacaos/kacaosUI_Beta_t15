local T, C, L = unpack(Tukui)
if not C.misc.afkcam then return end

local AFKSpinCam = CreateFrame("Frame")

local OnEvent = function(self, event, unit)
	if event == "PLAYER_FLAGS_CHANGED" then
		if unit == "player" then
			if UnitIsAFK(unit) then
				SpinStart()
			else
				SpinStop()
			end
		end
	elseif event == "PLAYER_LEAVING_WORLD" then
		SpinStop()
	end
end
AFKSpinCam:RegisterEvent("PLAYER_ENTERING_WORLD")
AFKSpinCam:RegisterEvent("PLAYER_LEAVING_WORLD")
AFKSpinCam:RegisterEvent("PLAYER_FLAGS_CHANGED")
AFKSpinCam:SetScript("OnEvent", OnEvent)

function SpinStart()
	spinning = true
	MoveViewRightStart(0.1)
	--UIParent:Hide()
end

function SpinStop()
	if not spinning then return end
	spinning = nil
	MoveViewRightStop()
	--UIParent:Show()
end