function hit_particles(a)
    if debug_on then
        particle:new({
            x = a.x,
            y = a.y,
            sizex = a.sizex,
            sizey = a.sizey,
            c = 12,
            pdrw = function(_𝘦𝘯𝘷)
                rectfill(x - sizex / 2, y - sizey / 2, x + sizex / 2, y + sizey / 2, c)
            end,
            maxage = 20,
        })
    end
    local n = mid(20, a.sizex * a.sizey / 10, 150)
    for i = 1, n do
        local t = i / (n + 1) -- 0..1 exclusive
        -- arc angle: spread across ~160 degrees for u/d, ~120 for l/r
        local spread = .4
        local angle = lerp(-spread, spread, t) -- in pico8 turns
        local reach_mult = a.hor and a.sizex / 4 or a.sizey / 4
        -- base position along the arc
        local arc_r = a.hor and a.sizex / 4 or a.sizey / 4
        local ox, oy
        local basepos_mult = .2
        if a.dir == "r" then
            ox = a.x + cos(angle) * arc_r * basepos_mult
            oy = a.y + sin(angle) * arc_r
        elseif a.dir == "l" then
            ox = a.x - cos(angle) * arc_r * basepos_mult
            oy = a.y + sin(angle) * arc_r
        elseif a.dir == "d" then
            ox = a.x + sin(angle) * arc_r
            oy = a.y + cos(angle) * arc_r * basepos_mult
        elseif a.dir == "u" then
            ox = a.x + sin(angle) * arc_r
            oy = a.y - cos(angle) * arc_r * basepos_mult
        end

        -- reach: center particles go further
        local mid = (a.dir == "l" or a.dir == "r") and .6 or .5
        local center = 1 - abs(t - mid) * 2
        local reach = (0.5 + center * 0.5) * reach_mult
        local tsize = max(1, n / 40) + center * 3
        local spd = 3 + center * 2

        -- end pos shoots outward along same angle from center
        local endx, endy = ox, oy
        local endpos_mult = .05
        if a.dir == "r" then
            endx = ox + cos(angle) * reach
            endy = oy + sin(angle) * reach * endpos_mult
        elseif a.dir == "l" then
            endx = ox - cos(angle) * reach
            endy = oy + sin(angle) * reach * endpos_mult
        elseif a.dir == "d" then
            endx = ox + sin(angle) * reach * endpos_mult
            endy = oy + cos(angle) * reach
        elseif a.dir == "u" then
            endx = ox + sin(angle) * reach * endpos_mult
            endy = oy - cos(angle) * reach
        end

        local p = circlep({
            x = ox,
            y = oy,
            c = 7,
            size = 1,
            upd = _noop,
        })

        chaintweens({
            {
                tween_factory(p, "size", tsize, spd, quint),
                tween_factory(p, "x", endx, spd, quint),
                tween_factory(p, "y", endy, spd, quint),
            },
            {
                tween_factory(p, "size", 0, spd / 1.5, smootherstep),
            }
        }, function()
            del(global.parts, p)
        end)
    end
end

function enhurt(_𝘦𝘯𝘷)
    n = 20
    local c = 142
    circlep({
        size = 10,
        c = 7,
        x = x,
        y = y,
        maxage = 2
    })
    circlep({
        size = 10,
        ctab = { 8, 14 },
        x = x,
        y = y,
        maxage = 4
    })
    for i = 1, n do
        circlep({
            size = rnd(3),
            c = 231,
            x = x,
            y = y,
            sx = rnd(),
            sy = rnd(),
            wait = 6,
            border = chance(.25),
            maxage = rndrange(3, 4),
            onend = "fade"
        })
    end
end

function enhit(_𝘦𝘯𝘷)
    n = 10
    circlep({
        size = 10,
        c = 7,
        x = x,
        y = y,
        wait = 0,
        maxage = 3
    })
    for i = 1, n do
        circlep({
            size = rnd(3),
            c = c,
            x = x,
            y = y,
            sx = rnd(),
            sy = rnd(),
            wait = 3,
            border = chance(.25),
            maxage = rndrange(10, 15),
            onend = "fade",
        })
    end
end
