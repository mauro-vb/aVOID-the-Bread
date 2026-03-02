function spawn_oven(forced)
    if #ovens > p.level and not forced then return end

    local oven_pos

    local function checkcol(ovenpos)
        for oven in all(ovens) do
            if collides(ovenpos, oven) then return true end
        end
        if ovenpos.x - ovenpos.sizex / 2 < maplims.minx then return true end
        if ovenpos.x + ovenpos.sizex / 2 > maplims.maxx then return true end
        if ovenpos.y - ovenpos.sizey / 2 < maplims.miny then return true end
        if ovenpos.y + ovenpos.sizey / 2 > maplims.maxy then return true end

        return collides(ovenpos, cam)
    end

    repeat
        oven_pos = {
            x = rndrange(16, maplims.maxx - 16),
            y = rndrange(16, maplims.maxy - 16),
            sizex = 16,
            sizey = 16
        }
    until not checkcol(oven_pos)

    add(ovens, oven({
        x = oven_pos.x,
        y = oven_pos.y
    }))
end

function restric_movement(_𝘦𝘯𝘷)
    x = mid(0, x, maplims.maxx)
    y = mid(0, y, maplims.maxy)
end

function game_loop(_𝘦𝘯𝘷)
    if t % 3000 == 0 then
        spawn_oven(true)
    end
end

function game_init(_𝘦𝘯𝘷)
    t = 0
    global.maplims = { minx = 0, maxx = 52 * 8, miny = 0, maxy = 32 * 8 }
    local startpx, startpy = maplims.maxx / 2, maplims.maxy / 2
    global.encount = { BAGELS = 0, BAGUETTES = 0, LOAVES = 0, OVENS = 0 }
    global.entities = {}
    global.p = player({ x = startpx, y = startpy })
    global.parts = {}
    global.ui = game_ui()

    global.cam = mycam({ owner = p })
    --global.paused = false
    global.ovens = {}
    local dist = 50
    spawn_oven(true)
    spawn_oven(true)
    _upd = game_upd
    _drw = game_drw
    printh("\n" .. tostr(p.level))
end

function game_upd(_𝘦𝘯𝘷)
    if paused then
        ui:upd()
        return
    end
    t += 1
    game_loop(_𝘦𝘯𝘷)
    upd_group(entities)
    upd_group(parts)
    sorty(entities)
    cam:upd()
end

function game_drw(_𝘦𝘯𝘷)
    cls(7)
    map()
    drw_group(entities)
    drw_group(attacks)
    drw_group(parts)
    ui:drw()
end

game = scene:extend({
    init = game_init,
    upd = game_upd,
    drw = game_drw,
})
