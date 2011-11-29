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
        | str result |
        Console newline.
        Transcript show: name, ' would you like to swap cards? '.
        str := stdin nextLine.
        ((str = 'y') or: [str = 'Y'])
            ifTrue: [ result := true ]
            ifFalse: [ result := false ].
        ^result
    ]
    
    Console class >> requestHandSwap [
        | result |
        Transcript show: 'Please choose a hand card to swap: '.
        result := stdin nextLine asNumber.
        
        ^result
    ]

    Console class >> requestFaceUpSwap [
        | result |
        Transcript show: 'Please choose a face up card to swap: '.
        result := stdin nextLine asNumber.
        
        ^result
    ]

    Console class >> showGame: game [
        | currentPlayer |
        currentPlayer := game getCurrentPlayer.
        Console clearScreen.
        game players do: [:player |
            Console showPlayer: player.
            Console newline.
        ].
        Transcript show: currentPlayer name.
        Console newline.
    ]
        
]