#Problem 41
from problems31_35 import pandigital as pandigital
from problems31_35 import isPrime as isPrime
from itertools import *
from math import sqrt;

def largest_n_digit_pandigital_prime(n):
    available = ""
    for i in xrange(1, n + 1):
        available += str(i)

    highest = 0
    for num in permutations(available, n):
        new = ""
        for i in num:
            new += i
        new = int(new)
        if(isPrime(new) and pandigital(new) and new > highest):
            highest = new

    return highest

def find_highest():
    n = 9
    while n > 0:
        new = largest_n_digit_pandigital_prime(n)
        if(new != 0):
            return new
        n -= 1


#Problem 42
import string
triangle_nums = [1]

def isTriangle_num(n):
    global triangle_nums
    new = len(triangle_nums) + 1
    while (triangle_nums[len(triangle_nums) - 1]) < n:
        triangle_nums.append(int((new*(new+1)) / 2))
        new += 1

    if(n in triangle_nums):
        return True
    else:
        return False


def amount_of_triangle_words_in(filename):
    full = []
    amount = 0
    with open(filename, "r") as f:
        for line in f:
            full.append(line.split(","))

    full = full[0]
    alfabet = list(string.ascii_uppercase)
    for word in full:
        word_sum = 0
        word = word[1:len(word)-1]
        for letter in word:
            for index, s in enumerate(alfabet):
                if(s == letter):
                    word_sum += index + 1
                    break
        if(isTriangle_num(word_sum)):
            amount += 1
    return amount


#Problem 43
def special_sub_string(s):
    primes = [2,3,5,7,11,13,17]
    start = 1
    for i in primes:
        num = int(s[start:start+3])
        if(num % i != 0):
            return False
        start += 1
    else:
        return True


def find_sum():
    available = ""
    for i in range(10):
        available += str(i)

    found = []
    for num in permutations(available, 10):
        new = ""
        for i in num:
            new += i
        if(new[0] != "0"):
            if(special_sub_string(new)):
                found.append(int(new))
    return sum(found)


#Problem 44
def pentagon_number(n):
    return n*(3*n - 1)/2

def is_pentagonal(n):
    k = (sqrt(24*n+1)+1)/6
    return k.is_integer()


def find_pair():
    i = 1;
    notFound = True;

    while notFound:
        n = pentagon_number(i);
        for j in range(i-1, 0, -1):
            k = pentagon_number(j);
            if(is_pentagonal(n + k) and is_pentagonal(n - k)):
                d = n - k;
                notFound = False;
                return d;

        i += 1;


#Problem 45
def tri_num(n):
    return n*(n+1)/2


def hexa_num(n):
    return n*(2*n - 1)


def find_next(f, upper):
    tris = [tri_num(n) for n in range(f, 10 ** upper)]
    pentas = [pentagon_number(n) for n in range(10 ** upper)]
    hexas = [hexa_num(n) for n in range(10 ** upper)]

    while True:
        print(f)
        if(tris[f+1] in pentas and tris[f+1] in hexas):
            return tris[f+1]
        else:
            f += 1



#Problem 41
#find_highest()
#
#Problem 42
#amount_of_triangle_words_in("p042_words.txt")
#
#Problem 43
#find_sum()
#
#Problem 44
find_pair()
#
#Problem 45
#find_next(285, 10)
