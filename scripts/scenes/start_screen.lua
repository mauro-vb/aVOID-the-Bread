function ss_init(_𝘦𝘯𝘷)
    pressed = false
    _upd = ss_upd
    _drw = ss_drw
    global.cam = nil
    x, y = startpx, startpx - 64
    mapx, mapy = rndrange(0, 6), 0
    camera(startpx - 64, startpy - 64)
end

function ss_upd(_𝘦𝘯𝘷)
    if (pressed) return
    if btnp(🅾️) or btnp(❎) then
        pressed = true
        --scene:load(game)
        transition({new_scene = story})
    end
end

function ss_drw(_𝘦𝘯𝘷)
    map(mapx, mapy)
    print("\^w\^t\^o040 A-VOID \nTHE BREAD", x - 35 , y - 30, 15)
    print("\^o040PRESS ❎ / 🅾️", x - 28 , y , 15)
end

ss = scene:extend({
    init = ss_init,
    upd = ss_upd,
    drw = ss_drw,
})
