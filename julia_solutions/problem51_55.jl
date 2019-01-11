using Primes
#Problem 51
#=


By replacing the 1st digit of the 2-digit number *3, it turns out that six of the nine possible values: 13, 23, 43, 53, 73, and 83, are all prime.

By replacing the 3rd and 4th digits of 56**3 with the same digit,
this 5-digit number is the first example having seven primes among the ten generated numbers,
yielding the family: 56003, 56113, 56333, 56443, 56663, 56773, and 56993.
Consequently 56003, being the first member of this family, is the smallest prime with this property.

Find the smallest prime which, by replacing part of the
number (not necessarily adjacent digits) with the same digit, is part of an eight prime value family.


=#
function makeNumber(t,d,c)
    counter = 0
    for i in 1:length(t)
        counter *= 10
        counter += (t[i]==11) ? d : t[i]
    end
    counter *= 10
    counter += c
end

function problem51()
    solution = 999999
    for a = 0:9
        for b = 0:9
            for c = 1:2:9
                for i in permutations([ a b 11 11 11 ])
                    counter = 0num
                    for d = 0:9
                        num = makeNumber(i,d,c)
                        if isprime(num) && num > 100000
                            counter += 1
                        end
                    end
                    if counter >=8
                        for d = 0:9
                            num = makeNumber(i,d,c)
                            if isprime(num) && num > 100000 && num < solution
                                solution = num
                            end
                        end
                    end
                end
            end
        end
    end
    solution
end

#println(problem51())

#Problem 52
function samedigits(x, y)
    x, y = string(x), string(y)
    check = Dict()
    for digit in x
        if haskey(check, digit)
            check[digit] += 1
        else
            check[digit] = 1
        end
    end
    for digit in y
        if haskey(check, digit)
            if check[digit] > 0
                check[digit] -= 1
            else
                return false
            end
        else
            return false
        end
    end
    return true
end

function problem52()
    x = 1
    while true
        found = true
        for i = 2:6
            if samedigits(x, i*x)
                continue
            else
                found = false
                break
            end
        end
        if found
            return x
        else
            x += 1
        end
    end
end

#println(problem52())

#Problem 53
function problem53()
    total = 0
    for n = 1:100
        n = BigInt(n)
        for r = n:-1:1
            r = BigInt(r)
            if binomial(n, r) > 1000000
                total += 1
            end
        end
    end
    return total
end

#println(problem53())

#Problem 54
f = open("pokertest.txt") # File which contain all the poker hands
lines = readlines(f)
# Ok,
# The way this should be done, is from top to bottom, and each hand can be a string which says which hand they currently have,
# After this we have to check which of the hands win, say if we have both players with two pair, which of the two have the better pairs?

#=
    High Card: Highest value card.
    One Pair: Two cards of the same value.
    Two Pairs: Two different pairs.
    Three of a Kind: Three cards of the same value.
    Straight: All cards are consecutive values.
    Flush: All cards of the same suit.
    Full House: Three of a kind and a pair.
    Four of a Kind: Four cards of the same value.
    Straight Flush: All cards are consecutive values of same suit.
    Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
=#
mutable struct Hand
    royal_flush::Bool
    straight_flush::String
    quad::Int64
    house::String
    flush::Bool
    straight::String
    three::Int64
    pairs::Array
    high_card::Char
    full_hand::Array
end

function checkflush!(hand)
    kind = ''
    for cards in hand.full_hand
        if kind == ''
            # Check if the kind is the same
            kind = cards[2]
        elseif cards[2] != kind
            hand.flush = false
        end
    end
    hand.flush = true
end

function checkroyal!(hand)
    checkflush!(hand)
    if hand.flush
        #Check if royal
        full = ""
        for cards in hand.full_hand
            full *= cards
        end
        # occursin("world", "Hello, world.") = true
        hand.royal_flush = occursin("T", full) && occursin("K", full) && occursin("J", full) && occursin("Q", full) && occursin("A", full)
    else
        hand.royal_flush = false
    end
end

function checkofakind!(hand)
    kind = ''
    for cards in hand
        amount = 0
        for cards2 in hand
            if cards[1] == cards2[1] && cards[2] != cards2[2]
                amount += 1
            end
        end
        if amount == 4
            hand.quad = parse(Int64, cards[1])
        elseif amount = 3
            hand.three = parse(Int64, cards[1])
        elseif amount = 2
            if !(cards[1] in hand.pairs)
                push!(hand.pairs, cards[1])
            end
        end
    end
end

function checkhouse!(hand)
    checkofakind!(hand)
    if hand.three != 0 && hand.pairs != []
        # House
        # Pattern: three 'space' pair
        # Remember we can only have 1 pair, because we have 5 cards
        hand.house = string(hand.three) * " " * string(hand.pairs[1])
    end
end

function resethand(hand)
    hand.royal_flush = false
    hand.straight_flush = ""
    hand.quad = 0
    hand.house = ""
    hand.flush = false
    hand.straight = ""
    hand.three = 0
    hand.pairs = []
    hand.high_card = ""
end
function problem54()
    player1 = Hand(false, "", "", "", false, "", 0, "", 0, 'n', [])
    player2 = Hand(false, "", "", "", false, "", 0, "", 0, 'n', [])
    times_one_won = 0
    for line in lines
        player1.full_hand = split(line[1:14], " ")
        player2.full_hand = split(line[16:end], " ")
        checkroyal!(player1)
        checkroyal!(player2)

        checkquads!(player1)
        checkquads!(player2)

    end
end

problem54()
