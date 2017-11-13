from math import *

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

#Problem  31
#count_comb(200, 0, [], None)
#
#Problem 32
#find_pandigital_products()
