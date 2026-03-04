
function bagel_ai(_𝘦𝘯𝘷)
    if (p == nil) return nil
    setdir(_𝘦𝘯𝘷, p)
    local pdist = disto(_𝘦𝘯𝘷, p)
    local dist_thresh = 50
    if  pdist > dist_thresh and last_pdist < dist_thresh  and abs(rotation_dir) > .5 then
        dotween(_𝘦𝘯𝘷, "rotation_dir", -sgn(rotation_dir), 90, quad)
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

function bagel_drw(_𝘦𝘯𝘷)
    ovalfill(x - 7, y + 1, x + 5, y + 6, 2)
	mspr(sprarr, x, y)
	drwhp(_𝘦𝘯𝘷)
	local eyespos = cycanim(age, eyepositions, 10, sgn(rotation_dir) == -1)
	for pos in all(eyespos) do
		pset(x + pos.x, y + pos.y, x < p.x and 11 or 0)
		pset(1 + x + pos.x, y + pos.y, x < p.x and 0 or 11)
	end
end

bagel = enemy:extend({
    hp = 20,
    move_speed = .2,
    orbit_speed = .6,
    rotation_timer = 0,
    eyepositions = {
        {{x = 0, y = 2}, {x = -3, y = 2}},
        {{x = 2, y = 1}, {x = 4, y = 0}},
        {},
        {{x = -7, y = 0}, {x = -5, y = 1}},
    },
    sprarr = myspr[25],
    drw = bagel_drw,
    enemy_init = function(_𝘦𝘯𝘷)
        rotation_dir = chance() and 1 or -1
    end,
    last_pdist = 100,
    enemy_ai = bagel_ai
})
