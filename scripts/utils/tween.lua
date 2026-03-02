routines = {}

function tween_wait(f, callback)
    callback = callback or _noop
    local wait = function()
        for i = 1, f do
            yield()
        end
    end
    return { animation = wait, callback = callback }
end

function tween(obj, k, v, f, transition, callback, pausable)
    --pausable = pausable == nil and false or true
    local initial_v = obj[k]
    transition = transition or linear
    callback = callback or _noop
    animation = function()
        for i = 1, f do
            obj[k] = lerp(initial_v, v, transition(i / f))
            yield()
        end
    end
    return { animation = animation, callback = callback, pausable = pausable }
end

function tween_factory(obj, k, v, f, transition, callback, pausable)
    return function() return tween(obj, k, v, f, transition, callback, pausable) end
end

function dotween(obj, k, v, f, transition, callback, pausable)
    local tw = tween(obj, k, v, f, transition, callback)
    local co = cocreate(tw.animation)
    add(routines, { co = co, callback = tw.callback, pausable = pausable })
end

function chaintweens(steps, final_callback, pausable)
    final_callback = final_callback or _noop

    local function chain()
        for step in all(steps) do
            -- wrap a single tween in a table so we can treat all steps uniformly
            if not step[1] then
                step = { step }
            end

            -- create a coroutine for every tween in this step
            local cos = {}
            for tw in all(step) do
                tw = type(tw) == "function" and tw() or tw
                add(cos, {
                    co = cocreate(tw.animation),
                    callback = tw.callback,
                    pausable = pausable
                })
            end

            -- parallel coroutines, one yield at a time
            local running = true
            while running do
                running = false
                for item in all(cos) do
                    if costatus(item.co) != "dead" then
                        running = true
                        assert(coresume(item.co))
                    end
                end
                if running then yield() end
            end

            -- fire each tween's callback
            for item in all(cos) do
                item.callback()
            end
        end

        -- all steps complete
        final_callback()
    end

    add(routines, {
        co       = cocreate(chain),
        callback = _noop,
        pausable = pausable
    })
end

function routines_upd()
    for routine in all(routines) do
        if costatus(routine.co) == "dead" then
            routine.callback()
            del(routines, routine)
        else
            assert(coresume(routine.co))
        end
    end
end

-- 𝘵𝘳𝘢𝘯𝘴𝘪𝘵𝘪𝘰𝘯 𝘵𝘺𝘱𝘦𝘴

function linear(t)
    return t
end

function expo(t)
    if t == 0 then return 0 end
    if t == 1 then return 1 end

    if t < 0.5 then
        return 0.5 * 2 ^ (20 * t - 10)
    else
        return 1 - 0.5 * 2 ^ (-20 * t + 10)
    end
end

function cubic(t)
    if t < 0.5 then
        return 4 * t * t * t
    else
        t -= 1
        return 1 + 4 * t * t * t
    end
end

function quad(t)
    if (t < .5) then
        return t * t * 2
    else
        t -= 1
        return 1 - t * t * 2
    end
end

function quart(t)
    if t < 0.5 then
        return 8 * t * t * t * t
    else
        t -= 1
        return 1 - 8 * t * t * t * t
    end
end

function quint(t)
    if t < 0.5 then
        return 16 * t ^ 5
    else
        t -= 1
        return 1 + 16 * t ^ 5
    end
end

function smoothstep(t)
    return t * t * (3 - 2 * t)
end

function smootherstep(t)
    return t * t * t * (t * (t * 6 - 15) + 10)
end

function overshoot(t)
    if (t < .5) then
        return (2.7 * 8 * t * t * t - 1.7 * 4 * t * t) / 2
    else
        t -= 1
        return 1 + (2.7 * 8 * t * t * t + 1.7 * 4 * t * t) / 2
    end
end

function elastic(t)
    if t < .5 then
        return 2 ^ (10 * 2 * t - 10) * cos(2 * 2 * t - 2) / 2
    else
        t -= .5
        return 1 - 2 ^ (-10 * 2 * t) * cos(2 * 2 * t) / 2
    end
end
