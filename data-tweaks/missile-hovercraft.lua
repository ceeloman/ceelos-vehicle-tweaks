local tons = 1000 -- 1 ton = 1000 weight units

-- Check if the item exists, then modify it
local missile_hovercraft_item = data.raw["item-with-entity-data"]["missile-hovercraft"]
if missile_hovercraft_item then
    missile_hovercraft_item.weight = 1000 * tons -- set to 0.8 tons
end