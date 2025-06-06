
-- SpiderBot MK2 - Tweaked version of SpiderBots with inventory and equipment grid
-- Extension mod by Ceeloman
-- Based on SpiderBots © 2023-2025 by asher_sky (licensed under CC BY-NC-SA 4.0)
-- This derivative work is also licensed under CC BY-NC-SA 4.0

-- Create equipment grid for the MK2 variant
local spiderbot_mk2_equipment_grid = {
    type = "equipment-grid",
    name = "spiderbot-mk2-equipment-grid",
    width = 6,
    height = 6,
    equipment_categories = {"armor"}
  }
  data:extend{spiderbot_mk2_equipment_grid}
  
  -- Create the MK2 variant based on the original spiderbot
  local spiderbot_mk2_arguments = {
      scale = 0.3,  -- Slightly bigger than original
      leg_scale = 0.9,
      name = "spiderbot-mk2",
      leg_thickness = 1.5,
      leg_movement_speed = 2.1,
  }
  
  -- Check if spiderbots mod is installed and create_spidertron function exists
  if mods["spiderbots"] and _G.create_spidertron then
      -- Create the spiderbot mk2 using the same function
      create_spidertron(spiderbot_mk2_arguments)
      
      -- Get the prototype and modify it
      local spiderbot_mk2_prototype = data.raw["spider-vehicle"]["spiderbot-mk2"]
      
      -- If the prototype was created successfully
      if spiderbot_mk2_prototype then
          -- Set basic properties
          spiderbot_mk2_prototype.minable.result = "spiderbot-mk2"
          spiderbot_mk2_prototype.placeable_by = { item = "spiderbot-mk2", count = 1 }
          --spiderbot_mk2_prototype.guns = nil
          spiderbot_mk2_prototype.inventory_size = 10  -- Add inventory
          spiderbot_mk2_prototype.trash_inventory_size = 5
          spiderbot_mk2_prototype.equipment_grid = "spiderbot-mk2-equipment-grid"  -- Add equipment grid
          spiderbot_mk2_prototype.allow_passengers = false
          spiderbot_mk2_prototype.is_military_target = false
          spiderbot_mk2_prototype.se_allow_in_space = true  -- Space Exploration compatibility
          spiderbot_mk2_prototype.guns = {"spiderdrone-machine-gun-1"}
          
          -- Speed and movement adjustments
          spiderbot_mk2_prototype.torso_rotation_speed = spiderbot_mk2_prototype.torso_rotation_speed * 1.5
          spiderbot_mk2_prototype.torso_bob_speed = 0.5
          spiderbot_mk2_prototype.chunk_exploration_radius = 3
          spiderbot_mk2_prototype.minable.mining_time = 0.5
            
          -- Adjust the legs to match the original mod's configuration
          local legs = spiderbot_mk2_prototype.spider_engine.legs
          if legs[1] then
              for _, leg in pairs(legs) do
                  local leg_name = leg.leg
                  local leg_prototype = data.raw["spider-leg"][leg_name]
                  if leg_prototype then
                      leg_prototype.localised_name = { "entity-name.spiderbot-mk2-leg" }
                      leg_prototype.walking_sound_volume_modifier = 0.2
                      leg_prototype.collision_mask = {
                          layers = {
                              water_tile = true,
                              rail = true,
                              ghost = true,
                              object = true,
                              empty_space = true,
                              lava_tile = true,
                              rail_support = true,
                              cliff = true,
                              spiderbot_leg = true,
                          },
                          not_colliding_with_itself = true,
                          consider_tile_transitions = false,
                          colliding_with_tiles_only = false,
                      }
                  end
              end
          end
          
          -- Create item
          local spidertron_item = table.deepcopy(data.raw["item-with-entity-data"]["spidertron"])
          local spiderbot_mk2_item = {
              type = "item-with-entity-data",  -- Changed from capsule to item-with-entity-data
              name = "spiderbot-mk2",
              icon = spidertron_item.icon,
              icon_size = spidertron_item.icon_size,
              icon_mipmaps = 4,
              stack_size = 10,
              subgroup = "logistic-network",
              order = "a[robot]-c[spiderbot-mk2]",
              place_result = "spiderbot-mk2",
          }
          
          -- Create recipe
          local spiderbot_mk2_recipe = {
              type = "recipe",
              name = "spiderbot-mk2",
              enabled = false,
              energy_required = 10,
              ingredients = {
                  { type = "item", name = "spiderbot", amount = 1 },
              },
              results = {
                  { type = "item", name = "spiderbot-mk2", amount = 1 }
              }
          }
          
          --[[Create technology
          local spiderbot_mk2_technology = {
              type = "technology",
              name = "spiderbot-mk2",
              icon = "__ceelos-vehicle-tweaks__/assets/spiderbot_technology.png",
              icon_size = 256,
              effects = {
                  {
                      type = "unlock-recipe",
                      recipe = "spiderbot-mk2"
                  }
              },
              prerequisites = { "spiderbots" },
              unit = {
                  count = 150,
                  ingredients = {
                      { "automation-science-pack", 1 },
                      { "logistic-science-pack", 1 },
                      { "chemical-science-pack", 1 }
                  },
                  time = 30
              }
          }
              ]]

            if data.raw.technology["spiderbots"] then
                table.insert(data.raw.technology["spiderbots"].effects, {
                    type = "unlock-recipe",
                    recipe = "spiderbot-mk2"
                })
            end
          
          -- Extend all the new prototypes
          data:extend{
              spiderbot_mk2_prototype,
              spiderbot_mk2_item,
              spiderbot_mk2_recipe,
              --spiderbot_mk2_technology
          }
      end
  end

