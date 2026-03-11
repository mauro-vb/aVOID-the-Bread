function spawn_oven()
    local oven_pos

    local function checkcol(ovenpos)
        for oven in all(ovens) do
            if collides(ovenpos, oven) then return true end
        end
        if ovenpos.x - ovenpos.sizex / 2 < maplims.minx then return true end
        if ovenpos.x + ovenpos.sizex / 2 > maplims.maxx then return true end
        if ovenpos.y - ovenpos.sizey / 2 < maplims.miny then return true end
        if ovenpos.y + ovenpos.sizey / 2 > maplims.maxy then return true end

        return collides(ovenpos, scene.cam)
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
    difficulty = max(difficulty,flr(t / 1500) + flr(p.level / 2.5))
    local novens =  mid(2, difficulty / 5, 4)
    local oven_spawn_rate = flr(mid(600, 900 - difficulty * 20 + novens * 180, 1200))

    global.enstats_i = mid(1, ceil(difficulty / 3), #enstats)
    if t % oven_spawn_rate == 0 then
        for n=1, novens do
            if #ovens == 0 then spawn_oven() end
            if #ovens < 8 then
                spawn_oven()
            end
        end
    end
    if p.hp <= 0 then end_game(_𝘦𝘯𝘷) end
end

function end_game(_𝘦𝘯𝘷)
    over = true
    transition({ new_scene = end_screen})
end

function game_init(_𝘦𝘯𝘷)
    global.enstats_i = 1
    global.difficulty = 0
    over = false
    restore_gfx()
    t = 0

    global.encount = { BAGELS = 0, BAGUETTES = 0, LOAVES = 0, OVENS = 0 }
    global.entities = {}
    global.p = player({ x = startpx, y = startpy })
    global.parts = {}
    global.ui = game_ui()

    global.cam = mycam({ owner = p })
    global.paused = false
    global.ovens = {}
    spawn_oven(true)
    spawn_oven(true)
    _upd = game_upd
    _drw = game_drw
end

function game_upd(_𝘦𝘯𝘷)
    if (over) return
    ui:upd()
    if (paused) return
    t += 1

    upd_group(entities)
    upd_group(parts)
    sorty(entities)
    cam:upd()
    game_loop(_𝘦𝘯𝘷)
end

function game_drw(_𝘦𝘯𝘷)
    cls(7)
    map()
    drw_group(entities)
    drw_group(attacks)
    if (over) return
    drw_group(parts)
    ui:drw()
end

game = scene:extend({
    init = game_init,
    upd = game_upd,
    drw = game_drw,
})
