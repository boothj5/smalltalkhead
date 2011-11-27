FileStream fileIn: 'card.st' !

Object subclass: Deck [
    | deck |

    Deck class >> numPlayers: aNumPlayers numCardsEach: aNumCardsEach [
        | numDecks newDeck |
        
        numDecks := Deck numDecksForPlayers: aNumPlayers andCards: aNumCardsEach.
        newDeck := OrderedCollection new.
        1 to: numDecks do: [:i |
            2 to: 14 do: [:rank |
                0 to: 3 do: [:suit |
                    newDeck add: (Card rank: rank suit: suit).
                ].
            ].
        ].
        
        ^(self new)
            deck: newDeck; 
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
]