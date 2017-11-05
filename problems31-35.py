#Problem 31
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
def different_numbers(x, y):
    biggest = max(x, y)
    x = str(x)
    y = str(x)
    for digit in range(biggest):
        

#Problem 31
coins = [200,100,50,20,10,5,2,1]
count_comb(200, 0, [], None)
