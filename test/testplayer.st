PackageLoader fileInPackage: 'SUnit' !
FileStream fileIn: './src/player.st' !

TestCase subclass: PlayerTest [
    | player |

    setUp [
        player := Player name: 'James'
    ]    
    
    testName [
        self assert: player name = 'James'
    ]
]

