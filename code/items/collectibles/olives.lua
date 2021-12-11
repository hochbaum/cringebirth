require("code/task")
require("code/time")

--[[
  Bowl of Olives is a collectible item which replaces Isaac's tears with olives, based on his luck stat.
  At MAX_LUCK luck, every tear will be an olive.
  Olives cause hit enemies to become green, play a puke sound and spawn green creep below themselves.
]]--
local bowlOfOlives = {}
bowlOfOlives.MAX_LUCK = 11
bowlOfOlives.DURATION = seconds(3)
bowlOfOlives.TICK_RATE = ticks(1)

local id = Isaac.GetItemIdByName("Bowl of Olives")
local tearRng = RNG(Random(), 1)
local sfx = SFXManager()

function bowlOfOlives:onTearFire(tear)
  local player = Isaac.GetPlayer(0)
  if player:HasCollectible(id) then
    -- A very basic luck-stat-based calculation for whether or not an olive tear should be fired.
    if player.Luck + tearRng:RandomInt(bowlOfOlives.MAX_LUCK + 1) >= bowlOfOlives.MAX_LUCK then
      tear:SetColor(Color(1, 255, 1, 1, 0, 255, 0), bowlOfOlives.DURATION, 1, false, false)
      tear.TearFlags = TearFlags.TEAR_MYSTERIOUS_LIQUID_CREEP
      
      -- Mark the tear as olive for the collision check.
      tear:GetData()["IsOlive"] = true
    end  
  end  
end

-- Spawn the creep periodically.
Timer.Task(TimerMode.REPEATING, 1, function()
  -- TODO: Spawn creep below affected enemies.
end)

function bowlOfOlives:onTearHit(tear, collider, low)
  -- Make sure the tear is an olive.
  if tear:GetData()["IsOlive"] then
    sfx:Play(SoundEffect.SOUND_PESTILENCE_NECK_PUKE)
    collider:SetColor(Color(1, 255, 1, 1, 0, 255, 0), bowlOfOlives.DURATION, 1, false, false)
    
    -- OliveTicks determines how many frames the entity feels sick.
    collider:GetData()["OliveFrames"] = bowlOfOlives.DURATION
  end  
end

Cringebirth:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, bowlOfOlives.onTearFire)
Cringebirth:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, bowlOfOlives.onTearHit)