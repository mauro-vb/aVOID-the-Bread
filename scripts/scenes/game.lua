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
    if t % 3000 == 0 then
        spawn_oven(true)
    end
    if p.hp <= 0 then end_game(_𝘦𝘯𝘷) end
end

function end_game(_𝘦𝘯𝘷)
    over = true
    transition({ new_scene = end_screen, ox = cam.x - 64, oy = cam.y - 64 })
    --startpx, startpy = cam.x, cam.y
	--global.scene:load(end_screen)
	--global.p = {x = p.x, y = p.y }
	--global.cam = nil
end

function game_init(_𝘦𝘯𝘷)
    over = false
    restore_gfx()
    t = 0

    global.encount = { BAGELS = 0, BAGUETTES = 0, LOAVES = 0, OVENS = 0 }
    global.entities = {}
    global.p = player({ x = startpx, y = startpy, hp = 1 })
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
