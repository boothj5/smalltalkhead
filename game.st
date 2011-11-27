FileStream fileIn: 'player.st' !

Object subclass: Game [
    | numCards players |

    Game class >> numCards: aNumCards playerNames: names [
        | newPlayers |
        newPlayers := Array new: names size.
        1 to: names size do: [:i |
            newPlayers at: i put: (Player name: (names at: i)).
        ].
        ^(self new) 
            numCards: aNumCards; 
            players: newPlayers; 
            yourself.
    ]
    
    numCards: aNumCards [ numCards := aNumCards. ]
    numCards [ ^numCards. ]

    players: aPlayers [ players := aPlayers. ]
    players [ ^players. ]
]
