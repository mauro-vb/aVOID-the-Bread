function oven_spawn(_ENV)
    sfx(59)
    for i = 1, mid(1, difficulty / 2, 10) do
        local en = rnd(enemies)
        if #entities < 300 then
            en({
                x = x + rndrange(-6, 6),
                y = y + 10 + rndrange(-4, 4),
            })
        end
    end
    sprarr = myspr[30]
end

function oven_upd(_ENV)
    if age % spawn_rate == 0 then
        sprarr = myspr[31]
        spwn_timer = 30
    end
    if sprarr == myspr[31] then
        if spwn_timer <= 0 then
            oven_spawn(_ENV)
        else
            spwn_timer -= 1
        end
    end
    if hp <= 0 then
        destroy(_ENV)
    end
end

oven = enemy:extend({
    age = 0,

    state = "active",
    size = "small",
    enemies = { bun, baguette, loaf, bagel },
    xp_drop = 3,
    drw = function(_ENV)
        age += 1
        mspr(sprarr, x, y)
        drwhp(_ENV)
        --drw_indicator(_ENV)
    end,
    upd = oven_upd,
    c = 86,
    destroy = function(_ENV)
        del(entities, _ENV)
        del(ovens, _ENV)
        if (p != nil) then p.xp += xp_drop end
        global.encount.OVENS += 1
    end,
    drw_indicator = function(_ENV)
        if not collides(_ENV, cam) then
            local margin = 4
            local sx = mid(cam.x - 64 + margin, x, cam.x + 64 - margin)
            local sy = mid(cam.y - 64 + margin, y, cam.y + 64 - margin)

            local size = flr(lerp(1, 3, 1 - disto(_ENV, p) / 300))
            rectfill(sx - size, sy - size, sx + size, sy + size, (sprarr == myspr[31] and sin(age / 10) > -.5) and 9 or 6)
            if size >= 1 then
                rect(sx - size, sy - size, sx + size, sy + size, 5)
            end

            --printh(disto(_ENV, p))
        end
    end,
    enemy_init = function(_ENV)
        hp = enstats[enstats_i][4][1]
        spawn_rate = enstats[enstats_i][4][2]
        oven_spawn(_ENV)
        sfx(19)
        if size == "small" then
            sizex, sizey = 16, 16
            sprarr = myspr[30]
        end
    end
})
