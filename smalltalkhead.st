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

1 to: game deck size do: [:i |
    Transcript show: (game deck at: i) printString; cr.
].

game players do: [:player |
    Transcript show: player name, ' HAND: '; cr.
    player hand do: [:card |
        Transcript show: card printString; cr.
    ].
    Transcript show: player name, ' FACEUP: '; cr.
    player faceUp do: [:card |
        Transcript show: card printString; cr.
    ].
    Transcript show: player name, ' FACEDOWN: '; cr.
    player faceDown do: [:card |
        Transcript show: card printString; cr.
    ].
]
