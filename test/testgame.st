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

    testCanLayThreeOnThree [
        | pile pileCard card |
        pile := OrderedCollection new.
        card := Card rank: 3 suit: 1.
        pileCard := Card rank: 3 suit: 2.
        pile add: pileCard.

        self assert: (Game canLay: card on: pile)
    ]

    testCanLayFourOnThree [
        | pile pileCard card |
        pile := OrderedCollection new.
        card := Card rank: 4 suit: 1.
        pileCard := Card rank: 3 suit: 2.
        pile add: pileCard.

        self assert: (Game canLay: card on: pile)
    ]

    testCanLayTwoOnThree [
        | pile pileCard card |
        pile := OrderedCollection new.
        card := Card rank: 2 suit: 1.
        pileCard := Card rank: 3 suit: 2.
        pile add: pileCard.

        self assert: (Game canLay: card on: pile)
    ]
    
    testCanLaySevenOnNine [
        | pile pileCard card |
        pile := OrderedCollection new.
        card := Card rank: 7 suit: 1.
        pileCard := Card rank: 9 suit: 2.
        pile add: pileCard.

        self assert: (Game canLay: card on: pile)
    ]
    
    testCanLayTenOnQueen [
        | pile pileCard card |
        pile := OrderedCollection new.
        card := Card rank: 10 suit: 1.
        pileCard := Card rank: 12 suit: 2.
        pile add: pileCard.

        self assert: (Game canLay: card on: pile)
    ]
    
    testCanLayFiveOnSevenOnFour [
        | pile pileCard1 pileCard2 card |
        pile := OrderedCollection new.
        card := Card rank: 5 suit: 1.
        pileCard1 := Card rank: 4 suit: 2.
        pileCard2 := Card rank: 7 suit: 2.
        pile add: pileCard1.
        pile add: pileCard2.

        self assert: (Game canLay: card on: pile)
    ]
]

