from itertools import *
from math import *
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


#Problem 18
triangle = [
    [75],
    [95, 64],
    [17, 47, 82],
    [18, 35, 87, 10],
    [20, 04, 82, 47, 65],
    [19, 01, 23, 75, 03, 34],
    [88, 02, 77, 73, 07, 63, 67],
    [99, 65, 04, 28, 06, 16, 70, 92],
    [41, 41, 26, 56, 83, 40, 80, 70, 33],
    [41, 48, 72, 33, 47, 32, 37, 16, 94, 29],
    [53, 71, 44, 65, 25, 43, 91, 52, 97, 51, 14],
    [70, 11, 33, 28, 77, 73, 17, 78, 39, 68, 17, 57],
    [91, 71, 52, 38, 17, 14, 91, 43, 58, 50, 27, 29, 48],
    [63, 66, 04, 68, 89, 53, 67, 30, 73, 16, 69, 87, 40, 31],
    [04, 62, 98, 27, 23, 9, 70, 98, 73, 93, 38, 53, 60, 4, 23]
    ]

def max_path():
    all = all_paths(0, 0)
    biggest = 0
    for path in all:
        if(sum(path) > biggest):
            biggest = sum(path)

    return biggest

def all_paths(r, c):
    global triangle
    current = triangle[r][c]
    if r < len(triangle) - 1:
        below_paths = all_paths(r+1, c) + all_paths(r+1, c+1)
        return [[current] + path for path in below_paths]
    else:
        return [[current]]
#Thank you stackoverflow! <3


#Problem 19
days = 2
def is_leap_year(year):
    if year % 400 == 0:
        return True
    elif year % 100 == 0:
        return False
    elif year % 4 == 0:
        return True
    return False


def days_in_year(year):
    #Return array of days per month
    if(is_leap_year(year)):
        months = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    else:
        months = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    return months


def is_sunday(day):
    return day % 7 == 0


def starting_sundays(year, starting_day):
    global days
    amount = 0
    months = days_in_year(year)

    for days_in_month in months:
        if(is_sunday(days)):
            amount += 1
        days += days_in_month

    return amount


def check_century():
    global days
    start = 1901
    total = 0
    for year in range(100):
        year += start
        total += starting_sundays(year, days)
        print("Days passed since", str(year) + ":",days - 2)

    return total


#Problem 16
#power_digit_sum(1000)
#
#Problem 17
#number_letter_counts()
#find_most_letters()
#
#Problem 18
#max_path()
#
#Problem 19
#check_century()
