FileStream fileIn: 'player.st' !

Object subclass: Game [
    | numCardsEach players |

    Game class >> numCardsEach: numCards playerNames: names [
        | newPlayers |
        newPlayers := Array new: names size.
        1 to: names size do: [:i |
            newPlayers at: i put: (Player name: (names at: i)).
        ].
        ^(self new) 
            setNumCardsEach: numCards; 
            setPlayers: newPlayers; 
            yourself.
    ]
    
    setNumCardsEach: num [
        numCardsEach := num.
    ]

    getNumCardsEach [
        ^numCardsEach.
    ]

    setPlayers: newPlayers [
        players := newPlayers.
    ]

    getPlayers [
        ^players.
    ]
]
