FileStream fileIn: './src/console.st' !
FileStream fileIn: './src/game.st' !
FileStream fileIn: './src/player.st' !
FileStream fileIn: './src/card.st' !

| numPlayers numCardsEach playerNames game |

Console showWelcomeMessage.
nPlayers := Console requestNumPlayers.
nCardsEach := Console requestNumCards.
playerNames := Console requestPlayerNames: nPlayers.

game := Game numCards: nCardsEach playerNames: playerNames.
game deal.

game players do: [:player |
    | swap |
    Console clearScreen.
    Console showPlayer: player.
    swap := Console requestSwap: player name.
    [ swap ] whileTrue: [
        | handCard faceUpCard |
        Console newline.
        handCard := Console requestHandSwap.
        faceUpCard := Console requestFaceUpSwap.
        player swap: handCard with: faceUpCard.
        Console clearScreen.
        Console showPlayer: player.
        swap := Console requestSwap: player name.
    ].
].

game firstMove.

[game continueGame] whileTrue: [
    | player choice |
    
    player := game getCurrentPlayer.
    Console showGame: game.
    Console newline.
    
    (game playingFromFaceDown)
        ifTrue: [
            | chosenCard |
            chosenCard := Console requestFaceDownCard: player name.
            ( game validMoveFromFaceDown: chosenCard ) 
                ifTrue: [
                    Console showFaceDownWin: (player faceDown at: chosenCard).
                    game makeFaceDownMove: chosenCard.
                ]
                ifFalse: [
                    Console showFaceDownFail: (player faceDown at: chosenCard).
                    game pickUpPileAndFaceDown: chosenCard.
                ].
        ]
        ifFalse: [
            ( game currentPlayerCanMove )
                ifTrue: [
                    choice := Console requestHandChoice: player name.
                    [ game validMoveChoice: choice ]
                        whileFalse: [
                            Console showBadMove.
                            Console newline.
                            choice := Console requestHandChoice: player name.
                        ].
                    game  makeMove: choice.
                ]
                ifFalse: [
                    Console showPickupMessage: player name.
                    game pickup.
                ].
            Console clearScreen.
            Console showGame: game.
            Console newline.
        ].
].

Console showSmalltalkHead: ( game getSmalltalkHead ).
     



