upgrade_ui = game_object:extend({
    selected = 1,
    init = function(_𝘦𝘯𝘷)
        buttons = {}
        x = cam.x; y = cam.y
        global.paused = true
        for part in all(parts) do
            del(parts, part)
        end
        for tw in all(routines) do
            if tw.pausable then del(routines, tw) end
        end
        global.routines = {}
        for i = 1, #upgrades do
            add(buttons, upgrade_button({ x = -64 + 32 * i, y = -10, upgrade = upgrades[i], selected = i == 1 }))
        end
        sbutt = buttons[selected]
    end,
    upd = function(_𝘦𝘯𝘷)
        if btnp(➡️) then
            sfx(8)
            selected += 1
            selected = selected > #buttons and 1 or selected
        end
        if btnp(⬅️) then
            sfx(8)
            selected -= 1
            selected = selected < 1 and #buttons or selected
        end
        --selected = mid(1, selected, #buttons)
        sbutt = buttons[selected]
        for button in all(buttons) do
            button.selected = sbutt == button
        end
        if btnp(🅾️) then
            sfx(11)
            sbutt:trigger()
            upgrades = {}
            buttons = {}
            global.ui = game_ui
            global.paused = false
        end
    end,
    drw = function(_𝘦𝘯𝘷)
        drw_group(buttons)
        rectfill(cam.x - 64, cam.y + 54, cam.x + 64, cam.y + 64, 7)
        print(sbutt.upgrade.name, cam.x - 2 * #sbutt.upgrade.name, cam.y + 57, 0)
    end
})

upgrade_button = game_object:extend({
    x = 0,
    y = 0,
    bc = 0,
    c = 15,
    upgrade = nil,
    selected = false,
    init = function(_𝘦𝘯𝘷)
        width = width or 24
        height = height or 24
    end,
    drw = function(_𝘦𝘯𝘷)
        sx = cam.x + x
        sy = cam.y + y
        local bx = sx - width / 2
        local by = sy - width / 2
        if selected then
            rectfill(bx - 1, by - 1, bx + width + 1, by + height + 1, 7)
        end
        rectfill(bx, by, bx + width, by + height, bc)
        rectfill(bx + 1, by + 1, bx + width - 1, by + height - 1, c)
        mspr(upgrade.icon, sx, sy)
    end,
    trigger = function(_𝘦𝘯𝘷)
        upgrade:trigger()
    end
})
