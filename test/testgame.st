PackageLoader fileInPackage: 'SUnit' !
FileStream fileIn: './src/game.st' !

TestCase subclass: GameTest [
    | game |

    setUp [
        | names | 

        names := Array new: 3.
        names at: 1 put: 'James'.
        names at: 2 put: 'Bob'.
        names at: 3 put: 'Dave'.
        game := Game numCards: 3 playerNames: names.
    ]

    testCurrentPlayerFirstOnCreate [
        self assert: game getCurrentPlayer name = 'James'
    ]

    testMoveToNextPlayerMoveOne [
        game moveToNextPlayer.
        self assert: game getCurrentPlayer name = 'Bob'
    ]    

    testMoveToNextPlayerRolls [
        3 timesRepeat: [
            game moveToNextPlayer
        ].
    
        self assert: game getCurrentPlayer name = 'James'
    ]

    testDealAddsCardsToPlayers [
        game deal.
        game players do: [:player |
            self assert: player hand size = 3.
            self assert: player faceUp size = 3.
            self assert: player faceDown size = 3.
        ].
    ]

    testDealRemovesFromDeck [
        game deal.
        self assert: game deck size = (52 - 27)
    ]

    

]

