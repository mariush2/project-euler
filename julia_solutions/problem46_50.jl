using Primes, Combinatorics
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

#println(@time problem48())

#Problem 49
function findpermutationprime!(n, all)
    for num in permutations(string(n))
        if num[1] != '0'
            num = parse(Int64, join(num))
            if isprime(num) && !(num in all)
                #Found second, now save diff and check if the last is prime
                push!(all, num)
            end
        end
    end
end

function checkdiff!(A)
    sort!(A)
    for i = 1:length(A)
        for j = i + 1:length(A)
            diff = abs(A[j] - A[i])
            if (A[j] + diff) in A
                #Found the third prime
                return [A[i], A[j], A[j] + diff]
            end
        end
    end
    return []
end

function problem49()
    n = 1001
    forbidden = []
    findpermutationprime!(1487, forbidden)
    while n < 10000
        all = []
        if isprime(n) && !(n in forbidden)
            #Found first, now look for second
            push!(all, n)
            findpermutationprime!(n, all)
            all = checkdiff!(all)
            if length(all) == 3
                #Found
                println(all)
                return join(all)
            end
        end
        n = n + 1
    end
    return "Not found"
end

#println(@time problem49())

#Problem 50
function problem50(upper)
    all = primes(upper)
    prime_sums = collect(1:length(all) + 1)
    len = -1
    prime = -1
    fill!(prime_sums, 0)
    prime_sums[1] = 0
    for i = 2:length(prime_sums)
        prime_sums[i] = prime_sums[i - 1] + all[i - 1]
    end
    for i = 1:length(prime_sums)
        for j = i + 1:length(prime_sums)
            current = prime_sums[j] - prime_sums[i]
            if current in all && j - i > len
                len = j - i
                prime = current
            end
        end
    end
    return prime
end

println(@time problem50(10^6))
