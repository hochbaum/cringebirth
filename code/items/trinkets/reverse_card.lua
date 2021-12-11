--[[
  Uno Reverse Card causes tarot cards with a reverse form to have a chance of 15% to be replaced by their
  reversed form instead.
]]--
local reverseCard = {}
local id = Isaac.GetTrinketIdByName("Uno Reverse Card")

function reverseCard:onCardDrop(rng, card, playing, runes, runesOnly)
  local player = Isaac.GetPlayer(0)
  if player:HasTrinket(id) then
    -- Ignore every card which does not have a reverse form.
    if card >= Card.CARD_FOOL and card <= Card.CARD_WORLD then
      if rng:RandomInt(100) <= 15 then
        --[[
          Reverse tarot cards are in the exact same order as normal cards but the IDs use an
          offset of 55
        ]] --  
        card = card + 55
      end
    end    
  end      
  return card
end

Cringebirth:AddCallback(ModCallbacks.MC_GET_CARD, reverseCard.onCardDrop)