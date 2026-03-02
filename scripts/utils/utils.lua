-- tools
function lerp(from, to, t)
	return from + (to - from) * t
end



function rndrange(low, high)
	return low + rnd(high - low)
end

function upd_group(group)
    for e in all(group) do
        e:upd()
    end
end

function drw_group(group)
    for e in all(group) do
        e:drw()
    end
end

function split2d(s)
    local arr = split(s, "|", false)
    for k, v in pairs(arr) do
        arr[k] = split(v)
    end
    return arr
end

function chance(proba)
    proba = proba or .5
    return rnd() < proba
end

local function contains(t, val)
    for v in all(t) do
        if v == val then
            return true
        end
    end
    return false
end


-- movement
function disto(_𝘦𝘯𝘷, t)
	local diffx = x - t.x
	local diffy = y - t.y
	local res= diffx * diffx + diffy * diffy
	return sqrt(res)
end

amap = split" 2,7,4,8,1,5,3,6"
butarr = split "1,2,0,3,5,6,3,4,8,7,4,0,1,2,0"
dirx = split "-1,1, 0,0,-0.7, 0.7,0.7,-0.7"
diry = split " 0,0,-1,1,-0.7,-0.7,0.7, 0.7"
function cobblefix(_𝘦𝘯𝘷, dir)
    if lastdir != dir and dir >= 5 then
        --anti cobblestone
        x = flr(x) + .5
        y = flr(y) + .5
    end
end

function getdir(_𝘦𝘯𝘷, target)
    local ddx = target.x - x
    local ddy = target.y - y
    local distance = sqrt(ddx * ddx + ddy * ddy)
    return {x = ddx / distance, y = ddy / distance}
end

function setdir(_𝘦𝘯𝘷, target)
    local ddx = target.x - x
    local ddy = target.y - y
    local distance = sqrt(ddx * ddx + ddy * ddy)
    dx = ddx / distance
    dy = ddy / distance
end

function setcardinaldir(_𝘦𝘯𝘷, p)
	ang = atan2(p.x - x, y - p.y)
	local si = flr((ang * 8+ .5) % 8) + 1
	local dir = amap[si]
	dx = dirx[dir]
	dy = diry[dir]
	cobblefix(_𝘦𝘯𝘷, dir)
	lastdir = dir
end

-- collision

function collides(_𝘦𝘯𝘷, b)
    if (y - sizey / 2 > b.y + b.sizey / 2) return false
    if (b.y - b.sizey / 2 > y + sizey / 2) return false
    if (x - sizex / 2> b.x + b.sizex / 2) return false
    if (b.x - b.sizex / 2 > x + sizex / 2) return false
    return true
end

-- drawing
function mspr(s, x, y, fx, fy)
    fx = fx or false
    fy = fy or false
    sspr(
        s[1], s[2],         -- spr coordinates
        s[3], s[4],         -- spr width and height
        x - s[5], y - s[6], -- center x center y
        s[3], s[4],
        fx, fy              -- flip x flip y
    )
end

function drw_collision_box(_𝘦𝘯𝘷)
    local sizex = sizex / 2
    local sizey = sizey / 2
    rect(x - sizex, y - sizey, x + sizex, y + sizey, 0)
end

function cycanim(age, arr, spd, inv)
    local spd = spd or 1
    local t = age \ spd
    if inv then t = #arr - 1 - t % #arr
    else t = t % #arr
    end
    return arr[t + 1]
end
