function ss_init(_𝘦𝘯𝘷)
    pressed = false
    _upd = ss_upd
    _drw = ss_drw
    if cam then
        x, y = cam.x, cam.y
    else
        x, y = 64, 64
    end
    mapx, mapy = rndrange(0, 6), 0
end

function ss_upd(_𝘦𝘯𝘷)
    if (pressed) return
    if btnp(🅾️) or btnp(❎) then
        pressed = true
        scene:load(game)
    end
end

function ss_drw(_𝘦𝘯𝘷)
    map(mapx, mapy)
    print("\^w\^t\^o040 A-VOID \nTHE BREAD", x - 35 , y - 30, 15)
    print("\^o040PRESS ❎ / 🅾️", x - 28 , y , 15)
end

end_screen = scene:extend({
    init = end_init,
    upd = end_upd,
    drw = end_drw,
})
ss = scene:extend({
    init = ss_init,
    upd = ss_upd,
    drw = ss_drw,
})
