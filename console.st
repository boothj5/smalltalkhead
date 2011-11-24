Object subclass: Console [

    Console class >> showWelcomeMessage [
        Transcript show: 'Welcome to SmalltalkHead!'; cr.
        Transcript show: '-------------------------'; cr; cr.
    ]

    Console class >> requestNumPlayers [
        | result |
        
        Transcript show: 'Enter number of players: '.
        result := stdin nextLine asNumber.
        
        ^result
    ]

    Console class >> requestNumCards [
        | result |
        
        Transcript show: 'Enter number of cards each: '.
        result := stdin nextLine asNumber.
        
        ^result
    ]

    Console class >> requestPlayerNames: numPlayers [
        | result |
        
        result := Array new: numPlayers.
        1 to: numPlayers do: [:i |
            Transcript show: 'Enter name for player ', i printString, ': '.
            result at: i put: stdin nextLine.
        ].

        ^result
    ]
]
