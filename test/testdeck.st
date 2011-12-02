PackageLoader fileInPackage: 'SUnit' !
FileStream fileIn: './src/deck.st' !

TestCase subclass: DeckTest [

    testNumDecksIs1 [
        self assert: (Deck numDecksForPlayers: 2 andCards: 3) = 1
    ]

    testNumDecksIs2 [
        self assert: (Deck numDecksForPlayers: 2 andCards: 10) = 2
    ]
        
    testNumDecksIs3 [
        self assert: (Deck numDecksForPlayers: 4 andCards: 10) = 3
    ]
]

