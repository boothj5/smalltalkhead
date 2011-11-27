FileStream fileIn: 'player.st' !
FileStream fileIn: 'deck.st' !

Object subclass: Game [
    | numCards players deck |

    Game class >> numCards: aNumCards playerNames: names [
        | newPlayers newDeck |
        newPlayers := Array new: names size.
        1 to: names size do: [:i |
            newPlayers at: i put: (Player name: (names at: i)).
        ].
        newDeck := Deck numPlayers: names size numCardsEach: aNumCards.
        
        ^(self new) 
            numCards: aNumCards; 
            players: newPlayers; 
            deck: newDeck;
            yourself.
    ]
    
    numCards: aNumCards [ numCards := aNumCards ]
    numCards [ ^numCards ]

    players: aPlayers [ players := aPlayers ]
    players [ ^players ]

    deck: aDeck [ deck := aDeck ]
    deck [ ^deck ]
]
