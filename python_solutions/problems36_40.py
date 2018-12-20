#Problem 36
from problems1_5 import palindrome as palindrome
#Problem 37
from problems31_35 import isPrime as isPrime
from itertools import *
#Problem 38
from problems31_35 import pandigital as pandigital
from math import *

#Problem 36
def double_base_palindrome_sum(upper):
    full = []
    for num in range(upper):
        if(palindrome(num) and palindrome(int("{0:b}".format(num)))):
            full.append(num)
    return sum(full)


#Problem 37
def truncatable_prime(num):
    num = str(num)
    #Check from the left and right
    for i in range(1, len(num)):
        left = num[:i]
        right = num[i:]
        if((not isPrime(int(left))) or (not isPrime(int(right)))):
            return False
    else:
        return True


def all_truncatable_primes():
    full = []
    num = 9
    while len(full) < 11:
        if(isPrime(num)):
            if(truncatable_prime(num)):
                full.append(num)
        num += 1
    return sum(full)


#Problem 38
def concate(num, num2):
    return int(str(num) + str(num2))

def pandigital_multiple():
    highest = 0
    for i in range(9234, 9387):
        current = concate(i, i*2)
        if(pandigital(current) and current > highest):
            highest = current
    return highest


#Problem 39
#Right angle triangles only!
#a^2 + b^2 = c^2
def find_amount_of_solutions(p):
    amount = 0
    for a in xrange(2, p/2):
        for b in xrange(2, a):
            c = sqrt(a ** 2 + b ** 2)
            if((a ** 2 + b ** 2) == c ** 2 and a+b+c == p):
                amount +=1
    return amount


def find_best_p(upper):
    current_p = 1
    best_p = 0
    best_amount = 0
    while(current_p <= upper):
        amount = find_amount_of_solutions(current_p)
        if(amount > best_amount):
            best_p = current_p
            best_amount = amount
        current_p += 1
    return best_p, best_amount


#Problem 40
def d_n(n, c):
    return int(c[n-1])


def c_n_length(n):
    full = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    c = "123456789"
    current = 1
    passed = False
    while len(c) <= n + 1:
        if(current < 10):
            if(passed):
                for i in range(10):
                    c += full[i] + full[current]
            else:
                for i in range(10):
                    c += full[current] + full[i]
            current += 1
        else:
            passed = True
            current = 0
    return c


def problem_40(upper):
    product = 1
    c = c_n_length(10 ** upper)
    for i in range(upper):
        cur = d_n(10 ** i, c)
        product *= cur
    return product


#Problem 36
#double_base_palindrome_sum(1000000)
#
#Problem 37
#all_truncatable_primes()
#
#Problem 38
#pandigital_multiple()
#
#Problem 39
#find_best_p(1000)
#
#Problem 40
print(c_n_length(10 ** 7)[0:500])
#problem_40(7)
