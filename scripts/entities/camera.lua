
mycam = game_object:extend({
    deadz = 24,

    sizex = 128, sizey = 128,
    owner = nil,
    init = function (_ENV)
        minx = maplims.minx; maxx = maplims.maxx
        miny = maplims.miny; maxy = maplims.maxy
        x = owner.x
        y = owner.y
    end,
    upd = function(_ENV)
        if (owner == nil) return
        local ox, oy = owner.x, owner.y
        -- X axis
        if abs(ox - x) > deadz then
            x = mid(minx + 64, ox - sgn(ox - x) * deadz, maxx - 64)
        end
        -- Y axis
        if abs(oy - y) > deadz then
            y = mid(miny + 64, oy - sgn(oy - y) * deadz, maxy - 64)
        end
        camera(x - 64, y - 64)
    end,
})
