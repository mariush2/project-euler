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

score = Dict("A" => 14, "K" => 13, "Q" => 12, "J" => 11, "T" => 10)

for key = 2:9
    score[string(key)] = key
end

function tostring(hand)
    println("Royal flush: ", hand.royal_flush)
    println("Straight flush: ", hand.straight_flush)
    println("Quads: ", hand.quad)
    println("Full House: ", hand.house)
    println("Flush: ", hand.flush, " kind: ", hand.flush_kind)
    println("Straight: ", hand.straight)
    println("Threes: ", hand.three)
    println("Pairs: ", hand.pairs)
    println("High card: ", hand.high_card, " score: ", hand.high_score)
end

function checkflush!(hand)
    kind = ' '
    for card in hand.full_hand
        if kind == ' '
            # Check if the kind is the same
            kind = card[2]
        elseif card[2] != kind
            hand.flush = false
            hand.flush_kind = ' '
            return
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
            full = full * card
        end
        # occursin("world", "Hello, world.") = true
        hand.royal_flush = occursin("T", full) && occursin("K", full) && occursin("J", full) && occursin("Q", full) && occursin("A", full)
    else
        hand.royal_flush = false
    end
end

function checkofakind!(hand)
    for card in hand.full_hand
        amount = 1
        for card2 in hand.full_hand
            if card[1] == card2[1] && card[2] != card2[2]
                amount = amount + 1
            end
        end
        if amount == 4
            hand.quad = score[string(card[1])]
        elseif amount == 3
            hand.three = score[string(card[1])]
        elseif amount == 2 && !(score[string(card[1])] in hand.pairs)
            push!(hand.pairs, score[string(card[1])])
        end
    end
end

function checkhouse!(hand)
    checkofakind!(hand)
    if hand.three != 0 && hand.pairs != [0]
        # House
        # Pattern: three 'space' pair
        # Remember we can only have 1 pair, because we have 5 cards
        hand.house = string(hand.three) * " " * string(hand.pairs[1])
    end
end

function checkstraight!(hand)
    allowed = ["23456", "34567", "45678", "56789", "6789T", "789TJ", "89TJQ", "9TJQK", "TJQKA"]
    for i = 1:length(hand.full_hand) - 1
        if score[string(hand.full_hand[i + 1][1])] != score[string(hand.full_hand[i][1])] + 1
            return
        end
    end
    # Find which straight it is
    for straight in allowed
        if straight[5] == hand.high_card
            # Found the correct straight
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

function notinanykind(hand, card)
    current = score[string(card[1])]
    if hand.quad == current || hand.three == current
        return false
    else
        for pair in hand.pairs
            if pair == current
                return false
            end
        end
    end
    return true
end

function checkhigh!(hand)
    for card in hand.full_hand
        if score[string(card[1])] > hand.high_score && notinanykind(hand, card)
            hand.high_score = score[string(card[1])]
            hand.high_card = card[1]
        end
    end
end



function playeronewinner(hand1, hand2)
    previous = Dict()

    previous["straight_flush"] = !hand2.royal_flush
    previous["quads"] = ((hand1.straight_flush != "" && hand2.straight_flush == "") || (hand1.straight_flush != "" && hand2.straight_flush != "" && hand2.high_score < hand1.high_score)) || previous["straight_flush"]
    previous["house"] = (hand1.quad > hand2.quad || (hand1.quad == hand2.quad && hand1.high_score > hand2.high_score)) || previous["quads"]
    previous["flush"] = ((hand1.house != "" && hand2.house != "" && hand1.three > hand2.three) || (hand1.house != "" && hand2.house == "")) || previous["house"]
    previous["straight"] = (hand1.flush && !hand2.flush) || previous["flush"]
    previous["threes"] = ((hand1.straight != "" && hand2.straight == "") || (hand1.straight != "" && hand2.straight != "" && hand1.high_score > hand2.high_score)) || previous["straight"]
    previous["pairs"] = (hand1.three > hand2.three) || previous["threes"]
    previous["high"] = ((length(hand1.pairs) > length(hand2.pairs)) && sum(hand1.pairs) > sum(hand2.pairs)) || previous["pairs"]

    # Royal flush
    if hand1.royal_flush
        return true
    # Straight flush
    elseif previous["straight_flush"] && ((hand1.straight_flush != "" && hand2.straight_flush == "") || (hand1.straight_flush != "" && hand2.straight_flush != "" && hand2.high_score < hand1.high_score))
        return true
    # Quads
    elseif previous["quads"] && (hand1.quad > hand2.quad || (hand1.quad == hand2.quad && hand1.high_score > hand2.high_score))
        return true
    # Full house
    elseif previous["house"] && ((hand1.house != "" && hand2.house != "" && hand1.three > hand2.three) || (hand1.house != "" && hand2.house == ""))
        return true
    # Flush
    elseif previous["flush"] && (hand1.flush && !hand2.flush)
        return true
    # Straight
    elseif previous["straight"] && ((hand1.straight != "" && hand2.straight == "") || (hand1.straight != "" && hand2.straight != "" && hand1.high_score > hand2.high_score))
        return true
    # Three of a kind
    elseif previous["threes"] && (hand1.three > hand2.three)
        return true
    # Two pair and one pair
    elseif previous["pairs"] && ((length(hand1.pairs) > length(hand2.pairs)) && sum(hand1.pairs) > sum(hand2.pairs))
        return true
    # High card
    elseif previous["high"] && (hand1.high_score > hand2.high_score)
        return true
    else
        return false
    end
end

function resethand!(hand)
    hand.royal_flush = false
    hand.straight_flush = ""
    hand.quad = 0
    hand.house = ""
    hand.flush = false
    hand.flush_kind = ' '
    hand.straight = ""
    hand.three = 0
    hand.pairs = [0]
    hand.high_card = ' '
    hand.high_score = 0
end

function sorthand!(hand)
    swapped = true
    while swapped
        swapped = false
        for i = 2:length(hand.full_hand)
            if score[string(hand.full_hand[i - 1][1])] > score[string(hand.full_hand[i][1])]
                temp = hand.full_hand[i]
                hand.full_hand[i] = hand.full_hand[i - 1]
                hand.full_hand[i - 1] = temp
                swapped = true
            end
        end
    end
end

function problem54()
    player1 = Hand(false, "", 0, "", false, ' ', "", 0, [0], ' ', 0, [])
    player2 = Hand(false, "", 0, "", false, ' ', "", 0, [0], ' ', 0, [])
    times_one_won = 0
    for line in lines
        player1.full_hand = split(line[1:14], " ")
        player2.full_hand = split(line[16:end], " ")

        println("--------------------------------")
        println(line[1:14], "   ", line[16:end])

        resethand!(player1)
        resethand!(player2)

        sorthand!(player1)
        sorthand!(player2)

        checkroyal!(player1)
        checkroyal!(player2)

        checkhouse!(player1)
        checkhouse!(player2)

        checkstraightflush!(player1)
        checkstraightflush!(player2)

        checkhigh!(player1)
        checkhigh!(player2)

        # Have generated the hand, now we have to check who wins
        println("\n")
        if playeronewinner(player1, player2)
            times_one_won += 1
            println("Player 1 won!")
        else
            println("Player 2 won!")
        end
        println("\nPlayer1")
        tostring(player1)
        println("\nPlayer2")
        tostring(player2)
        println("--------------------------------")
        println("\n\n")
    end
    close(f)
    return times_one_won
end

println(@time problem54())
