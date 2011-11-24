FileStream fileIn: 'console.st' !

| numPlayers numCardsEach playerNames |

Console showWelcomeMessage.

numPlayers := Console requestNumPlayers.
numCardsEach := Console requestNumCards.

playerNames := Console requestPlayerNames: numPlayers.

1 to: playerNames size do: [:i |
    Transcript show: 'Player ', i printString, ': ', (playerNames at: i); cr.
]

