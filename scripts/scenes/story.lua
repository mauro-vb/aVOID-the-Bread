function story_init(_𝘦𝘯𝘷)
    load_stored_gfx(story_gfx)
    pressed = false
    _upd = story_upd
    _drw = story_drw
    x, y = startpx, startpx - 64
    mapx, mapy = rndrange(0, 6), 0
    local xsep = 28
    images = {
        { s = myspr[54], x = x - 4, y = y - 24, tx = x - xsep, ty = y - 59 },
        { s = myspr[55], x = x - 2, y = y - 22, tx = x + xsep, ty = y - 59 },
        { s = myspr[56], x = x,     y = y - 20, tx = x - xsep, ty = y - 22 },
        { s = myspr[57], x = x + 2, y = y - 18, tx = x + xsep, ty = y - 22 },
        { s = myspr[58], x = x + 4, y = y - 16, tx = x,        ty = y + 14 }
    }
    frames = 60
    imgi = 1
    texts = split2d "\n🅾️/❎ to continue|looks like our poor,friendly baker is getting fired!|i guess she's got,nothing to loose now...|she decides to,bake one last batch...|she hears ominous sounds,coming from the oven...|the bread is alive!,and it is not friendly..."
end

function story_upd(_𝘦𝘯𝘷)
    if imgi > #images then
        if btnp(🅾️) or btnp(❎) and trans == nil then
            transition({ new_scene = game })
        end
    else
        if btnp(🅾️) or btnp(❎) then
            dotween(images[imgi], "x", images[imgi].tx, frames, overshoot, reset_pressed(_𝘦𝘯𝘷))
            dotween(images[imgi], "y", images[imgi].ty, frames, overshoot)
            imgi += 1
        end
    end
end

function story_drw(_𝘦𝘯𝘷)
    cls(2)
    --map()
    rectfill(x - 64, y + 34, x + 128, y + 128, c)
    local text = texts[imgi] or texts[#texts]
    for i = 1, #text do
        print(text[i], x - #text[i] / 2 * 4, y + 29 + i * 7, 15)
    end
    for i = 1, #images do
        local img = images[#images + 1 - i]
        mspr(img.s, img.x, img.y)
    end
end

story = scene:extend({
    reset_pressed = function(_𝘦𝘯𝘷)
        return function()
            pressed = false
        end
    end,
    init = story_init,
    upd = story_upd,
    drw = story_drw,
})
