PackageLoader fileInPackage: 'SUnit' !
FileStream fileIn: './src/card.st' !

TestCase subclass: CardTest [

    testPrintString [
        | card |
        card := Card rank: 5 suit: 1.
        self assert: card printString = 'FIVE of HEARTS'
    ]

    test2IsSpecialCard [
        | card |
        card := Card rank: 2 suit: 0.
        self assert: card specialCard
    ]
    
    test7IsSpecialCard [
        | card |
        card := Card rank: 7 suit: 0.
        self assert: card specialCard
    ]

    test10IsSpecialCard [
        | card |
        card := Card rank: 10 suit: 0.
        self assert: card specialCard
    ]
    
    test5IsNotSpecialCard [
        | card |
        card := Card rank: 5 suit: 3.
        self assert: card specialCard not
    ]

    testRankEquals [
        | card1 card2 |
        card1 := Card rank: 9 suit: 2.
        card2 := Card rank: 9 suit: 0.
        self assert: (card1 equalsRank: card2)
    ]

    testRankNotEquals [
        | card1 card2 |
        card1 := Card rank: 9 suit: 2.
        card2 := Card rank: 3 suit: 2.
        self assert: (card1 equalsRank: card2) not
    ]

    testEquals [
        | card1 card2 |
        card1 := Card rank: 3 suit: 2.
        card2 := Card rank: 3 suit: 2.
        self assert: card1 = card2
    ]

    testNotEquals [
        | card1 card2 |
        card1 := Card rank: 3 suit: 2.
        card2 := Card rank: 4 suit: 2.
        self assert: (card1 = card2) not
    ]

    testShCompareFirstSpecialWins [
        | card1 card2 |
        card1 := Card rank: 2 suit: 2.
        card2 := Card rank: 4 suit: 2.
        self assert: (Card shCompare: card1 with: card2) not
    ]
        
    testShCompareSecondSpecialWins [
        | card1 card2 |
        card1 := Card rank: 11 suit: 2.
        card2 := Card rank: 7 suit: 2.
        self assert: (Card shCompare: card1 with: card2)
    ]

    testShCompareHigherRankFirstWins [
        | card1 card2 |
        card1 := Card rank: 5 suit: 2.
        card2 := Card rank: 4 suit: 1.
        self assert: (Card shCompare: card1 with: card2) not
    ]

    testShCompareHigherRankSecondWins [
        | card1 card2 |
        card1 := Card rank: 5 suit: 2.
        card2 := Card rank: 6 suit: 1.
        self assert: (Card shCompare: card1 with: card2)
    ]

    testSameRankDifferentSuit [
        | card1 card2 |
        card1 := Card rank: 5 suit: 2.
        card2 := Card rank: 5 suit: 1.
        self assert: (card1 sameRankDifferentSuitTo: card2)
    ]

    testSameRankNotDifferentSuit [
        | card1 card2 |
        card1 := Card rank: 5 suit: 2.
        card2 := Card rank: 5 suit: 2.
        self assert: (card1 sameRankDifferentSuitTo: card2) not
    ]
    
    testNotSameRankSameSuit [
        | card1 card2 |
        card1 := Card rank: 2 suit: 2.
        card2 := Card rank: 5 suit: 2.
        self assert: (card1 sameRankDifferentSuitTo: card2) not
    ]

    testNotSameRankNotDifferentSuit [
        | card1 card2 |
        card1 := Card rank: 2 suit: 2.
        card2 := Card rank: 6 suit: 1.
        self assert: (card1 sameRankDifferentSuitTo: card2) not
    ]

]

