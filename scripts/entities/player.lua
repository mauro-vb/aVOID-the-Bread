function player_dash(_ENV)
    if btnp(❎) and can_dash then
        sfx(28)
        dashing = true
        can_dash = false
        local trans = quad
        if dx == 0 and dy == 0 then
            if anim == anims.l_idle then dx = -1; dy = 0
            elseif anim == anims.r_idle then dx = 1; dy = 0
            elseif anim == anims.d_idle then dx, dy = 0, 1
            elseif anim == anims.u_idle then dx, dy = 0, -1 end
        end
        local dashx, dashy = dx * dashforce, dy * dashforce

        local dashf = 10
        dotween(_ENV, "x", x + dashx, dashf, trans)
        dotween(_ENV, "y", y + dashy, dashf, trans, function() dashing = false; dasht = dash_cd end)
    else
        if dasht > 0 then
            dasht -=1
        else
            can_dash = has_dash
        end
    end
end

function player_hit(_ENV)
    local function get_area(_ENV)
        local area = {}
        area.y = y - 4
        if facing_dir == "u" then area.y = y - hitlen / 2
        elseif facing_dir == "d" then area.y = y + hitlen / 2 end

        area.x = x
        if facing_dir == "l" then area.x = x - hitlen / 2
        elseif facing_dir == "r" then area.x = x + hitlen / 2 end
        if facing_dir == "u" or facing_dir == "d" then
            area.sizex = hitwid
            area.sizey = hitlen
        else
            area.sizex = hitlen
            area.sizey = hitwid
        end
        rectfill(area.x-area.sizex/2,area.y-area.sizey/2,area.x+area.sizex/2,area.y+area.sizey/2,12)
        area.hor = facing_dir == "l" or facing_dir == "r"
        area.dir = facing_dir
        return area
    end

    local area = get_area(_ENV)
    hit_particles(area)
    for en in all(entities) do
        if (en:is(enemy) or en:is(oven)) and collides(area, en) then
            if lifesteal then hp += .5 * en.hp end
            if paralize then en.paralize_t = paralize_t end
            en.hp -= hit_dmg
            sfx(28)
            enhit(en)
        end
    end
    sfx(17)
end

function player_hit_upd(_ENV)
    if hitting and (age \ hitspd) % #anim + 1 == #anim then
        hitting = false
        hit(_ENV)
        change_anim(_ENV, facing_dir.."_idle", facing_dir == "l", idlespd)
    end
	if hit_t > 0 then
	    hit_t -= 1
		if hit_wait_t != hit_wait then hit_wait_t = hit_wait end
	else
	    if input_dir == 0 then
			if hit_wait_t > 0 then
                hit_wait_t -= 1
			else
				hitting = true
			    hit_t = hit_cd
			end
		end
	end
end

function player_move(_ENV)

    if (dashing) return

    input_dir = 0
    if btn(⬅️) then input_dir += 1 end
    if btn(➡️) then input_dir += 2 end
    if btn(⬆️) then input_dir += 4 end
    if btn(⬇️) then input_dir += 8 end
    input_dir = butarr[input_dir]
    dx = dirx[input_dir]; dy = diry[input_dir]
    cobblefix(_ENV, input_dir)
    local nx, ny = x + dx * mv_spd, y + dy * mv_spd
    x = nx; y = ny
    if input_dir != 0 then
		if step_timer > 0 then
	 	    step_timer -= 1
		else
		    sfx(age % 2 == 0 and 37 or 38)
		    step_timer=20
		end
	 end
    player_dash(_ENV)
    restric_movement(_ENV)
end

function change_anim(_ENV, name, fx, spd)
    if anim != anims[name] then
        age = 0
        spd = spd or 10
        aspd = spd
        anim = anims[name]
        flipx = fx
        facing_dir = name[1]
    end
end

function player_anim(_ENV)
    if hitting then
        if anim == anims.l_idle then
            change_anim(_ENV, "l_hit", true, hitspd)
        elseif anim == anims.r_idle then
            change_anim(_ENV, "r_hit", false, hitspd)
        elseif anim == anims.u_idle then
            change_anim(_ENV, "u_hit", false, hitspd)
        elseif anim == anims.d_idle then
            change_anim(_ENV, "d_hit", false, hitspd)
        end
    else
        if (lastdir == 0) return
        if input_dir == 1 or input_dir == 2 or input_dir >= 5 then
            local isleft = sgn(dx) == -1
            local side = isleft and "l" or "r"
            change_anim(_ENV, side.."_run", isleft, 7)
        elseif input_dir == 3 then
            change_anim(_ENV, "u_run")
        elseif input_dir == 4 then
            change_anim(_ENV, "d_run", false)
        else
            if (lastdir == 3) then
                change_anim(_ENV, "u_idle", false, idlespd)
            elseif (lastdir == 4) then
                change_anim(_ENV, "d_idle", false, idlespd)
            else
                local isleft = lastdir == 1 or lastdir == 5
                local side = isleft and "l" or "r"
                change_anim(_ENV, side.."_idle", isleft, idlespd)
            end
        end
    end
end

function player_level_up(_ENV)
    sfx(14)
    local function get_upgrade(prev_upgs)
        local new_upg = nil
        local upg_type

        repeat
           -- upg_type = rnd(upgrades)
           -- if not upg_type or upg_type.repeatable then
           --     return nil
           -- end
            new_upg = rnd(upgrades)
        until new_upg
                   and new_upg:valid()
                   and not contains(prev_upgs, new_upg)
        return new_upg
    end

    local ups = {}
    local upg
    for i=1, 3 do
        upg = get_upgrade(ups)
        add(ups, upg)
    end
    global.ui = upgrade_ui({upgrades = ups})
