local redMap = {}
local id = Isaac.GetItemIdByName("Red Map")

function redMap:postNewRoom()
  if hasRedMap() then
    markUltraSecretRoom()
  end
end  

function redMap:postUpdate()
  if hasRedMap() then
    markUltraSecretRoom()
  end 
end  

function markUltraSecretRoom()
  local level = Game():GetLevel()
  for i = 0, 169 do
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

Cringebirth:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, redMap.postNewRoom)
Cringebirth:AddCallback(ModCallbacks.MC_POST_UPDATE, redMap.postUpdate)