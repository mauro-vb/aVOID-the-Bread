function loaf_ai(_𝘦𝘯𝘷)
    if (p == nil) return nil
    if disto(_𝘦𝘯𝘷, p) > 5 then
        setcardinaldir(_𝘦𝘯𝘷, p)
    end
    x += move_speed * dx
    y += move_speed * dy
    add(dxs, sgn(dx))
    if #dxs > 3 then del(dxs, dxs[1]) end

    if #dxs == 3 and all_true(dxs, function(s) return s == dxs[1] end) then
        fx = dxs[1] == 1
    end
end

function loaf_drw(_𝘦𝘯𝘷)
    --ovalfill(x - 9, y , x + 8, y + 5, 2)
    mspr(cycanim(age, anim, 6), x, y, fx)
    drwhp(_𝘦𝘯𝘷)
end

loaf = enemy:extend({
    hp = 40,
    dxs = {},
    move_speed = .4,
    anim = {myspr[21], myspr[22], myspr[23], myspr[24]},
    drw = loaf_drw,
    enemy_ai = loaf_ai
})
