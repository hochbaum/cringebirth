Cringebirth:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, function(_, wasContinued)
    local player = Isaac.GetPlayer(0)
    if not wasContinued and player:GetName() == "Julie" then
        player:AddTrinket(TrinketType.TRINKET_LIBERTY_CAP)
    end
end)