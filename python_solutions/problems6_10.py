from math import sqrt, factorial; from itertools import count, islice

def isPrime(n):
    return n > 1 and all(n%i for i in islice(count(2), int(sqrt(n)-1)))
#Got from stackoverflow :)

#Problem 6
def diff_sum_square(upper):
    sum_square, square_sum = 0, 0

    for i in range(upper + 1):
        sum_square += i ** 2
        square_sum += i

    square_sum = square_sum ** 2
    diff = square_sum - sum_square
    return diff


#Problem 7
def nth_prime(n):
    primes = []
    num = 1
    while(len(primes) < n):
        if(isPrime(num)):
            primes.append(num)

        num += 1
    return primes[n - 1]


#Problem 8
def largest_product_in_series(n):
    full = '731671765313306249192251196744265747423553491949349698352031277450632623957831801698480186947885184385861560789112949495459501737958331952853208805511125406987471585238630507156932909632952274430435576689664895044524452316173185640309871112172238311362229893423380308135336276614282806444486645238749303589072962904915604407723907138105158593079608667017242712188399879790879227492190169972088809377665727333001053367881220235421809751254540594752243525849077116705560136048395864467063244157221553975369781797784617406495514929086256932197846862248283972241375657056057490261407972968652414535100474821663704844031998900088952434506585412275886668811642717147992444292823086346567481391912316282458617866458359124566529476545682848912883142607690042242190226710556263211111093705442175069416589604080719840385096245544436298123098787992724428490918884580156166097919133875499200524063689912560717606058861164671094050775410022569831552000559357297257163626956188267042825248360082325753042752963450'

    greatest_series = []
    greatest_product = 0
    for i in range(len(full) - n):
        series = []
        product = 1
        for num in range(i, n + i):
            num = int(full[num])
            series.append(num)
            product *= num

        if(product > greatest_product):
            greatest_product = product
            greatest_series = series

    return greatest_series, greatest_product


#Problem 9
def pythagorean_triplet():
    a, b, c = 0, 0, 0
    s = 1000
    for i in range(s / 3):
        for j in range(s / 2):
            a = i
            b = a + j
            c = s - a - b
            if(a * a + b * b == c * c):
                return a,b,c, a*b*c


#Problem 10
def sum_of_primes(upper):
    sum = 0
    for num in islice(range(upper), 0, upper - 1):
        if(isPrime(num)):
            sum += num

    return sum


#Problem 6
#diff_sum_square(100)
#
#Problem 7
#nth_prime(10001)
#
#Problem 8
#largest_product_in_series(13)
#
#Problem 9
#pythagorean_triplet()
#
#Problem 10
#sum_of_primes(2000000)
