function baguette_dash(_ENV)
    dashing = true
    local chargex, chargey = (-dirtop.x * 8), (-dirtop.y * 8)
    local chargef = 20

    local maxforce = 60
    local dashforce = mid(15, disto(_ENV, p), maxforce) + rndrange(-5,5)
    local dashf = mid(40, dashspd - 10 * (dashforce / maxforce), dashspd)
    local dashx = dirtop.x * dashforce
    local dashy = dirtop.y * dashforce

    chaintweens({
        {
            tween_factory(_ENV, "x", x + chargex, chargef, smoothstep),
            tween_factory(_ENV, "y", y + chargey, chargef, smoothstep)
        },
     --   tween_wait(1),
        {
            tween_factory(_ENV, "x", x + dashx, dashf, overshoot),
            tween_factory(_ENV, "y", y + dashy, dashf, overshoot)
        }
    }, function() dashing = false end, true)
end

function baguette_upd_visuals(_ENV)
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

function baguette_ai(_ENV)
    if (p == nil) return nil
    if not dashing then
        baguette_upd_visuals(_ENV)
    end
    dirtop = getdir(_ENV, p)
    if timer >= 0 then
        if not (paralize_t > 0) then
            timer -= 1
        end

    else
        if disto(_ENV, p) < 64  and collides(_ENV, scene.cam) then
            timer = waitt + rnd(variationt)
            baguette_dash(_ENV)
        else
            setcardinaldir(_ENV, p)
            x += move_speed * dx
            y += move_speed * dy
        end
    end
end

function baguette_drw(_ENV)
    mspr(sprarr, x, y, flipx)
    drwhp(_ENV)
end

baguette = enemy:extend({

    dashspd = 60,
    move_speed = .5,
    sprarr = myspr[26],
    sprarrs = {myspr[26], myspr[27], myspr[28]},
    enemy_ai = baguette_ai,
    drw = baguette_drw,
    timer = 120,
    ai_state = "wait",
    variationt = 50,
    dashing = false,
    enemy_init = function(_ENV)
        hp = enstats[enstats_i][3][1]
        waitt = enstats[enstats_i][2][2]
    end,
})
