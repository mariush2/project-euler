#Problem 1
function multiples_of_3_or_5(x)
    result = 0
    for i = 1:x
        if i % 3 == 0 | i % 5 == 0
            result += 1
        end
    end
end
