PackageLoader fileInPackage: 'SUnit' !
FileStream fileIn: './src/card.st' !

TestCase subclass: CardTest [
    | card |

    setUp [
        card := Card rank: 5 suit: 1.
    ]    
    
    testPrintString [
        self assert: card printString = 'FIVE of HEARTS'
    ]
]

