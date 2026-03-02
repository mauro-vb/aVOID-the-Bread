function enemy_upd(_𝘦𝘯𝘷)
    age += 1
    local initx, inity = x, y
	if state=="spawning" then
	-- handle spawning delay
		if spawn_delay>0 then
			spawn_delay-=1
		else state="active"
		end

	elseif state=="active" then
		if collides(_𝘦𝘯𝘷,p) do
			p.hp -= p.dmg_received
			destroy(_𝘦𝘯𝘷, false)
			return
		end
		if hp <= 0 then
			destroy(_𝘦𝘯𝘷, true)
		end
		-- custom behavior

		enemy_ai(_𝘦𝘯𝘷)

	end
	if paralize_t > 0 then
		paralize_t -= 1
		x = initx
    	y = inity
	else
	restric_movement(_𝘦𝘯𝘷)
    end
end

enemy = class:extend({
    state = "active",
    xp_drop = 1,
    dmg = 20,
    paralize_t = 0,
    init = function(_𝘦𝘯𝘷)
        if enemy_init != nil then
            enemy_init(_𝘦𝘯𝘷)
        end
        age = 0
        initial_hp = hp
        add(entities, _𝘦𝘯𝘷)
    end,
    upd = enemy_upd,
    col = 7,
    sizey = 4, sizex = 4,
    enemy_ai = _noop,
    destroy = function(_𝘦𝘯𝘷, die)
        del(entities, _𝘦𝘯𝘷)
        if die then
            sfx(41)
            if is(_𝘦𝘯𝘷, bagel) then global.encount.BAGELS += 1
            elseif is(_𝘦𝘯𝘷, baguette) then global.encount.BAGUETTES += 1
            elseif is(_𝘦𝘯𝘷, loaf) then global.encount.LOAVES += 1 end
            if (p != nil) then p.xp += xp_drop end
        else
            sfx(23)
            enhurt(p)
            if (p != nil) then p.hp -= dmg end
        end
    end,
    x = 64, y = 64,
    dx = 0,
    dy = 0,
    c = 36,
    debug = drw_collision_box,
    drwhp = function(_𝘦𝘯𝘷)

        if hp < initial_hp then
            local barwidth = 14
            local offy = 8
            local progress = lerp(0, barwidth, hp / initial_hp)
            local bx = x - barwidth / 2
            line(bx, y + offy, bx + barwidth, y + offy, 15)
            line(bx, y + offy, bx + progress, y + offy, 11)
        end
    end
})
