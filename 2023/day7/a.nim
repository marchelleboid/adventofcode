import algorithm
import sequtils
import strutils
import tables

type Card = enum
    TWO = (0, "2")
    THREE = (1, "3")
    FOUR = (2, "4")
    FIVE = (3, "5")
    SIX = (4, "6")
    SEVEN = (5, "7")
    EIGHT = (6, "8")
    NINE = (7, "9")
    T = (8, "T")
    J = (9, "J")
    Q = (10, "Q")
    K = (11, "K")
    A = (12, "A")

type HandType = enum
    ERROR
    HIGH_CARD
    ONE_PAIR
    TWO_PAIR
    THREE_OF_A_KIND
    FULL_HOUSE
    FOUR_OF_A_KIND
    FIVE_OF_A_KIND

type
    Hand = object
        cards: array[0 .. 4, Card]
        bid: int

proc countTable(h: Hand): CountTable[Card] =
    var fMap: CountTable[Card]
    for c in h.cards:
        fMap.inc(c)
    return fMap

proc scoreHand(h: Hand): HandType =
    let hCountTable = h.countTable
    case len(hCountTable):
        of 5:
            return HIGH_CARD
        of 4:
            return ONE_PAIR
        of 3:
            for v in hCountTable.values:
                if v == 2:
                    return TWO_PAIR
                elif v == 3:
                    return THREE_OF_A_KIND
        of 2:
            for v in hCountTable.values:
                if v == 3:
                    return FULL_HOUSE
                elif v == 4:
                    return FOUR_OF_A_KIND
        of 1:
            return FIVE_OF_A_KIND
        else:
            return ERROR

proc toCard(c: char): Card =
    for card in Card.toSeq:
        if $card == $c:
            return card
    return TWO

# x < y = -1
# x == y = 0
# x > y = 1
proc handComparator(x, y: Hand): int =
    let xScore = x.scoreHand
    let yScore = y.scoreHand
    let scoreCompare = cmp(xScore, yScore)
    if scoreCompare != 0:
        return scoreCompare
    for i in 0 .. 4:
        let cardCompare = cmp(x.cards[i], y.cards[i])
        if cardCompare != 0:
            return cardCompare
    return 0

var hands: seq[Hand]
for line in lines("input.txt"):
    let splitLine = line.split
    var cards: array[0 .. 4, Card]
    for i, c in splitLine[0]:
        cards[i] = toCard(c)
    hands.add(Hand(cards: cards, bid: parseInt(splitLine[1])))

hands.sort(handComparator)

var count = 0
for i, hand in hands:
    count += (i + 1) * hand.bid

echo count