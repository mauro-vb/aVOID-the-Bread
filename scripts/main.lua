function ccolors()
    palt(0, false)
    palt(12, true)
    poke(0x5f2e, 1)
    local cmap = {

    }
    for c in all(cmap) do
        pal(c[1], c[2], 1)
    end
end

-- setup global references

global = _ENV
_noop = function() end

function _init()
    ccolors()
    maplims = { minx = 0, maxx = 52 * 8, miny = 0, maxy = 32 * 8 }
    startpx, startpy = maplims.maxx / 2, maplims.maxy / 2
    debug_on = false
    scene:load(ss)
    --scene:load(ss)
end

function _update60()
    routines_upd()
    scene.current:upd()
    if trans != nil then
        trans:upd()
    end
end

function _draw()
    scene.current:drw()
    if trans != nil then
        trans:drw()
    end
end
