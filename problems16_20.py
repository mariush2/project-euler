from itertools import *
#Problem 16
def power_digit_sum(power):
    full = str(2 ** power)
    sum = 0
    for i in islice(range(len(full)), 0, None):
        sum += int(full[i])
    return sum


#Problem 17
def number_letter_counts(num):
    up_to_ten = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]
    under_twenty = ["eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]
    tens_words = ["ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]
    main_words = ["thousand", "hundred"]

    sentence = ""
    old = num
    #Thousands
    if(num >= 1000):
        thousands = str(num)[0:len(str(num)) - 3]
        sentence += up_to_ten[int(thousands) - 1] + main_words[0]
        num -= 1000 * int(thousands)

    #Hundreds
    if(num == 0):
        return len(sentence)

    if(num >= 100):
        hundreds = str(num)[0:len(str(num)) - 2]
        sentence += up_to_ten[int(hundreds) - 1] + main_words[1]
        num -= 100 * int(hundreds)

    #Tens
    if(old % 100 != 0 and old > 100):
        sentence += "and"
    if(num > 10 and num < 20):
        teens = str(num)[len(str(num)) - 1]
        sentence += under_twenty[int(teens) - 1]
        return len(sentence)

    elif(num >= 10):
        tens = str(num)[0:len(str(num)) - 1]
        sentence += tens_words[int(tens) - 1]
        num -= 10 * int(tens)

    if(num >= 1 and num < 10):
        under_ten = str(num)[0:len(str(num))]
        sentence += up_to_ten[int(under_ten) - 1]
        num -= int(under_ten)


    return len(sentence)

def find_most_letters():
    sum = 0
    for i in range(1,1001):
        sum += number_letter_counts(i)

    return sum


#Problem 16
#power_digit_sum(1000)
#
#Problem 17
#number_letter_counts()
find_most_letters()
