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

Transcript show: game deck size printString.
