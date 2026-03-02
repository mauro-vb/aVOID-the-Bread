function sorty(arr)
    for i = 1, #arr do
        local j = i - 1
        local e = arr[i]
        while j >= 1 and e.y < arr[j].y do
            arr[j + 1] = arr[j]
            j -= 1
        end
        arr[j + 1] = e
    end
end
