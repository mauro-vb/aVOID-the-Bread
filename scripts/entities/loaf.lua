function loaf_ai(_𝘦𝘯𝘷)
    timer -= 1
    if (p == nil) return nil
    setcardinaldir(_𝘦𝘯𝘷, p, move_speed <= .3)
    --setdir(_𝘦𝘯𝘷, p)
    if timer <= 0 then
        rndspd = rndrange(-.1,.1)
        timer = rndrange(60,90)
    end
    x += move_speed * dx
    y += move_speed * dy
end

function loaf_drw(_𝘦𝘯𝘷)
    --ovalfill(x - 9, y , x + 8, y + 5, 2)
    mspr(cycanim(age, anim, 6), x, y, p.x > x)
    drwhp(_𝘦𝘯𝘷)
end

loaf = enemy:extend({
    timer = 0,
    anim = {myspr[21], myspr[22], myspr[23], myspr[24]},
    drw = loaf_drw,
    enemy_ai = loaf_ai,
    enemy_init = function(_𝘦𝘯𝘷)
        hp = enstats[enstats_i][1][1]
        move_speed = enstats[enstats_i][1][2]
    end,
})
