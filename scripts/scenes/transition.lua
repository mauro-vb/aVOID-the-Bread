transition = game_object:extend({
    frames = 30,
    c = 0,
    n = 16,
    spd = .3,
    current_size = 0,
    fsize = 8,
    circles = {},
    shrink = false,
    init = function(_𝘦𝘯𝘷)
        global.trans = _𝘦𝘯𝘷
        for i = 1, n do
            for j = 1, n do
                local circle = { x = (i - 1) * 128 / (n - 1), y = (j - 1) * 128 / (n - 1), r = 0, c = c }
                add(circles, circle)
            end
        end
    end,
    upd = function(_𝘦𝘯𝘷)
        current_size = shrinking and current_size - spd or current_size + spd
        for circle in all(circles) do
            circle.r = current_size
        end
        if current_size >= fsize then
            shrinking = true
            global.scene:load(new_scene)
            --global.paused = true
        end
        if current_size <= 0 then global.paused = false end
    end,
    drw = function(_𝘦𝘯𝘷)
        for circle in all(circles) do
            circfill(circle.x, circle.y, circle.r, c)
        end
    end
})
