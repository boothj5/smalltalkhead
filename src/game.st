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
            ].
            player sortHand.
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
        player hasCardsInHand
            ifTrue: [
                choice do: [:i | cardsToLay add: (player hand at: i) ].
                self playFromHand: cardsToLay.
            ]
            ifFalse: [
                choice do: [:i | cardsToLay add: (player faceUp at: i) ].
                self playFromFaceUp: cardsToLay.
            ].
            
        self burnCardLaid
            ifTrue: [ self burnPile ]
            ifFalse: [ 
                self missAGoLaid
                    ifTrue: [ 
                        lastMove := player name, ' laid miss a go card.'.
                        2 timesRepeat: [ self moveToNextPlayer ].
                    ]
                    ifFalse: [
                        self moveToNextPlayer.
                    ].
            ]
    ]

    missAGoLaid [
        ^( pile last rank = 8)
    ]

    burnCardLaid [
        pile last rank = 10
            ifTrue: [ ^true ]
            ifFalse: [ 
                (( pile size > 3) and: [ Card allRanksEqual: (pile last: 4) ])
                    ifTrue: [ ^true ]
                    ifFalse: [ ^false ].
            ].
    ]

    burnPile [
        | player |
        player := self getCurrentPlayer.
        burnt addAll: pile.
        pile := OrderedCollection new.
        lastMove:= player name, ' burnt the deck.'.
    ]

    playFromHand: cards [
        | player |
        player := self getCurrentPlayer.
        pile addAll: cards.
        cards do: [:card |
            player hand remove: card.
            ( ( deck isEmpty not ) and: [ player hand size < numCards ] )
                ifTrue: [ player addToHand: deck pop. ].
        ].
        player sortHand.
        lastMove :=  player name, ' laid '.
        cards do: [:card |
            lastMove := lastMove, card printString, ', '.
        ].
    ]

    playFromFaceUp: cards [
        | player |
        player := self getCurrentPlayer.
        pile addAll: cards.
        cards do: [:card | player faceUp remove: card. ].
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

    continueGame [
        | playersWithCards |
        playersWithCards := 0.
        players do: [:player |
            player hasCards ifTrue: [ playersWithCards := playersWithCards + 1 ].
        ].
        ^(playersWithCards > 1)
    ]

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

    playingFromFaceDown [
        | player |
        player := self getCurrentPlayer.
        ^(((player hasCardsInHand) | (player hasCardsInFaceUp)) not)
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
                ^( self canMoveWithOneOf: player hand )
            ].
        ( player hasCardsInFaceUp )
            ifTrue: [
                ^( self canMoveWithOneOf: player faceUp )
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
        ( player hasCardsInHand )
            ifTrue: [
                choice do: [:i | cardsToLay add: (player hand at: i) ]
            ]
            ifFalse: [
                choice do: [:i | cardsToLay add: (player faceUp at: i) ]
            ].
        ^(self validMove: cardsToLay)
    ]

    validMoveFromFaceDown: cardChoice [
        | player cardToLay |
        player := self getCurrentPlayer.
        cardToLay := OrderedCollection new.
        cardToLay add: (player faceDown at: cardChoice).
        ^(self validMove: cardToLay)
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
        player sortHand.
        pile := OrderedCollection new.
        lastMove := player name, ' pickup up the pile.'.
        self moveToNextPlayer.
    ]

    pickUpPileAndFaceDown: chosenCard [
        | player |
        player := self getCurrentPlayer.
        player hand addAll: pile.
        player hand add: (player faceDown at: chosenCard).
        player faceDown removeAtIndex: chosenCard.
        pile := OrderedCollection new.
        player sortHand.
        lastMove := player name, ' picked up.'.
        self moveToNextPlayer.
    ]

    makeFaceDownMove: chosenCard [
        | player |
        player := self getCurrentPlayer.    
        pile add: (player faceDown at: chosenCard).
        player faceDown removeAtIndex: chosenCard.
        lastMove := player name, 'laid the ', pile last printString.
        
        self burnCardLaid
            ifTrue: [ self burnPile ]
            ifFalse: [
                self missAGoLaid
                    ifTrue: [
                        lastMove := player name, ' laid miss a go card.'.
                        2 timesRepeat: [ self moveToNextPlayer ].
                    ]
                    ifFalse: [
                        self moveToNextPlayer.
                    ].
            ].
    ]

    getSmalltalkHead [
        players do: [:player |
            player hasCards ifTrue: [ ^player ].
        ].
        ^(players at: 1)
    ]
]


