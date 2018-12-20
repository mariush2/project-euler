#Problem 1
function multiples_of_3_or_5(x)
    sum = 0
    for i = 1:x-1
        if i % 3 == 0 || i % 5 == 0
            sum += i
        end
    end
    return sum
end

#print(multiples_of_3_or_5(1000))

#Problem 2
function nth_fibonacci(n)
    if n < 1
        return "Invalid value"
    end
    if n == 1
        return 1
    elseif n == 2
        return 2
    else
        return nth_fibonacci(n-2) + nth_fibonacci(n-1)
    end
end

function sum_even_fibonacci(x)
    sum = 0
    i = 1
    current = 1
    while current < x
        if current % 2 == 0
            sum += current
        end
        i += 1
        current = nth_fibonacci(i)
    end
    return sum
end

#print(sum_even_fibonacci(4e6))

#Problem 3

function is_prime(n)
    if n < 1
        return false
    elseif n <= 3
        return true
    elseif n % 2 == 0 || n % 3 == 0
        return false
    end
    i = 5
    while i * i <= n
        if n % i == 0 || n % (i + 2) == 0
            return false
        end
        i += 6
    end
    return true
end

#print(next_prime(11))

function prime_factor(n)
    factors = []
    while true
        if is_prime(n)
            #Cant split the number more, must be prime
            if n != 1
                push!(factors, n)
            end
            return factors
        else
            for i = 2:ceil(√n)
                if is_prime(i) && n % i == 0
                    n /= i
                    push!(factors, i)
                end
            end
        end
    end
end

#print(prime_factor(600851475143))
