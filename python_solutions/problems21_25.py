from math import *
import string
from itertools import *
from decimal import *


#problem 21
def find_divisors(n):
    divisors = []
    for num in range(1, n - 1):
        if(n % num == 0):
            divisors.append(num)

    return divisors


def d(n):
    return sum(find_divisors(n))


def amicable(upper):
    amicable = []
    for a in range(0, upper):
        b = d(a)
        if(d(b) == a and a != b):
            amicable.append(a)

    return sum(amicable)


#Problem 22
names = []
with open("names.txt") as inputfile:
    for line in inputfile:
        names = line.split(",")

def name_score(name):
    name = name.upper()
    alfabet = list(string.ascii_uppercase)
    sum = 0
    for letter in name:
        for i in range(len(alfabet)):
            if(letter == alfabet[i]):
                sum += i + 1
                break
    return sum


def total_score(names):
    names.sort()
    total = 0
    for i in range(len(names)):
        total += score(names[i]) * (i + 1)
    return total


#Problem 23
def check_abuntant(num):
    if(num >= 12):
        return d(num) > num
    else:
        return False

def check_sum(list, num):
    if(num < 24):
        return False


def non_abuntant_sum():
    #28123
    sum = 0
    abuntant = []
    full = range(1, 28123)
    i = 2
    for num in islice(full, 1, None):
        #Find abuntant numbers we can use
        if(check_abuntant(num)):
            abuntant.append(num)

    can = []
    for new in range(0, 28124):
        can.append(False)
    for i in range(0, len(abuntant)):
        for j in range(i, len(abuntant)):
            if(abuntant[i] + abuntant[j] <= 28123):
                can[abuntant[i] + abuntant[j]] = True
            else:
                break

    for i in full:
        if(not(can[i])):
            sum += i
    return sum


#Problem 24
def lexiograph(nums, n):
    #Check if nums are sorted when coming in
    for i in range(0, len(nums)-1):
        if(nums[i] > nums[i + 1]):
            return "You entered something wrong!"

    return "".join([x for x in list(permutations(nums))[n-1]])

#Problem 25
def digits_in_fib(n):
    phi = (1 + sqrt(5)) / 2
    return int(n*log10(phi) - (log10(5)) / 2) + 1

def digit_fib(n):
    i = 1
    while digits_in_fib(i) < n:
        i += 1
    return i

#Problem 21
#amicable(10000)
#
#Problem 22
#total_score(names)
#
#Problem 23
#non_abuntant_sum()
#
#Problem 24
#lexiograph("0123456789", 1000000)
#
#Problem 25
digit_fib(1000)
