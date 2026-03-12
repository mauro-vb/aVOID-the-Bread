function bun_ai(_ENV)
    if (p == nil) return nil
    setdir(_ENV, p)
    local pdist = disto(_ENV, p)
    local dist_thresh = 30
    if  pdist > dist_thresh and last_pdist < dist_thresh  and abs(rotation_dir) > .5 then
        dotween(_ENV, "rotation_dir", -sgn(rotation_dir), 90, quad)
    else
        local tangent_x = -dy * rotation_dir
        local tangent_y = dx * rotation_dir
        x += move_speed * dx + orbit_speed * tangent_x
        y += move_speed * dy + orbit_speed * tangent_y
    end
   -- rotation_timer += 1
    last_pdist = pdist
    if x >= maplims.maxx or x <= 0 or y >= maplims.maxy or y <= 0 then
        rotation_dir *= -1
    end
end

function bun_drw(_ENV)
	mspr(sprarr, x, y)
	drwhp(_ENV)
	for i=1, 2 do
	    local oy = p.y > y and 3 or 2
		local ox = p.x > x and -2 or -3
		if i == 2 then ox += 3 end
		pset(x + ox, y + oy, 0)
	end
end

bun = enemy:extend({
    rotation_dir = 1,

    sprarr = myspr[29],
    drw = bun_drw,
    enemy_init = function(_ENV)
        hp = enstats[enstats_i][5][1]
        move_speed = enstats[enstats_i][5][2]
        orbit_speed = move_speed * 1.2
    end,
    last_pdist = 100,
    enemy_ai = bun_ai
})
