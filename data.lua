local mine = table.deepcopy(data.raw["land-mine"]["land-mine"])
local mine_item = {
    type = "item",
    name = "scratch-test-mine",
    icon = "__base__/graphics/icons/land-mine.png",
    icon_size = 64,
    place_result = "scratch-test-mine",
    stack_size = 50
}
mine.name = "scratch-test-mine"
mine.force_die_on_attack = false
mine.trigger_interval = 600
mine.timeout = 600
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
            effect_id = "scratch-mine-fired"
        }
    }
    }
}
data:extend({ mine, mine_item })

