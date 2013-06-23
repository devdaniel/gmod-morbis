--[[ MORBUS DEVELOPED BY REMSCAR ]]--

function util.GetAlivePlayers()
	local alive = {}

	for k, p in pairs(player.GetAll()) do
		if IsValid(p) and p:Alive() and (p:Team() != TEAM_SPEC) then
			table.insert(alive, p)
		end
	end

	return alive
end

local exp = math.exp

-- Equivalent to ExponentialDecay from Source's mathlib.
-- Convenient for falloff curves.
function math.ExponentialDecay(halflife, dt)
	-- ln(0.5) = -0.69..
	return exp((-0.69314718 / halflife) * dt)
end

function util.GetNextAlivePlayer(ply)
	local alive = util.GetAlivePlayers()

	if #alive < 1 then
		return nil
	end

	local prev = nil
	local choice = nil

	if IsValid(ply) then
		for k,p in pairs(alive) do
			if prev == ply then
				choice = p
			end
			prev = p
		end
	end

	if not IsValid(choice) then
		choice = alive[1]
	end

	return choice
end

function util.PaintDown(start, effname, ignore)
	local btr = util.TraceLine({start=start, endpos=(start + Vector(0,0,-256)), filter=ignore, mask=MASK_SOLID})

	util.Decal(effname, btr.HitPos+btr.HitNormal, btr.HitPos-btr.HitNormal)
end

local function DoBleed(ent)
	if not IsValid(ent) or (ent:IsPlayer() and (not ent:Alive() or not ent:IsGame())) then
		return
	end

	local jitter = VectorRand() * 30
	jitter.z = 20

	util.PaintDown(ent:GetPos() + jitter, "Blood", ent)
end

function util.StartBleeding(ent, dmg, t)
	if dmg < 5 or not IsValid(ent) then
		return
	end

	if ent:IsPlayer() and (not ent:Alive() or not ent:IsGame()) then
		return
	end

	local times = math.Clamp(math.Round(dmg / 5), 1, 20)
	local delay = math.Clamp(t / times , 0.1, 2)

	if ent:IsPlayer() then
		times = times * 2
		delay = delay / 2
	end

	timer.Create("bleed" .. ent:EntIndex(), delay, times, function() DoBleed(ent) end)
end
