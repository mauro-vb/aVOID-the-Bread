
function story_init(_𝘦𝘯𝘷)
    load_stored_gfx(story_gfx)
    pressed = false
    _upd = story_upd
    _drw = story_drw
    x, y = startpx, startpx - 64
    mapx, mapy = rndrange(0, 6), 0
    local xsep = 28
    images = {
        {s = myspr[54], x = x + 100, y = y - 100, tx = x - xsep, ty = y - 56},
        {s = myspr[55], x = x - 90, y = y - 100, tx = x + xsep, ty = y - 56},
        {s = myspr[56], x = x + 100, y = y - 62, tx = x - xsep, ty = y - 18},
        {s = myspr[57], x = x - 90, y = y - 62, tx = x + xsep, ty = y - 18},
        {s = myspr[58], x = x - 90 * sgn(rndrange(-1,1)), y = y + 100, tx = x, ty = y + 20}
    }
    frames = 60
    imgi = 1
end

function story_upd(_𝘦𝘯𝘷)
    --printh(pressed)
    if (pressed) return
    if imgi > #images then
        if btnp(🅾️) or btnp(❎) then
            pressed = true
            transition({new_scene = game})
        end
    else
        if btnp(🅾️) or btnp(❎) then
            pressed = true

            dotween(images[imgi], "x", images[imgi].tx, frames, overshoot, reset_pressed(_𝘦𝘯𝘷))
            dotween(images[imgi], "y", images[imgi].ty, frames, overshoot)
            imgi += 1
        end
    end

end

function story_drw(_𝘦𝘯𝘷)
    cls(2)
    map(mapx, mapy)
    for img in all(images) do
        mspr(img.s, img.x , img.y)
    end


end



story = scene:extend({
    reset_pressed = function (_𝘦𝘯𝘷)
        return function ()
            pressed = false
        end
    end,
    init = story_init,
    upd = story_upd,
    drw = story_drw,
})
