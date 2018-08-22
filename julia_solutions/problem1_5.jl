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
    if n <= 1
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

function next_prime(n)
    i = n + 1
    while true
       if is_prime(i)
           return i
       end
       i += 1
   end
   return nothing
end




function largest_prime_factor(n)
    if !(is_prime(n))
        i = 1
        largest = i
        while  i < n
            if n % i == 0
                largest = i
            else
                i = next_prime(i)
            end
        end
        return largest
    end
    return nothing
end

print(largest_prime_factor(13195))


#TODO
#Put this answer to 40_45 file
#
#Sol
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
    return result, runs
end

#print(problem_44())
