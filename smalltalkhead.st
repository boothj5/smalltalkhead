FileStream fileIn: 'console.st' !
FileStream fileIn: 'game.st' !
FileStream fileIn: 'player.st' !
FileStream fileIn: 'card.st' !

| numPlayers numCardsEach playerNames game tenDiamonds |

Console showWelcomeMessage.

nPlayers := Console requestNumPlayers.
nCardsEach := Console requestNumCards.

playerNames := Console requestPlayerNames: nPlayers.

game := Game numCards: nCardsEach playerNames: playerNames.

Transcript show: 'Num cards in game :', game numCards printString; cr.

1 to: game players size do: [:i |
    Transcript show: 'Player ', i printString, 's name : ', 
        (game players at: i) name ; cr.
].

tenDiamonds := Card rank: 10 suit: 3.

Transcript show: tenDiamonds printString; cr.
