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
function eight_prime(prime, rd)
    count = 0
    for digit in "012345789"
        test = parse(Int64, replace(prime, rd => digit))
        if test > 100000 && isprime(test)
            count = count + 1
        end
    end
    return count == 8
end

function problem51()
    all = primes(100000)
    for prime in all
        if prime > 100000
            s = string(prime)
            last_digit = s[end]
            if eight_prime(s, "0") || (last_digit != '1' && eight_prime(s, "1")) || eight_prime(s, "2")
               return s
            end
       end
   end
   return "No return"
end

# println(problem51())
