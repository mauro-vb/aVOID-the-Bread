function baguette_dash(_𝘦𝘯𝘷)
    dashing = true
    local chargex, chargey = (-dirtop.x * 8), (-dirtop.y * 8)
    local chargef = 25

    local maxforce = 60
    local dashforce = mid(15, disto(_𝘦𝘯𝘷, p), maxforce) + rndrange(-5,5)
    local dashf = mid(40, 50 * (dashforce / maxforce), 60)
    local dashx = dirtop.x * dashforce
    local dashy = dirtop.y * dashforce

    local trans = overshoot
    chaintweens({
        {
            tween_factory(_𝘦𝘯𝘷, "x", x + chargex, chargef, smoothstep),
            tween_factory(_𝘦𝘯𝘷, "y", y + chargey, chargef, smoothstep)
        },
        tween_wait(15),
        {
            tween_factory(_𝘦𝘯𝘷, "x", x + dashx, dashf, trans),
            tween_factory(_𝘦𝘯𝘷, "y", y + dashy, dashf, trans)
        }
    }, function() dashing = false end, true)
end

function baguette_upd_visuals(_𝘦𝘯𝘷)
    local ang = atan2(p.x - x, p.y -y)
    if (ang < .45 and ang > .3) or (ang < .95 and ang > .8) then
        sprarr = sprarrs[1]
        flipx = true
    elseif (ang < .70 and ang > .55) or (ang < .2 and ang > .05) then
        sprarr = sprarrs[1]
        flipx = false
    elseif (ang > .2 and ang < .3) or (ang > .7 and ang < .8) then
        sprarr = sprarrs[2]
        flipx = p.x > x
    else
        sprarr = sprarrs[3]
        flipx = p.x > x
    end
end

function baguette_ai(_𝘦𝘯𝘷)
    if (p == nil) return nil
    if not dashing then
        baguette_upd_visuals(_𝘦𝘯𝘷)
    end
    dirtop = getdir(_𝘦𝘯𝘷, p)
    if timer >= 0 then
        if not (paralize_t > 0) then
            timer -= 1
        end

    else
        if disto(_𝘦𝘯𝘷, p) < 64  and collides(_𝘦𝘯𝘷, scene.cam) then
            timer = waitt + rnd(variationt)
            baguette_dash(_𝘦𝘯𝘷)
        else
            setcardinaldir(_𝘦𝘯𝘷, p)
            x += move_speed * dx
            y += move_speed * dy
        end
    end
end

function baguette_drw(_𝘦𝘯𝘷)
    mspr(sprarr, x, y, flipx)
    drwhp(_𝘦𝘯𝘷)
end

baguette = enemy:extend({
    hp = 30,
    move_speed = .5,
    sprarr = myspr[26],
    sprarrs = {myspr[26], myspr[27], myspr[28]},
    enemy_ai = baguette_ai,
    drw = baguette_drw,
    timer = 120,
    ai_state = "wait",
    waitt = 180,
    variationt = 50,
    dashing = false,
})
