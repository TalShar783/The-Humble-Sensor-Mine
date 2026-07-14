script.on_event(defines.events.on_script_trigger_effect, function(event)
    if event.effect_id == "scratch-mine-fired" then
        game.print("Scratch mine fired at tick " .. event.tick)
    end
end)
