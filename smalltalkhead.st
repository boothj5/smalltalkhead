FileStream fileIn: 'console.st' !
FileStream fileIn: 'game.st' !
FileStream fileIn: 'player.st' !

| numPlayers numCardsEach playerNames game |

Console showWelcomeMessage.

nPlayers := Console requestNumPlayers.
nCardsEach := Console requestNumCards.

playerNames := Console requestPlayerNames: nPlayers.

game := Game numCardsEach: nCardsEach playerNames: playerNames.

Transcript show: 'Num cards in game :', game getNumCardsEach printString; cr.

1 to: game getPlayers size do: [:i |
    Transcript show: 'Player ', i printString, 's name : ', 
        (game getPlayers at: i) getName ; cr.
]


