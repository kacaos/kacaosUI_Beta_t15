local T, C, L, G = unpack(Tukui)

local f = CreateFrame("Frame", "TukuiMerchant")
f:SetScript("OnEvent", function()

if not IsShiftKeyDown() then
		if CanMerchantRepair() and C.merchant.autoguildrepair then
			guildRepairFlag = 0
			local cost, possible = GetRepairAllCost()
			if IsInGuild() and CanGuildBankRepair() and C.merchant.autoguildrepair then
				if cost <= GetGuildBankWithdrawMoney() then
					guildRepairFlag = 1
				end
			end
			if cost > 0 then
				if possible or guildRepairFlag then
					RepairAllItems(guildRepairFlag)
					local c = cost%100
					local s = math.floor((cost%10000)/100)
					local g = math.floor(cost/10000)
					if guildRepairFlag == 1 then
						DEFAULT_CHAT_FRAME:AddMessage(L.merchant_repaircost.." ("..L.datatext_guild..") |cffffffff"..g..L.goldabbrev.." |cffffffff"..s..L.silverabbrev.." |cffffffff"..c..L.copperabbrev..".", 255, 255, 0)
					else
						DEFAULT_CHAT_FRAME:AddMessage(L.merchant_repaircost.." |cffffffff"..g..L.goldabbrev.." |cffffffff"..s..L.silverabbrev.." |cffffffff"..c..L.copperabbrev..".", 255, 255, 0)
					end
				else
					DEFAULT_CHAT_FRAME:AddMessage(L.merchant_repairnomoney, 255, 0, 0)
				end
			end
		end
	end
end)

f:RegisterEvent("MERCHANT_SHOW")