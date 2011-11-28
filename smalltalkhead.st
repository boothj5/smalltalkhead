FileStream fileIn: 'console.st' !
FileStream fileIn: 'game.st' !
FileStream fileIn: 'player.st' !
FileStream fileIn: 'card.st' !

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
    ( swap )
        ifTrue: [
            Console requestHandSwap.
        ]
]
