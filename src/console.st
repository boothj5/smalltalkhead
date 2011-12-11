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
        1 to: hand size do: [:i |
            | cardStr |
            (type = 'FACEDOWN: ') 
                ifTrue:  [ cardStr := '****' ]
                ifFalse: [ cardStr := (hand at: i) printString ].
            Transcript show: '(', i printString, ')', cardStr.
            ( i < hand size)
                ifTrue: [ Transcript show: ', ' ].
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

    Console class >> showPickupMessage: player [
        Transcript show: 'OH DEAR ', player, ', you must pick up! Press enter.'.
        stdin nextLine.
    ]

    Console class >> showBadMove [
        Transcript show: 'You can''t do thay, try again.'.
    ]

    Console class >> showGame: game [
        Console clearScreen.
        Console showPile: game pile.
        Console newline.
        Console showDeck: game deck.
        Console newline.
        Console showBurnt: game burnt.
        Console newline.
        game players do: [:player |
            Console showPlayer: player.
            Console newline.
        ].
        Transcript show: game lastMove.
        Console newline.
    ]

    Console class >> showPile: pile [
        Transcript show: pile size printString, ' on pile:'.
        Console newline.
        pile size to: 1 by: -1 do: [:i |
            Transcript show: (pile at: i) printString.
            Console newline.
        ].
    ] 
        
    Console class >> showDeck: deck [
        Transcript show: deck size printString, ' left on deck'.
        Console newline.
    ]

    Console class >> showBurnt: burnt [
        Transcript show: burnt size printString, ' burnt'.
        Console newline.
    ]

    Console class >> requestHandChoice: name [
        | result indexes |
        Transcript show: name, ' enter cards to lay: '.
        result := stdin nextLine.
        indexes := (result tokenize: ',') collect: [:x | x asNumber].

        ^indexes
    ]
]
