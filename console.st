Object subclass: Console [

    Console class >> showWelcomeMessage [
        Console clearScreen.
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

    Console class >> clearScreen [
        Console newLines: 100.
    ]

    Console class >> newline [
        Transcript cr.
    ]

    Console class >> newLines: num [
        num timesRepeat: [ Transcript cr. ].
    ]

    Console class >> showPlayer: player [
        Transcript show: player name; cr.
        Console showHand: player hand     ofType: 'HAND:     '.
        Console showHand: player faceUp   ofType: 'FACEUP:   '.
        Console showHand: player faceDown ofType: 'FACEDOWN: '.
    ]

    Console class >> showHand: hand ofType: type [
        Transcript show: type.
        hand do: [:card |
            Transcript show: card printString, ', '.
        ].
        Transcript cr.
    ]

    Console class >> requestSwap: name [
        | result |
        Console newline.
        Transcript show: name, ' would you like to swap cards? '.
        result := stdin nextLine.
        
        ^result
    ]
]
