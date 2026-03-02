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

global = _𝘦𝘯𝘷
_noop = function() end

function _init()
    ccolors()
    debug_on = false
    scene:load(ss)
end

function _update60()
    routines_upd()
    scene.current:upd()
end

function _draw()
    scene.current:drw()
end
