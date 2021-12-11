local bowlOfOlives = {}
bowlOfOlives.MAX_LUCK = 11
bowlOfOlives.DURATION = 60 * 3

local id = Isaac.GetItemIdByName("Bowl of Olives")
local tearRng = RNG(Random(), 1)
local sfx = SFXManager()

function bowlOfOlives:onTearFire(tear)
  local player = Isaac.GetPlayer(0)
  if player:HasCollectible(id) then
    if player.Luck + tearRng:RandomInt(bowlOfOlives.MAX_LUCK + 1) >= bowlOfOlives.MAX_LUCK then
      tear:SetColor(Color(1, 255, 1, 1, 0, 255, 0), 2000, 1, false, false)
      tear.TearFlags = TearFlags.TEAR_MYSTERIOUS_LIQUID_CREEP
      tear:GetData()["IsOlive"] = true
    end  
  end  
end

require("code/task")

Timer.Task(SchedulerMode.REPEATING, 60, function()
  -- TODO: Spawn creep below affected enemies.
end)

function bowlOfOlives:onTearHit(tear, collider, low)
  if tear:GetData()["IsOlive"] then
    collider:SetColor(Color(1, 255, 1, 1, 0, 255, 0), bowlOfOlives.DURATION, 1, false, false)
    collider:GetData()["OliveTicks"] = bowlOfOlives.DURATION
    sfx:Play(SoundEffect.SOUND_PESTILENCE_NECK_PUKE)
  end  
end

Cringebirth:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, bowlOfOlives.onTearFire)
Cringebirth:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, bowlOfOlives.onTearHit)