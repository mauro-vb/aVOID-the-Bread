function oven_spawn(_𝘦𝘯𝘷)
    sfx(7)
    for i = 1, rndrange(1, mid(1, p.level / 3, 15)) do
        local en = rnd(enemies)
        en:new({ x = x, y = y + 10 })
    end
    sprarr = myspr[30]
end

function oven_upd(_𝘦𝘯𝘷)
    if age % spawn_rate == 0 then
        sprarr = myspr[31]
        spwn_timer = 30
    end
    if sprarr == myspr[31] then
        if spwn_timer <= 0 then
            oven_spawn(_𝘦𝘯𝘷)
        else
            spwn_timer -= 1
        end
    end
    if hp <= 0 then
        destroy(_𝘦𝘯𝘷)
    end
end

function oven_drw(_𝘦𝘯𝘷)
    age += 1
    mspr(sprarr, x, y)
    drwhp(_𝘦𝘯𝘷)
end

oven = enemy:extend({
    age = 0,
    hp = 55,
    state = "active",
    size = "small",
    enemies = { baguette, loaf, bagel },
    spawn_rate = 1800,
    xp_drop = 3,
    drw = oven_drw,
    upd = oven_upd,
    c = 86,
    destroy = function(_𝘦𝘯𝘷)
        del(entities, _𝘦𝘯𝘷)
        del(ovens, _𝘦𝘯𝘷)
        if (p != nil) then p.xp += xp_drop end
        global.encount.OVENS += 1
        spawn_oven()
        spawn_oven()
    end,
    enemy_init = function(_𝘦𝘯𝘷)
        oven_spawn(_𝘦𝘯𝘷)
        spawn_rate -= (p.level - 1) * 100
        spawn_rate = mid(1800, spawn_rate, 300)
        sfx(19)
        if size == "small" then
            sizex, sizey = 16, 16
            sprarr = myspr[30]
        end
    end
})
