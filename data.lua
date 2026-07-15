local mine = table.deepcopy(data.raw["land-mine"]["land-mine"])
local mine_item = {
    type = "item",
    name = "circuit-sensor-mine",
    icon = "__base__/graphics/icons/land-mine.png",
    icon_size = 64,
    place_result = "circuit-sensor-mine",
    stack_size = 50,
    subgroup = "circuit-network",
    order = "z-circuit-sensor-mine",
}
mine.name = "circuit-sensor-mine"
mine.force_die_on_attack = false
mine.timeout = 180
mine.minable.result = "circuit-sensor-mine"
mine.trigger_collision_mask =
{
    layers = {}
}
mine.action =
{
    type = "direct",
    action_delivery =
    {
    type = "instant",
    source_effects =
    {
        {
            type = "script",
            effect_id = "circuit-mine-fired"
        }
    }
    }
}

data:extend({mine, mine_item})