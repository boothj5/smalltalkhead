FileStream fileIn: 'card.st' !

Object subclass: Deck [
    | deck |

    Deck class >> numPlayers: aNumPlayers numCardsEach: aNumCardsEach [
        | numDecks newDeck |
        
        numDecks := Deck numDecksForPlayers: aNumPlayers andCards: aNumCardsEach.
        newDeck := OrderedCollection new.
        numDecks timesRepeat: [
            2 to: 14 do: [:rank |
                0 to: 3 do: [:suit |
                    newDeck add: (Card rank: rank suit: suit).
                ].
            ].
        ].
        
        ^(self new)
            deck: newDeck;
            shuffle; 
            yourself.
    ]

    Deck class >> numDecksForPlayers: numPlayers andCards: numCardsEach [
        | result totalCards div add |

        totalCards := (numCardsEach * 3) * numPlayers.
        div := (totalCards / 52) integerPart numerator.
        add := (totalCards \\ 52).
        ( add > 0 )
            ifTrue: [ result := div + 1 ]
            ifFalse: [ result := div ].

        ^result
    ]

    deck: aDeck [ deck := aDeck ]

    size [ ^(deck size) ]

    at: i [ ^(deck at: i) ]

    shuffle [
        1 to: deck size do: [ :i |
            |ran tmp|
            ran := Random between: 1 and: deck size.
            tmp := deck at: i.
            deck at: i put: (deck at: ran).
            deck at: ran put: tmp 
        ].
    ]

    pop [ ^(deck removeFirst) ]
]
