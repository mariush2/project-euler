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
    return len(set(str(num))) == len(str(num))


def next_pandigital(num):
    while not(pandigital(num)):
        num -= 1
    return num


def different_numbers(x, y):
    x, y = str(x), str(y)
    if(len(set(x)) != len(x) or len(set(y)) != len(y)):
        return False
    return set(x).isdisjoint(y)


def pandigital_product(x, y):
    if(different_numbers(x, y)):
        #Continue finding product
        product = x*y
        if(different_numbers(product, x) and different_numbers(product, y)):
            return True
        else:
            return False
    return False

def find_pandigital_products(upper):
    found = []
    y = upper
    while(y > 1):
        for x in range(2, y):
            if(pandigital(x)):
                if(different_numbers(x,y)):
                    product = x*y
                    if(pandigital_product(x, y) and product not in found):
                       found.append(product)
        y = next_pandigital(y-1)
    return sum(found)


#Problem  31
#count_comb(200, 0, [], None)
#
#Problem 32
#Not done!
print(find_pandigital_products(123456789))
