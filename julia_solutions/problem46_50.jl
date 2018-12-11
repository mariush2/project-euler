#using Primes
# Problem 46
function istwicesquare(number)
    squareTest = sqrt(number/2)
    return squareTest == floor(squareTest)
end

function problem46()
    p = primes(10000)
    result = 1
    notFound = true;

    while notFound
        result = result + 2
        j = 1
        notFound = false
        while result >= p[j]
            if istwicesquare(result-p[j])
                notFound = true
                break
            end
            j = j + 1
        end
    end
    return result
end

#println(problem46())

#Problem 47
function addfactors!(list, factors)
    for i = 1:length(factors)
        push!(list, factors[i])
    end
end

function convertfactorlist!(list)
    new = []
    for i = 1:length(list)
        push!(new, list[i][1] * list[i][2])
    end
    list = new
end

function problem47(n)
    num = 1
    used = []
    notFound = true
    while notFound
        factors = convertfactorlist!(collect(factor(num)))
        used = []
        if length(factors) == n
            addfactors!(used, factors)
            for i = num+1:num+n-1
                factors = convertfactorlist!(collect(factor(i)))
                common = intersect(factors, used)
                if length(factors) != n || length(common) != 0
                    break
                else
                    addfactors!(used, factors)
                end
                if length(used) == n * n
                    notFound = false
                end
            end
        end
        if !notFound
            return num, used
        end
        num = num + 1
    end
end

#println(@time problem47(4))

#Problem 48
function problem48()
    return string(sum([i^i for i in 1:big(1000)]))[end-9:end]
end

println(@time problem48())
