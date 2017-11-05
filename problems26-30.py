from math import *
from itertools import *

#Problem 26
def cycle_length(n):
    first = 1 % 7
    found = []
    for i in range(n):
        found.append(0)
    value = 1
    pos = 0

    while(found[value] == 0 and value != 0):
        found[value] = pos
        value *= 10
        value %= i
        pos += 1

    return pos - found[value]

def reciprocal_cycle(upper):
    longest = 0
    d = 0
    for n in range(2, upper):
        n_length = cycle_length(n)
        if(n_length >= longest):
            longest = n_length
            d = n - 1
    return d, longest


#Problem 27
def isPrime(n):
    return n > 1 and all(n%i for i in islice(count(2), int(sqrt(n)-1)))

def f(n, a, b):
    return (n ** 2) + a * n + b

def quadratic_primes(a, b):
    primes = 0
    while True:
        if(isPrime(f(primes, a, b))):
            primes += 1
        else:
            return primes


def find_highest(upper):
    highest = 0
    high_a = 0
    high_b = 0
    for a in range(0, upper):
        for b in range(0, upper + 1):
            reg = quadratic_primes(a,b)
            a = -a
            neg_a = quadratic_primes(a ,b)
            b = -b
            neg = quadratic_primes(a, b)
            a = abs(a)
            neg_b = quadratic_primes(a, -b)
            current = max(reg, neg_a, neg_b, neg)
            if(current > highest):
                highest = current
                high_a = a
                high_b = b

    return high_a * high_b


#Problem 28
def generate_spiral(n):
    sum = 1
    reach = 2
    last = 1
    amount = 0
    for num in range(1, (n*n)+1, 2):
        if(num % 2 > 0 and abs(num - last) == reach):
            last = num
            amount += 1
            sum += num
        if(amount == 4):
            #extended reach
            amount = 0
            reach += 2
    return sum


#Problem 29
def distinct_powers(lower, upper):
    full = []
    for a in range(lower, upper + 1):
        for b in range(lower, upper + 1):
            if (a ** b not in full):
                full.append(a**b)
    return len(set(full))


#Problem 30
def digit_nth_powers(n):
    list = []
    for num in range(2, (n+1)*9**n):
        current = 0
        for digit in str(num):
            current += int(digit) ** n
        if(current == num):
            list.append(num)
    return sum(list)

#Problem 26
#reciprocal_cycle(1000)
#
#Problem 27
#find_highest(1000)
#
#Problem 28
#generate_spiral(1001)
#
#Problem 29
#distinct_powers(2,100)
#
#Problem 30
digit_nth_powers(5)
