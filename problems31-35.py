from math import *
from itertools import *
from itertools import *

#Problem 31
coins = [200,100,50,20,10,5,2,1]
def count_comb(left, i, comb, add):
    global coin
    if(add):
        comb.append(add)
    if(left == 0 or (i+1) == len(coins)):
        if((i+1) == len(coins) and left > 0):
            comb.append( (left, coins[i]) )
            i += 1
        while i < len(coins):
            comb.append( (0, coins[i]) )
            i += 1
        return 1
    cur = coins[i]
    return sum(count_comb(left-x*cur, i+1, comb[:], (x,cur),) for x in range(0, int(left/cur) + 1))


#Problem 32
def pandigital(num):
    return (len(set(str(num))) == len(str(num)) and "0" not in set(str(num)))


def different_numbers(x, y):
    x, y = str(x), str(y)
    if(len(set(x)) != len(x) or len(set(y)) != len(y)):
        return False
    return set(x).isdisjoint(y)


def pandigital_product(x, y, product):
    if(different_numbers(x, y) and pandigital(product) and pandigital(x) and pandigital(y)):
        if(different_numbers(product, x) and different_numbers(product, y)):
            return True
        else:
            return False
    return False


def full_pandigital(x, y, product):
    full = list(str(x) + str(y) + str(product))
    return len(set(full)) == 9


def find_pandigital_products():
    found = []
    for m in range(2, 9876):
        if(m > 9):
            nbegin = 123
        else:
            nbegin = 1234
        for n in range(nbegin, 9876-m):
            product = n*m
            if(pandigital_product(m, n, product) and product not in found and full_pandigital(m, n, product)):
                print(m,"*",n,"=",product)
                found.append(product)

    print(found)
    return sum(found)


#Problem 33
def find_fractions():
    full = []
    for a in range(10,98):
        for b in range(a+1,99):
            if(not set(str(a)).isdisjoint(str(b)) and (str(a)[1] != "0" and str(b)[1] != "0")):
                if(check_cancelling_fraction(a, b)):
                    full.append([a,b])

    upper = 1
    lower = 1
    for fraction in full:
        upper *= fraction[0]
        lower *= fraction[1]

    return lcd(upper, lower), upper, lower


def check_cancelling_fraction(a, b):
    actual = a/b
    #New values
    if(str(a)[0] in str(b)):
        common = str(a)[0]
        a = int(str(a)[1])
    else:
        common = str(a)[1]
        a = int(str(a)[0])

    if(common == str(b)[0]):
        b = int(str(b)[1])
    else:
        b = int(str(b)[0])

    new = a/b
    if(actual == new):
        #Not trivial
        return True
    return False


def isPrime(n):
    return n > 1 and all(n%i for i in islice(count(2), int(sqrt(n)-1)))


def lcd(a, b):
    num = int(sqrt(b))
    while(not(isPrime(a) and isPrime(b)) and num > 1):
        if(a % num == 0 and b % num == 0):
            a /= num
            b /= num
        else:
            num -= 1
    return a,b


#Problem 34
def same_as_factorial_sum(num):
    if(num <= 2):
        return False
    old = num
    num = str(num)
    sum = 0
    for digit in num:
        sum += factorial(int(digit))

    return sum == old


def find_curios_numbers():
    found = []
    for i in range(50000):
        if(same_as_factorial_sum(i)):
            found.append(i)

    return sum(found)


#Problem 35
def circular_prime(num):
    if(isPrime(num)):
        num = str(num)
        old_len = len(num)

        for digit in num[0:len(num)-1]:
            num += digit

        for i in range(len(num) - old_len + 1):
            new = int(num[i:i+old_len])
            if(not isPrime(new)):
                return False
        return True
    return False


def circular_primes_under(upper):
    circular_primes = []
    for num in range(upper):
        if(circular_prime(num)):
            circular_primes.append(num)
    return len(circular_primes)

#Problem  31
#count_comb(200, 0, [], None)
#
#Problem 32
#find_pandigital_products()
#
#Problem 33
#Run in python 3!
#print(find_fractions())
#
#Problem 34
#find_curios_numbers()
#
#Problem 35
circular_primes_under(1000000)
