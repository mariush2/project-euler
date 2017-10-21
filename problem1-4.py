#Problem 1
def find_sum_of_multi(lim):
    return sum([i for i in range(1, lim) if i % 3 == 0 or i % 5 == 0])


#Problem 2
def fib(n):
    if(n <= 1):
        return 1
    return fib(n - 1) + fib(n - 2)


def find_sum_fib(upper):
    n = 0
    sum = 0
    while(fib(n) < upper):
        if(fib(n) % 2 == 0):
            sum += fib(n)
        n += 1

    return sum


#Problem 3
def isPrime(n):
    if(n == 2):
        return True
    elif((n % 2 == 0) or (n < 0)):
        return False
    else:
        for num in range(3, int(n ** 0.5), 2):
            if((n % num == 0) and (n != num)):
                return False
        else:
            return True


def largest_prime_factor(find):
    primes = []
    while True:
        if(isPrime(find)):
            #Cant split the number more, must be prime
            primes.append(find)
            return primes
        else:
            for num in range(2, int(find ** 0.5)):
                if(isPrime(num) and find % num == 0):
                    find /= num
                    primes.append(num)
                    break


def palindrome(num):
    reversed = int(str(num)[::-1])
    return reversed == num


def set_to_highest(n):
    return 10 ** n - 1

def set_to_lowest(n):
    return 10 ** (n-1)


def largest_palindrome_product(n):
    #n is amount of digits
    min = set_to_lowest(n)
    max = set_to_highest(n)

    biggest = 0
    for a in range(min, max + 1):
        for b in range(a + 1, max + 1):
            product = a*b
            if product > biggest and palindrome(product):
                biggest = product
    return biggest

#Problem 1
#find_sum_of_multi(1000)
#
#Problem 2
#find_sum_fib(4000000)
#
#Problem 3
#largest_prime_factor(600851475143)
#
#Problem 4
largest_palindrome_product(n)
