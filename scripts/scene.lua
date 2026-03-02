-- parent class for all scenes
scene = game_object:extend({
    -- switch to new scene if different from current
    load = function(_𝘦𝘯𝘷, new_scene)
        if new_scene != current then
            current = new_scene
            current:init()
        end
    end
})
