cd_bar = game_object:extend({
    barwidth = 10,
    barheight = 1,
    drw = function(_𝘦𝘯𝘷)
        x = p.x
        y = p.y + 9

        local progress = lerp(0, barwidth, mid(0, 1 - p.hit_t / p.hit_cd, 1))
        local bx = x - barwidth / 2
        line(bx, y, bx + barwidth, y, 0)
        line(bx, y, bx + progress, y, 7)
    end
})

dash_bar = game_object:extend({
    barwidth = 6,
    barheight = 1,
    drw = function(_𝘦𝘯𝘷)
        if p.has_dash then
            x = p.x
            y = p.y + 11

            local progress = lerp(0, barwidth, mid(0, 1 - p.dasht / p.dash_cd, 1))
            local bx = x - barwidth / 2
            line(bx, y, bx + barwidth, y, 0)
            line(bx, y, bx + progress, y, 12)
        end
    end
})

xp_bar = game_object:extend({
    barwidth = 46,
    barheight = 3,
    drw = function(_𝘦𝘯𝘷)
        x = cam.x
        y = cam.y + 50
        progress = lerp(0, barwidth - 2, mid(0, p.xp / p.level_ups[min(p.level, #p.level_ups)], 1))
        local bx = flr(x - barwidth / 2)
        rectfill(bx, y, bx + barwidth, y + barheight, barc)
        rectfill(bx + 1, y + 1, bx + 1 + progress, y + barheight - 1, 12)
        print("\^o040LVL ", bx - 12, y - 1, barc)
        print("\^o040" .. tostr(p.level), bx + barwidth + 4, y - 1, barc)
    end
})

hp_bar = game_object:extend({
    x = 64,
    y = 108,
    barwidth = 60,
    barheight = 3,
    drw = function(_𝘦𝘯𝘷)
        x = cam.x
        y = cam.y + 56
        progress = lerp(0, barwidth - 2, p.hp / p.maxhp)
        local bx = flr(x - barwidth / 2)
        rectfill(bx, y, bx + barwidth, y + barheight, barc)
        rectfill(bx + 1, y + 1, bx + barwidth - 1, y + barheight - 1, 6)
        rectfill(bx + 1, y + 1, bx + progress + 1, y + barheight - 1, 14)
        print("\^o040HP:", bx - 12, y, barc)
    end
})


game_ui = game_object:extend({
    barc = 15,
    bars = {},
    init = function(_𝘦𝘯𝘷)
        add(bars, xp_bar({ barc = barc }))
        add(bars, hp_bar({ barc = barc }))
        add(bars, cd_bar())
        add(bars, dash_bar())
    end,
    upd = function(_𝘦𝘯𝘷)
        upd_group(bars)
    end,
    drw = function(_𝘦𝘯𝘷)
        drw_group(bars)
        for oven in all(ovens) do
            oven:drw_indicator()
        end
    end,
})
