---------------------------------LOCALIZATION
local math = math
local table = table
local umsg = umsg
local player = player
local timer = timer
local pairs = pairs
local umsg = umsg
local usermessage = usermessage
local file = file
---------------------------------------------

pScoreBoard = nil

local ShowScoreboard = false

function GM:CreateScoreboard()
	pScoreBoard = vgui.Create("MScoreboard")
end

function GM:ScoreboardShow()
	GAMEMODE.ShowScoreboard = true

	gui.EnableScreenClicker(true)

	SB_status = true	

	if not pScoreBoard then
		self:CreateScoreboard()
	end

	pScoreBoard.Status = true
	pScoreBoard:SetVisible(true)
end

function GM:ScoreboardHide()

	GAMEMODE.ShowScoreboard = false
	
	SB_status = false

	gui.EnableScreenClicker(false)

	pScoreBoard.Status = false
	pScoreBoard:SetVisible(false)
end

function GM:GetScoreboardPanel()
	if pScoreBoard then
		return pScoreBoard
	end
end

function GM:HUDDrawScoreBoard()
	return false
end

function GM:PostRenderVGUI()
end

