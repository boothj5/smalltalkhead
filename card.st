Object subclass: Card [
    | rank suit |

    CRANKS := Dictionary from: {
                2 -> 'TWO'.
                3 ->'THREE'.
                4 -> 'FOUR'.
                5 -> 'FIVE'.
                6 -> 'SIX'.
                7 -> 'SEVEN'.
                8 -> 'EIGHT'.
                9 -> 'NINE'.
                10 -> 'TEN'.
                11 -> 'JACK'.
                12 -> 'QUEEN'.
                13 -> 'KING'.
                14 -> 'ACE' }.

    CSUITS := Dictionary from: {
                0 -> 'CLUBS'.
                1 -> 'HEARTS'.
                2 -> 'SPADES'.
                3 -> 'DIAMONDS' }.

    Card class >> rank: aRank suit: aSuit [
        ^(self new)
            rank: aRank; 
            suit: aSuit;
            yourself.
    ]
    
    Card class >> RANKS [ ^CRANKS ]
    Card class >> SUITS [ ^CSUITS ]

    rank: aRank [ rank := aRank. ]
    rank [ ^rank. ]

    suit: aSuit [ suit := aSuit. ]
    suit [ ^suit. ]

    printString [
        | rankStr suitStr result |
        rankStr := CRANKS at: rank.
        suitStr := CSUITS at: suit.
        result := rankStr, ' of ', suitStr.
        ^result
    ]
]
