
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
      leg_movement_speed = 1.8,
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
          spiderbot_mk2_prototype.guns = nil
          spiderbot_mk2_prototype.inventory_size = 10  -- Add inventory
          spiderbot_mk2_prototype.trash_inventory_size = 5
          spiderbot_mk2_prototype.equipment_grid = "spiderbot-mk2-equipment-grid"  -- Add equipment grid
          spiderbot_mk2_prototype.allow_passengers = false
          spiderbot_mk2_prototype.is_military_target = false
          spiderbot_mk2_prototype.se_allow_in_space = true  -- Space Exploration compatibility
          
          -- Speed and movement adjustments
          spiderbot_mk2_prototype.torso_rotation_speed = spiderbot_mk2_prototype.torso_rotation_speed * 1.5
          spiderbot_mk2_prototype.torso_bob_speed = 0.5
          spiderbot_mk2_prototype.chunk_exploration_radius = 2
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