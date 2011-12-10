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
Console showGame: game.
Console newline.

[game continueGame] whileTrue: [
    | player choice |
    player := game getCurrentPlayer.
    ( game currentPlayerCanMove )
        ifTrue: [
            choice := Console requestHandChoice: player name.
            game makeMove: choice.
        ]
        ifFalse: [
            Console showPickupMessage: player name.
            game pickup.
        ].
    Console clearScreen.
    Console showGame: game.
    Console newline.
]
     



