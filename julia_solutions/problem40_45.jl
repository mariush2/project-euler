# Problem 44
function is_pentagonal(n)
    #(Math.Sqrt(1 + 24 * number) + 1.0) / 6.0;
    penTest = (sqrt(1 + 24 * n) + 1.0) / 6.0
    return penTest == floor(penTest)
end

function problem_44()
    print("Running problem 44...\n")
    result = 0
    runs = 0
    notFound = true
    i = 1

    while notFound
        i = i + 1
        n = i * (3 * i - 1) / 2

        for j = i-1:-1:1
            m = j * (3 * j - 1) / 2
            runs = runs + 1
            if is_pentagonal(n - m) && is_pentagonal(n + m)
                result = n - m
                notFound = false
                break
            end
        end
    end
    return "Gave: " * string(result) * ", ran " * string(runs) * " times"
end

#println(problem_44())

# Problem 45
function is_hexagonal(n)
    hexTest = (1 + sqrt(1 + 8*n)) / 4
    return hexTest == floor(hexTest)
end

function triangle_num(n)
    return (n * (n + 1)) / 2
end

function problem45()
    println("Running problem 45...")
    n = 286
    tri = 0
    notFound = true
    while notFound
        tri = triangle_num(n)
        if is_hexagonal(tri) && is_pentagonal(tri)
            break;
        else
            n = n + 1
        end
    end
    return string("Found: ", tri)
end

#println(problem45())
