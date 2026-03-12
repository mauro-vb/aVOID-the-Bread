function ss_init(_ENV)
    global.cam = nil
    pressed = false
    _upd = ss_upd
    _drw = ss_drw
    global.cam = nil
    x, y = startpx, startpy
    mapx, mapy = rndrange(0, 6), 0
    camera(startpx - 64, startpy - 64)
    --b = bagel({x = peek2(0x5f28) + 64, y = peek2(0x5f2a) + 64, dummy = true, p = {x = startpx, y = startpy, post = 0}})
end

function ss_upd(_ENV)
    if (pressed) return
    if btnp(🅾️) or btnp(❎) then
        pressed = true
        --scene:load(game)
        transition({ new_scene = story })
    end
    --b:upd()
end

function ss_drw(_ENV)
    map(mapx, mapy)
    print("\^w\^t\^o040 A-VOID \nTHE BREAD", x - 35 , y - 30, 15)
    print("\^o040PRESS ❎ / 🅾️", x - 28 , y , 15)
    --b:drw()
end

ss = scene:extend({
    init = ss_init,
    upd = ss_upd,
    drw = ss_drw,
})
