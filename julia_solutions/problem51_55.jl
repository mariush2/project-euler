using Primes
#Problem 51
#=


By replacing the 1st digit of the 2-digit number *3, it turns out that six of the nine possible values: 13, 23, 43, 53, 73, and 83, are all prime.

By replacing the 3rd and 4th digits of 56**3 with the same digit,
this 5-digit number is the first example having seven primes among the ten generated numbers,
yielding the family: 56003, 56113, 56333, 56443, 56663, 56773, and 56993.
Consequently 56003, being the first member of this family, is the smallest prime with this property.

Find the smallest prime which, by replacing part of the
number (not necessarily adjacent digits) with the same digit, is part of an eight prime value family.


=#
function makeNumber(t,d,c)
    counter = 0
    for i in 1:length(t)
        counter *= 10
        counter += (t[i]==11) ? d : t[i]
    end
    counter *= 10
    counter += c
end

function problem51()
    solution = 999999
    for a = 0:9
        for b = 0:9
            for c = 1:2:9
                for i in permutations([ a b 11 11 11 ])
                    counter = 0num
                    for d = 0:9
                        num = makeNumber(i,d,c)
                        if isprime(num) && num > 100000
                            counter += 1
                        end
                    end
                    if counter >=8
                        for d = 0:9
                            num = makeNumber(i,d,c)
                            if isprime(num) && num > 100000 && num < solution
                                solution = num
                            end
                        end
                    end
                end
            end
        end
    end
    solution
end

#println(problem51())

#Problem 52
function samedigits(x, y)
    x, y = string(x), string(y)
    check = Dict()
    for digit in x
        if haskey(check, digit)
            check[digit] += 1
        else
            check[digit] = 1
        end
    end
    for digit in y
        if haskey(check, digit)
            if check[digit] > 0
                check[digit] -= 1
            else
                return false
            end
        else
            return false
        end
    end
    return true
end

function problem52()
    x = 1
    while true
        found = true
        for i = 2:6
            if samedigits(x, i*x)
                continue
            else
                found = false
                break
            end
        end
        if found
            return x
        else
            x += 1
        end
    end
end

println(problem52())
