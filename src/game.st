FileStream fileIn: './src/player.st' !
FileStream fileIn: './src/deck.st' !

Object subclass: Game [
    | numCards players deck currentPlayer pile burnt lastMove |

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
            pile: OrderedCollection new;
            burnt: OrderedCollection new;
            currentPlayer: 1;
            lastMove: '';
            yourself.
    ]
    
    Game class >> canLay: aCard on: aPile [
        ( aPile isEmpty )
            ifTrue: [ ^true ].
        ( aCard specialCard )
            ifTrue: [ ^true ].
        ( aPile last rank = 7 )
            ifTrue: [ ^( Game canLay: aCard on: (aPile allButLast) ) ].
        ( aCard rank < aPile last rank )
            ifTrue: [ ^false ].
        ^true
    ]

    numCards: aNumCards [ numCards := aNumCards ]
    numCards [ ^numCards ]

    players: aPlayers [ players := aPlayers ]
    players [ ^players ]

    deck: aDeck [ deck := aDeck ]
    deck [ ^deck ]

    pile: aPile [ pile := aPile ]
    pile [ ^pile ]

    burnt: aBurnt [ burnt := aBurnt ]
    burnt [ ^burnt ]

    lastMove: aLastMove [ lastMove := aLastMove ]
    lastMove [ ^lastMove ]
    
    currentPlayer: aCurrentPlayer [ currentPlayer := aCurrentPlayer ]
    currentPlayer [ ^currentPlayer ]    

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
        | player cardsToLay firstCardToLay|
        currentPlayer := self playerWithLowest.
        player := self getCurrentPlayer.
        cardsToLay := OrderedCollection new.
        cardsToLay add: player lowestHandCard.
        firstCardToLay := cardsToLay at: 1.

        player hand do: [:handCard |
            (handCard sameRankDifferentSuitTo: firstCardToLay)
                ifTrue: [
                    cardsToLay add: handCard
                ]
        ].
        
        self playFromHand: cardsToLay.
        self moveToNextPlayer.
    ]

    makeMove: choice [
        | player cardsToLay |
        player := self getCurrentPlayer.
        cardsToLay := OrderedCollection new.
        choice do: [:i |
            cardsToLay add: (player hand at: i).
        ].
        self playFromHand: cardsToLay.
        self moveToNextPlayer.
    ]
        

    playFromHand: cards [
        | player |
        player := self getCurrentPlayer.
        pile addAll: cards.
        cards do: [:card |
            player hand remove: card.
            player addToHand: deck pop.
        ].
        lastMove :=  player name, ' laid '.
        cards do: [:card |
            lastMove := lastMove, card printString, ', '.
        ].
    ]

    moveToNextPlayer [
        currentPlayer := currentPlayer + 1.
        (currentPlayer > (players size))
            ifTrue: [ currentPlayer := 1 ].
    ]

    continueGame [ ^true ]

    playerWithLowest [
        | lowestPlayer |
        lowestPlayer := 1.
        2 to: players size do: [:i |
            | playerLowestCard currentLowestCard |
            playerLowestCard := (players at: i) lowestHandCard.
            currentLowestCard := (players at: lowestPlayer) lowestHandCard.
            ((Card shCompare: playerLowestCard with: currentLowestCard))
                ifTrue: [ lowestPlayer := i ].
        ].
    
        ^lowestPlayer
    ]

    getCurrentPlayer [
        ^(players at: currentPlayer)
    ]

    currentPlayerCanMove [
        | player |
        player := self getCurrentPlayer.
        ( pile isEmpty )
            ifTrue: [ ^true ].
        ( player hasCardsInHand ) 
            ifTrue: [ 
                ( self canMoveWithOneOf: player hand )
                    ifTrue: [ ^true ]
                    ifFalse: [ ^false ].
            ].
        ( player hasCardsInFaceUp )
            ifTrue: [
                ( self canMoveWithOneOf: player faceUp )
                    ifTrue: [ ^true ]
                    ifFalse: [ ^false ].
            ].
        ^false
    ]

    canMoveWithOneOf: cards [
        cards do: [:card |
            ( Game canLay: card on: pile )
                ifTrue: [ ^true ].
        ].
        ^false
    ]


    validMoveChoice: choice [
        | player cardsToLay |
        player := self getCurrentPlayer.
        cardsToLay := OrderedCollection new.
        choice do: [:i |
            cardsToLay add: (player hand at: i).
        ].
        ^(self validMove: cardsToLay)
    ]
         
    validMove: cards [
        ( Card allRanksEqual: cards )
            ifFalse: [ ^false ].
        ^(Game canLay: cards first on: pile)
    ]   

    pickup [
        | player |
        player := self getCurrentPlayer.
        player hand addAll: pile.
        pile := OrderedCollection new.
        lastMove := player name, ' pickup up the pile.'.
        self moveToNextPlayer.
    ]
]


