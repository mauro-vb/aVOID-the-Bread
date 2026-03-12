function enemy_upd(_ENV)
    age += 1
    local initx, inity = x, y
	if state=="spawning" then
	-- handle spawning delay
		if spawn_delay>0 then
			spawn_delay-=1
		else state="active"
		end

	elseif state=="active" then
	    if not dummy then
    		if collides(_ENV,p) do
    			destroy(_ENV, false)
    			return
    		end
    		if hp <= 0 then
    			destroy(_ENV, true)
    		end
	    end
		-- custom behavior

		enemy_ai(_ENV)

	end
	if paralize_t > 0 then
		paralize_t -= 1
		x = initx
    	y = inity
	else
	restric_movement(_ENV)
    end
end

enemy = class:extend({
    state = "active",
    dummy = false,
    xp_drop = 1,
    dmg = 20,
    paralize_t = 0,
    init = function(_ENV)
        if enemy_init != nil then
            enemy_init(_ENV)
        end
        age = 0
        initial_hp = hp
        add(entities, _ENV)
    end,
    upd = enemy_upd,
    col = 7,
    sizey = 4, sizex = 4,
    enemy_ai = _noop,
    destroy = function(_ENV, die)
        del(entities, _ENV)
        if die then
            sfx(41)
            if is(_ENV, bagel) then global.encount.BAGELS += 1
            elseif is(_ENV, baguette) then global.encount.BAGUETTES += 1
            elseif is(_ENV, loaf) then global.encount.LOAVES += 1 end
            if (p != nil) then p.xp += xp_drop * p.xp_received end
        else
            sfx(23)
            enhurt(p)
            if (p != nil) then p.hp -= dmg * p.dmg_received end
        end
    end,
    x = 64, y = 64,
    dx = 0,
    dy = 0,
    c = 36,
    debug = drw_collision_box,
    drwhp = function(_ENV)

        if hp < initial_hp then
            local barwidth = 13
            local offy = 8
            local progress = lerp(0, barwidth, mid(0, hp / initial_hp, 1))
            local bx = x - barwidth / 2
            line(bx, y + offy, bx + barwidth, y + offy, 15)
            line(bx, y + offy, bx + progress, y + offy, 11)
        end
    end
})
