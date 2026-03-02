class = setmetatable({
    -- track inheritance
    ancestors = {},

    -- extend a class
    extend = function(_𝘦𝘯𝘷, tbl)
        tbl = tbl or {}
        tbl.__index = tbl
        tbl.ancestors = {}

        -- add this classes ancestors to new class
        for a in all(_𝘦𝘯𝘷.ancestors) do
            add(tbl.ancestors, a)
        end

        -- add this class as an ancestor
        add(tbl.ancestors, _𝘦𝘯𝘷)

        setmetatable(tbl, {
            -- new class defers to this class for missing keys
            __index = _𝘦𝘯𝘷,

            -- allow class to be called as an initializer function
            -- ex: goomba({ x = 2 }) is the same as goomba:new({ x = 2 })
            -- this saves tokens when there are more than ~12 new calls
            __call = tbl.__call or function(_𝘦𝘯𝘷, tbl)
                return _𝘦𝘯𝘷:new(tbl)
            end
        })

        return tbl
    end,

    -- instantiate object
    new = function(_𝘦𝘯𝘷, tbl)
        tbl = tbl or {}
        setmetatable(tbl, _𝘦𝘯𝘷)
        tbl.class = _𝘦𝘯𝘷
        tbl:init()
        return tbl
    end,

    -- evaluate ancestors, ex: goomba:is(enemy)
    is = function(_𝘦𝘯𝘷, klass)
        return _𝘦𝘯𝘷.class == klass or count(ancestors, klass) > 0
    end,

    -- default initializer
    init = _noop
}, { __index = _𝘦𝘯𝘷 })

-- class is used as a metatable
-- so its index points to itself
class.__index = class