end

function player_upd_xp(_ENV)
    local xp_required = level > #level_ups and level_ups[#level_ups] or level_ups[level]
    if xp >= xp_required then
        xp -= xp_required
        level += 1
        player_level_up(_ENV)
    end
end

function player_upd(_ENV)
    age += 1
    player_move(_ENV)
    player_hit_upd(_ENV)
    player_anim(_ENV, input_dir)
    player_upd_xp(_ENV)

    --if hp <= 0 then global.paused = true; transition({new_scene = end_screen}) end

    hp = min(hp, maxhp)

    lastdir = input_dir
end

function player_drw(_ENV)
    ovalfill(x - 4, y + 3, x + 4, y + 6, 2)
    sprarr = cycanim(age, anim, aspd)
    mspr(sprarr, x, y, flipx)
    if debug_on then
        debug(_ENV)
    end
end

function player_debug(_ENV)
    drw_collision_box(_ENV)
    print(hitlen,x,y - 20,0)
end

function player_init(_ENV)
    butarr[0] = 0
    anim = anims.d_idle
    hit_t = hit_cd
    hit_wait_t = hit_wait
    add(entities, _ENV)
end



player = game_object:extend({
    mv_spd = .8,
    dx = 0,
    dy = 0,
    sizex = 6,
    sizey = 10,
    anims = {
        d_idle = { myspr[2], myspr[5] },
        l_idle = { myspr[3], myspr[47] },
        r_idle = { myspr[1], myspr[34] },
        u_idle = { myspr[4], myspr[17] },
        d_run = { myspr[5], myspr[6], myspr[7], myspr[8] },
        r_run = { myspr[9], myspr[10], myspr[11], myspr[12] },
        l_run = { myspr[13], myspr[14], myspr[15], myspr[16] },
        u_run = { myspr[17], myspr[18], myspr[19], myspr[20] },
        d_hit = { myspr[35], myspr[36], myspr[37], myspr[37] },
        u_hit = { myspr[38], myspr[39], myspr[40], myspr[40] },
        r_hit = { myspr[41], myspr[42], myspr[43], myspr[43] },
        l_hit = { myspr[44], myspr[45], myspr[46], myspr[46] },
    },
    idlespd = 12,
    hitspd = 6,
    age = 0,
    input_dir = 0,

    dash_cd = 200,
    dasht = 0,
    has_dash = false,
    can_dash = false,
    dashforce = 28,
    upgrades = {
                {trigger = function() p.has_dash = true end, valid = function() return not p.has_dash end, name = "get a dash ❎", icon = myspr[51]},
                {trigger = function() p.dash_cd -= 50 end, valid = function() return p.has_dash and p.dash_cd > 80 end, name = "reduce dash cooldown", icon = myspr[51]},
                {trigger = function() p.hit_cd = mid(5, p.hit_cd - 20, 100) end, valid = function() return p.hit_cd > 10 end, name = "reduce hit cooldown", icon = myspr[50]},
                {trigger = function() p.hitlen = mid(25, p.hitlen * 1.5, 60) ;  p.hitwid = mid(15, p.hitwid * 1.5, 35) end, valid = function() return p.hitlen < 60 end, name = "increase reach", icon = myspr[52]},
                {trigger = function() p.hit_dmg += 5 end, valid = function() return true end, name = "increase damage", icon = myspr[49]},
                {trigger = function() p.xp_received *= 1.5 end, valid = function() return p.xp_received < 100 and p.level > 10 end, name = "receive more xp", icon = myspr[49], repeatable = true},
                {trigger = function() p.hp = mid(1, p.hp + .35 * p.maxhp, p.maxhp) end, valid = function() return p.hp != p.maxhp end, name = "heal", icon = myspr[53]},
                {trigger = function() p.maxhp *= 1.2 end, valid = function() return true end, name = "increase max hp", icon = myspr[53]}, repeatable = true,
                {trigger = function() p.lifesteal = true end, valid = function() return not p.lifesteal and p.level > 10 end, name = "lifesteal", icon = myspr[52]},
                {trigger = function() p.dmg_received *= .75 end, valid = function() return p.dmg_received > .3 end, name = "reduce received damage", icon = myspr[48]},
                {trigger = function() p.paralize = true end, valid = function() return not p.paralize end, name = "stun hit enemies", icon = myspr[52]},
                {trigger = function() p.paralize_t = mid(1, p.paralize_t + 30, 120) end, valid = function() return p.paralize and p.paralize_t < 120 end, name = "longer stun", icon = myspr[50]},
    },
    step_timer=20,
    hit_cd = 100,
    hitting = false,
    hit_wait = 10,
    hitlen = 25, -- min 25, max 50
    hitwid = 12, -- min 15, max 30
    hit_dmg = 7, -- min 10, max 50
    hit = player_hit,
    hp = 100,
    maxhp = 100,
    lifesteal = false,
    paralize = false,
    paralize_t = 25,
    dmg_received = 1,
    xp_received = 1,
    xp = 0,
    level = 1,
    level_ups = split"3,3,4,4,4,5,5,5,5,8,9,10,10,10,10,20,20,30,50,60,70,80,100,150,200,300,400,500,750,1000",
    upd = player_upd,
    drw = player_drw,
    init = player_init,
    debug = player_debug,
})
