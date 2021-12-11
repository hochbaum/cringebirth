--[[
  Red Map is a collectible item which always marks the Ultra Secret Room on Isaac's map.
]]--
local redMap = {}

local id = Isaac.GetItemIdByName("Red Map")
 
function redMap:markUltraSecretRoom()
  if not hasRedMap() then
    return
  end  
  
  local level = Game():GetLevel()
  
  -- Loops through every room on the current floor.
  for i = 0, 13 * 13 do
    local room = level:GetRoomByIdx(i)
    if room.Data and room.Data.Type == RoomType.ROOM_ULTRASECRET then
      room.DisplayFlags = room.DisplayFlags | 1 << 2 -- 0b100
      level:UpdateVisibility()
      break
    end  
  end
end

function hasRedMap()
  local player = Isaac.GetPlayer(0)
  return player:HasCollectible(id)
end  

Cringebirth:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, redMap.markUltraSecretRoom)
Cringebirth:AddCallback(ModCallbacks.MC_POST_UPDATE, redMap.markUltraSecretRoom)