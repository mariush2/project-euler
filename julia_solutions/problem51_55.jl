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
    flush_kind::Char
    straight::String
    three::Int64
    pairs::Array
    high_card::Char
    high_score::Int64
    full_hand::Array
end

score = Dict("A" => 14, "K" => 13, "Q" => 12, "J" => 11, "T" => 10, "9" => 9, "8" => 8, "7" => 7, "6" => 6, "5" => 5, "4" => 4, "3" => 3, "2" => 2)

function checkflush!(hand)
    kind = ''
    for card in hand.full_hand
        if kind == ''
            # Check if the kind is the same
            kind = card[2]
        elseif card[2] != kind
            hand.flush = false
        end
    end
    hand.flush_kind = kind
    hand.flush = true
end

function checkroyal!(hand)
    checkflush!(hand)
    if hand.flush
        #Check if royal
        full = ""
        for card in hand.full_hand
            full *= card
        end
        # occursin("world", "Hello, world.") = true
        hand.royal_flush = occursin("T", full) && occursin("K", full) && occursin("J", full) && occursin("Q", full) && occursin("A", full)
    else
        hand.royal_flush = false
    end
end

function checkofakind!(hand)
    kind = ''
    for card in hand.full_hand
        amount = 0
        for card2 in hand.full_hand
            if card[1] == card2[1] && card[2] != card2[2]
                amount += 1
            end
        end
        if amount == 4
            hand.quad = parse(Int64, card[1])
        elseif amount = 3
            hand.three = parse(Int64, card[1])
        elseif amount = 2
            if !(card[1] in hand.pairs)
                push!(hand.pairs, card[1])
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

function checkstraight!(hand)
    allowed = ["23456", "34567", "45678", "56789", "6789T", "789TJ", "89TJQ", "9TJQK", "TJQKA"]
    sequence = ""
    for cards in hand.full_hand
        sequence *= cards[1]
    end
    # Now the sequence var contains the cards we have in the current hand
    # Now lets check if it's a straight
    for straight in allowed
        success = true
        for letter in sequence
            if !(occursin(letter, straight))
                success = false
                break
            end
        end
        if success
            hand.straight = straight
            break
        end
    end
end

function checkstraightflush!(hand)
    # We have called checkflush! already in the royal flush check
    checkstraight!(hand)
    if hand.flush
        if hand.straight != ""
            hand.straight_flush = hand.straight * " " * hand.flush_kind
        end
    end
end

function checkhigh!(hand)
    for card in hand.full_hand
        if score[card[1]] > hand.high_score
            hand.high_score = score[card[1]]
            hand.high_card = card
        end
    end
end

function resethand!(hand)
    hand.royal_flush = false
    hand.straight_flush = ""
    hand.quad = 0
    hand.house = ""
    hand.flush = false
    hand.straight = ""
    hand.three = 0
    hand.pairs = []
    hand.high_card = ""
    hand.high_score = 0
end

function problem54()
    player1 = Hand(false, "", "", "", false, "", 0, "", 0, 'n', [])
    player2 = Hand(false, "", "", "", false, "", 0, "", 0, 'n', [])
    times_one_won = 0
    for line in lines
        player1.full_hand = split(line[1:14], " ")
        player2.full_hand = split(line[16:end], " ")

        resethand!(player1)
        resethand!(player2)
        
        checkroyal!(player1)
        checkroyal!(player2)

        checkhouse!(player1)
        checkhouse!(player2)

        checkstraightflush!(player1)
        checkstraightflush!(player2)



    end
end

problem54()