-- Create Constructbot, identical to spiderbot-mk2 except for name and recipe
local constructbot_arguments = {
    scale = 0.3,
    leg_scale = 0.9,
    name = "Constructbot",
    leg_thickness = 1.5,
    leg_movement_speed = 2.1,
}

if mods["spiderbots"] and _G.create_spidertron then
    create_spidertron(constructbot_arguments)

    local constructbot_prototype = data.raw["spider-vehicle"]["Constructbot"]
    if constructbot_prototype then
        -- Copy spiderbot-mk2 properties exactly
        constructbot_prototype.minable = { mining_time = 0.5, result = "Constructbot" }
        constructbot_prototype.placeable_by = { item = "Constructbot", count = 1 }
        constructbot_prototype.inventory_size = 10
        constructbot_prototype.trash_inventory_size = 5
        constructbot_prototype.equipment_grid = "spiderbot-mk2-equipment-grid"
        constructbot_prototype.allow_passengers = false
        constructbot_prototype.is_military_target = false
        constructbot_prototype.se_allow_in_space = true
        constructbot_prototype.guns = {"spiderdrone-machine-gun-1"}
        constructbot_prototype.torso_rotation_speed = constructbot_prototype.torso_rotation_speed * 1.5
        constructbot_prototype.torso_bob_speed = 0.5
        constructbot_prototype.chunk_exploration_radius = 3

        -- Copy leg properties
        local legs = constructbot_prototype.spider_engine.legs
        if legs[1] then
            for _, leg in pairs(legs) do
                local leg_name = leg.leg
                local leg_prototype = data.raw["spider-leg"][leg_name]
                if leg_prototype then
                    leg_prototype.localised_name = { "entity-name.Constructbot-leg" }
                    leg_prototype.walking_sound_volume_modifier = 0.2
                    leg_prototype.collision_mask = {
                        layers = {
                            water_tile = true,
                            rail = true,
                            ghost = true,
                            object = true,
                            empty_space = true,
                            lava_tile = true,
                            rail_support = true,
                            cliff = true,
                            spiderbot_leg = true,
                        },
                        not_colliding_with_itself = true,
                        consider_tile_transitions = false,
                        colliding_with_tiles_only = false,
                    }
                end
            end
        end

        -- Create item
        local spidertron_item = data.raw["item-with-entity-data"]["spidertron"]
        local constructbot_item = {
            type = "item-with-entity-data",
            name = "Constructbot",
            icon = spidertron_item.icon,
            icon_size = spidertron_item.icon_size,
            icon_mipmaps = 4,
            stack_size = 10,
            subgroup = "logistic-network",
            order = "a[robot]-d[Constructbot]",
            place_result = "Constructbot",
        }

        -- Create recipe
        local constructbot_recipe = {
            type = "recipe",
            name = "Constructbot",
            enabled = false,
            energy_required = 10,
            ingredients = {
                { type = "item", name = "spiderbot-mk2", amount = 1 },
            },
            results = {
                { type = "item", name = "Constructbot", amount = 1 },
            },
        }

        -- Unlock recipe in spiderbots technology
        if data.raw.technology["spiderbots"] then
            table.insert(data.raw.technology["spiderbots"].effects, {
                type = "unlock-recipe",
                recipe = "Constructbot",
            })
        end

        data:extend{
            constructbot_prototype,
            constructbot_item,
            constructbot_recipe,
        }
    end
end

-- Remove constructron_service_station from spidertron technology
if data.raw.technology["spidertron"] then
    for i, effect in pairs(data.raw.technology["spidertron"].effects or {}) do
        if effect.type == "unlock-recipe" and effect.recipe == "service_station" then
            table.remove(data.raw.technology["spidertron"].effects, i)
            break
        end
    end
end

-- Add constructron_service_station to construction-robotics and logistic-robotics
local tech_prerequisites = { "construction-robotics", "logistic-robotics" }
for _, tech_name in pairs(tech_prerequisites) do
    if data.raw.technology[tech_name] then
        data.raw.technology[tech_name].effects = data.raw.technology[tech_name].effects or {}
        table.insert(data.raw.technology[tech_name].effects, {
            type = "unlock-recipe",
            recipe = "service_station",
        })
    end
end