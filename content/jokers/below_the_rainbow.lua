SMODS.Atlas {
    key  = 'below_the_rainbow',
    path = 'below_the_rainbow.png',
    px   = 71, 
    py   = 95, 
  }

SMODS.Joker {
    key = 'below_the_rainbow',
    atlas = 'below_the_rainbow',
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            destroyed_cards = 3
        },
    },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false, 
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.destroyed_cards  
            }
        }  
    end,
    calculate = function(self, card, context)
        if context.destroy_card then
            card.ability.extra.destroyed_cards = card.ability.extra.destroyed_cards - 1
            if card.ability.extra.destroyed_cards == 0 then
                card.ability.extra.destroyed_cards = 3
                local newcard = create_card({
                    set = 'Enhanced',
                    area = G.hand,
                    enhancement = "m_steel"
                })
                newcard:add_to_deck()
                G.hand:emplace(newcard)
                newcard:juice_up(.3,.5)
            end
        end
        if context.end_of_round and context.destroy_card then
            SMODS.destroy_cards(G.hand[1])
        end
    end
  }