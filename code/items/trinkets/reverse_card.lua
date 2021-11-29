local reverseCard = {}
local id = Isaac.GetTrinketIdByName("Uno Reverse Card")

function reverseCard:onCardDrop(rng, card, playing, runes, runesOnly)
  local player = Isaac.GetPlayer(0)
  if player:HasTrinket(id) then
    if card >= Card.CARD_FOOL and card <= Card.CARD_WORLD then
      if rng:RandomInt(100) <= 15 then
        card = card + 55
      end
    end    
  end      

  return card
end

Cringebirth:AddCallback(ModCallbacks.MC_GET_CARD, reverseCard.onCardDrop)