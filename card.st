Object subclass: Card [
    | rank suit |

    RANKS := Dictionary new
                at: 2 put: 'TWO';
                at: 3 put: 'THREE';
                at: 4 put: 'FOUR';
                at: 5 put: 'FIVE';
                at: 6 put: 'SIX';
                at: 7 put: 'SEVEN';
                at: 8 put: 'EIGHT';
                at: 9 put: 'NINE';
                at: 10 put: 'TEN';
                at: 11 put: 'JACK';
                at: 12 put: 'QUEEN';
                at: 13 put: 'KING';
                at: 14 put: 'ACE'.

    SUITS := Dictionary new
                at: 0 put: 'CLUBS';
                at: 1 put: 'HEARTS';
                at: 2 put: 'SPADES';
                at: 3 put: 'DIAMONDS'.

    Card class >> rank: aRank suit: aSuit [
        ^(self new)
            rank: aRank; 
            suit: aSuit;
            yourself.
    ]
    
    rank: aRank [ rank := aRank. ]
    rank [ ^rank. ]

    suit: aSuit [ suit := aSuit. ]
    suit [ ^suit. ]
]
