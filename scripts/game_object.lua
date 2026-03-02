-- parent class for objects with lifecycle loop
game_object = class:extend({
    init = _noop,
    upd = _noop,
    drw = _noop,
    destroy = _noop,
})
