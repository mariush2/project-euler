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
function permutationprime(prime, r)
    # This function checks if two of the digits in the prime, (any two positions!)
    # can be replaced with the "replace" number and still be a prime
    prime, r = string(prime), string(r)

    for first = 1:length(prime)
        for second = first + 1:length(prime)
            if parse(Int64, prime[first]) != parse(Int64, r) && parse(Int64, prime[second]) != parse(Int64, r)
                front = prime[1:first - 1]
                middle = prime[first + 1:second - 1]
                back = prime[second + 1:end]
                test = front * r * middle * r * back
                test = parse(Int64, test)
                if isprime(test)
                    return true
                end
            else
                continue
            end
        end
    end
    return false
end

function findnextprime(current)
    current = current + 2
    while !isprime(current)
        current = current + 2
    end
    return current
end

function problem51()
    current = 997
    while true
        current_amount = 1
        for i = 0:9
            if permutationprime(current, i)
                current_amount = current_amount + 1
            end
        end
        if current_amount == 8
            return current
        else
            current = findnextprime(current)
        end
    end
end

println(problem51())
