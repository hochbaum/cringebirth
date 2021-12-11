--[[
  Returns n seconds as frames.
]]--
function seconds(n) 
  return n * 60 
end

--[[
  Returns n minutes as frames.
]]--
function minutes(n)
  return n * seconds(60)
end

--[[
  Returns n ticks as frames.
  (1 second = 20 ticks)
]]--  
function ticks(n)
  return n * 3
end