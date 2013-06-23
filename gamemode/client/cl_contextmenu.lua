--[[ MORBUS DEVELOPED BY REMSCAR ]]--

-- LOCALIZATION
local math = math
local table = table
local umsg = umsg
local player = player
local timer = timer
local pairs = pairs
local umsg = umsg
local usermessage = usermessage
local file = file

function GM:OnContextMenuOpen( )
	if GetRoundState() == ROUND_WAIT then
		return
	end
	if (GetRoundState() != ROUND_ACTIVE) && (RoundHistory["First"] != nil) then
		OPEN_RHISTORY()
		return
	end
	if LocalPlayer():IsBrood() then
		if pUpgradesMenu && pUpgradesMenu:IsValid() then
			pUpgradesMenu:Remove()
		end
		if pDescriptionBox then
			pDescriptionBox:Remove()
		end
		CreateUpgradesMenu()
	end
end
