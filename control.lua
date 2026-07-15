script.on_event(defines.events.on_script_trigger_effect, function(event)
    if event.effect_id == "circuit-mine-fired" then
        game.print("Circuit sensor mine fired at tick " .. event.tick)
        if event.source_entity and event.source_entity.valid then
            game.print("Source entity: " .. event.source_entity.name)
            game.print("Unit number: " .. event.source_entity.unit_number)
            if event.source_entity.name == "circuit-sensor-mine" then
                game.print("Congratulations! I'm a circuit-sensor-mine!")
                event.source_entity.timeout = 180
            end
        end
    end
end)