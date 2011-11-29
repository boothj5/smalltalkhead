FileStream fileIn: './src/player.st' !
FileStream fileIn: './src/deck.st' !

Object subclass: Game [
    | numCards players deck currentPlayer |

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
    
    deal [
        players do: [:player |
            1 to: numCards do: [:i |
                player addToHand: deck pop.
                player addToFaceUp: deck pop.
                player addToFaceDown: deck pop.
            ]
        ]
    ]

    firstMove [
        | player cardsToLay |
        currentPlayer := self playerWithLowest.
        player := self getCurrentPlayer.
        cardsToLay := OrderedCollection new.
        cardsToLay add: player lowestHandCard.

        player hand do: [:card |
            ((card equalsRank: (cardsToLay at: 1)) & 
                                        ((card = (cardsToLay at: 1)) not))
                ifTrue: [
                    cardsToLay add: card
                ]
        ].
        
        "self playFromHand: cardsToLay."
        self moveToNextPlayer.
    ]

    moveToNextPlayer [
        currentPlayer := currentPlayer + 1.
        (currentPlayer > (players size))
            ifTrue: [ currentPlayer := 1 ].
    ]

    playerWithLowest [
        | lowestPlayer |
        lowestPlayer := 1.
        2 to: players size do: [:i |
            | playerLowestCard currentLowestCard |
            playerLowestCard := (players at: i) lowestHandCard.
            currentLowestCard := (players at: lowestPlayer) lowestHandCard.
            ((Card shCompare: playerLowestCard with: currentLowestCard) < 0)
                ifTrue: [ lowestPlayer := i ].
        ].
    
        ^lowestPlayer
    ]

    getCurrentPlayer [
        ^(players at: currentPlayer)
    ]
]
