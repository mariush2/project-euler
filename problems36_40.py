#Problem 36
from problems1_5 import palindrome as palindrome
#Problem 37
from problems31_35 import isPrime as isPrime
from itertools import *


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

#Problem 36
#double_base_palindrome_sum(1000000)
#
#Problem 37
#all_truncatable_primes()
