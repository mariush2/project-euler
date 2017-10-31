from math import *
import string
from itertools import *


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
    else:
        for x in list:
            for y in list:
                if(x + y == num):
                    return False
        else:
            return True


def non_abuntant_sum():
    #28123
    sum = 0
    abuntant = []
    full = range(1, 28123)
    for num in islice(full[:len(full) / 2], 1, None):
        #Go from that number and down, check if abuntant numbers are equal to it
        if(check_abuntant(num)):
            abuntant.append(num)

    for num in islice(full, 1, None):
        if(check_sum(abuntant[:num-12], num)):
            sum += num

    return sum


#Problem 21
#amicable(10000)
#
#Problem 22
#total_score(names)
#
#Problem 23
non_abuntant_sum()
