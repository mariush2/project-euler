#Problem 41
from problems31_35 import pandigital as pandigital
from problems31_35 import isPrime as isPrime
from itertools import *

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

#Problem 41
#find_highest()
#
#Problem 42
#amount_of_triangle_words_in("p042_words.txt")
#
#Problem 43
