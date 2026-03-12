function dopart(_ENV)
    -- age and wait
    if wait then
        wait -= 1
        if wait <= 0 then
            wait = nil
            if parentp then
                x = parentp.x; y = parentp.y
                if offsetx then
                    x += offsetx
                end
                if offsety then
                    y += offsety
                end
            end
        end
    else
        age = age or 0
        c = c or ctab[i]
        if age == 0 then
            ox = x
            oy = y
            size = size or 1
            ctabv = ctabv or 0
            tospd = tospd or 1
        elseif freezeat == age then
            global.freeze_frames = freezeframes
        end
        age += 1
        if age <= 0 then return end
        --particle code
        --animate color
        if ctab then
            local ci = (age + ctabv) / maxage
            ci = mid(1, flr(1 + ci * #ctab), #ctab)
            c = ctab[ci]
        end

        --movement
        -- to pos
        if tox then
            x += (tox - x) / (4 / tospd)
        end
        if toy then
            y += (toy - y) / (4 / tospd)
        end
        -- rotation
        if rotspd then
            rota = rota or 0
            cdist = cdist or 8
            rota += rotspd
            x = cx + sin(rota) * cdist
            y = cy + cos(rota) * cdist
        end
        -- linear
        if sx then
            if cx then
                cx += sx
            else
                x += sx
            end
            if tox then
                tox += sx
            end
            if drag then
                sx *= drag
            end
        end
        if sy then
            if cy then
                cy += sy
            else
                y += sy
            end
            if toy then
                toy += sy
            end
            if drag then
                sy *= drag
            end
        end

        --size
        if tosize then
            size += (tosize - size) / (5 / tospd)
        end
        if incrsize then
            size += incrsize
        end
        if age >= maxage or size < 1 then
            if onendf then onendf() end
            if onend == "return" then
                maxage += 32000
                tox = ox
                toy = oy
                tosize = nil
                incrsize = -0.3
            elseif onend == "fade" then
                maxage += 32000
                tosize = nil
                incrsize = -0.1 - rnd(0.3)
            else
                del(parts, _ENV)
            end
            ctab = nil
            onend = nil
        end
    end
end

particle = game_object:extend({
    age = 0,
    maxage = 0,
    x = 63,
    y = 63,
    size = 1,
    ctabv = nil,
    spd = 1,
    upd = dopart,
    init = function(_ENV)
        ox = x
        oy = y

        add(parts, _ENV)
        if pinit then pinit(_ENV) end
    end,
    drw = function(_ENV)
        if (wait) return
        pdrw(_ENV)
    end
})

function tweenp_init(_ENV)
    add(global.parts, _ENV)
    if tweens then
        chaintweens(tweens, function()
            del(global.parts, _ENV)
        end)
    end
end

tweenp = particle:extend({
    upd = _noop,
    init = tweenp_init,
})

function drw_circle(_ENV)
    if border then
        fillp(0xffff)
        circfill(x, y, size / 2 + 1, c)
        fillp(0x0)
    end
    circfill(x, y, size / 2, c)
end

circlep = particle:extend({
    size = 1,
    border = false,
    pdrw = drw_circle
})

rectp = particle:extend({
    iwidth = 2,
    iheight = 1,
    border = false,
    pinit = function (_ENV)
        width = iwidth * size
        height = iheight * size
    end,
    upd = function (_ENV)
        width = size * iwidth
        height = size * iheight
        dopart(_ENV)
    end,
    drw = function (_ENV)
        local w, h = width / 2, height / 2
        rectfill(x - w, y - h, x + w, y + h, c)
        if border then
            fillp(0xffff)
            rect(x - w, y - h, x + w, y + h, c)
            fillp(0x0)
        end
    end
})
