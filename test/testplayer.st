PackageLoader fileInPackage: 'SUnit' !
FileStream fileIn: './src/player.st' !
FileStream fileIn: './src/card.st' !

TestCase subclass: PlayerTest [
    | player |

    setUp [
        player := Player name: 'James'.
    ] 

    testName [
        self assert: player name = 'James'
    ]

    testNewPlayerEmptyHand [
        self assert: player hand isEmpty
    ]
    
    testNewPlayerEmptyFaceUp [
        self assert: player faceUp isEmpty
    ]
    
    testNewPlayerEmptyFaceDown [
        self assert: player faceDown isEmpty
    ]

    testAddToHand [
        | card |

        card := Card rank: 10 suit: 3.
        player addToHand: card.
        self assert: player hand size = 1.
        self assert: ((player hand) includes: card)
    ]

    testAddToFaceUp [
        | card |

        card := Card rank: 10 suit: 3.
        player addToFaceUp: card.
        self assert: player faceUp size = 1.
        self assert: ((player faceUp) includes: card)
    ]
    
    testAddToHand [
        | card |

        card := Card rank: 10 suit: 3.
        player addToFaceDown: card.
        self assert: player faceDown size = 1.
        self assert: ((player faceDown) includes: card)
    ]

    testSwap [
        | card1 card2 card3 card4 card5 card6 |
    
        card1 := Card rank: 10 suit: 3.
        card2 := Card rank: 4 suit: 1.
        card3 := Card rank: 2 suit: 0.
        card4 := Card rank: 5 suit: 3.
        card5 := Card rank: 13 suit: 2.
        card6 := Card rank: 9 suit: 1.
        player addToHand: card1.
        player addToHand: card2.
        player addToHand: card3.
        player addToFaceUp: card4.
        player addToFaceUp: card5.
        player addToFaceUp: card6.

        player swap: 1 with: 2.
        
        self assert: ((player hand) includes: card5).
        self assert: ((player hand) includes: card1) not.

        self assert: ((player faceUp) includes: card1).
        self assert: ((player faceUp) includes: card5) not.
    ]

    testLowestHandCard [
        | card1 card2 card3 card4 |
    
        card1 := Card rank: 10 suit: 3.
        card2 := Card rank: 4 suit: 1.
        card3 := Card rank: 2 suit: 0.
        card4 := Card rank: 5 suit: 3.
        player addToHand: card1.
        player addToHand: card2.
        player addToHand: card3.
        player addToHand: card4.

        self assert: player lowestHandCard = card2
    ]

    testHasCardsInHandWhenDoes [
        | card |
    
        card := Card rank: 10 suit: 3.
        player addToHand: card.

        self assert: player hasCardsInHand.
    ]

    testNotHasCardsInHandWhenDoesnt [
        | card |
    
        card := Card rank: 10 suit: 3.
        player addToFaceUp: card.
        self assert: player hasCardsInHand not.
    ]
        
    testHasCardsInFaceUpWhenDoes [
        | card |
    
        card := Card rank: 10 suit: 3.
        player addToFaceUp: card.

        self assert: player hasCardsInFaceUp.
    ]

    testNotHasCardsInFaceUpWhenDoesnt [
        | card |
    
        card := Card rank: 10 suit: 3.
        player addToHand: card.

        self assert: player hasCardsInFaceUp not.
    ]

    testSortHand [
        | three five nine two |
        three := Card rank: 3 suit: 1.
        five := Card rank: 5 suit: 1.
        nine := Card rank: 9 suit: 1.
        two := Card rank: 2 suit: 1.

        player addToHand: nine.
        player addToHand: three.
        player addToHand: two.
        player addToHand: five.

        player sortHand.

        self assert: ((player hand at: 1) = three).
        self assert: ((player hand at: 2) = five).
        self assert: ((player hand at: 3) = nine).
        self assert: ((player hand at: 4) = two).
    ]
]

