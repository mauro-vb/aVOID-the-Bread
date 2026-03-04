transition = game_object:extend({
    frames = 30,
    cols = split "8, 8, 8, 8, 14, 14, 14, 4, 4 ",
    n = 16,
    spd = .3,
    current_size = 0,
    fsize = 8,
    shrink = false,
    trans = smootherstep,
    init = function(_𝘦𝘯𝘷)
        circles = {}
        global.trans = _𝘦𝘯𝘷
        for i = 1, n do
            for j = 1, n do
                local circle = { x = (i - 1) * 128 / (n - 1), y = (j - 1) * 128 / (n - 1), r = 0, c = rnd(cols) }
                add(circles, circle)
                local wait = rnd(15)
                chaintweens({

                    tween_factory(circle, "r", rndrange(4, 8), frames - wait, trans),

                    tween_wait(wait, function()
                        global.scene:load(new_scene)
                    end),
                    {
                        tween_factory(circle, "r", 0, frames, trans),
                    }
                }, function() global.trans = nil end, false)
            end
        end
        shuffle(circles)
    end,
    drw = function(_𝘦𝘯𝘷)
        for circle in all(circles) do
            local r = circle.r
            local x = peek2(0x5f28) + circle.x
            local y = peek2(0x5f2a) + circle.y
            if r > 2 then
                circfill(x, y, r + 1, 2)
            end
            circfill(x, y, r, circle.c)
        end
    end
})
