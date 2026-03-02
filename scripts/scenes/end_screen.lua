function end_init(_𝘦𝘯𝘷)
    pressed = false
    _upd = end_upd
    _drw = end_drw
    x = cam.x; y = cam.y
    mapx, mapy = rndrange(0, 6), 0
end

function end_upd(_𝘦𝘯𝘷)
    if (pressed) return
    if btnp(❎) then
        pressed = true
        scene:load(game)
    elseif btnp(🅾️) then
        pressed = true
        scene:load(ss)
    end
end

function end_drw(_𝘦𝘯𝘷)
    map(mapx, mapy)
    local strs = {"BAGELS", "BAGUETTES", "LOAVES", "OVENS"}
    for e=1,#strs do
        local tmp = strs[e]
        local verb = tmp == "OVENS" and "DESTROYED " or "COOKED "
        print("\^o040"..verb..tostr(encount[tmp]).." VOID "..tmp, x -45 , 20 + y + 8 * e, 15)
    end
    print("\^w\^t\^o040GAME OVER", x - 35 , y - 30, 15)
    print("\^o040rEACHED LVL "..tostr(p.level), x - 28 , y - 15, 15)
    print("\^o040❎ AGAIN / 🅾️ QUIT", x - 34, y, 15)
end

end_screen = scene:extend({
    init = end_init,
    upd = end_upd,
    drw = end_drw,
})
