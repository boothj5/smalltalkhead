Object subclass: Player [
    | name hand faceUp faceDown |

    Player class >> name: aName [
        ^(self new)
            name: aName; 
            hand: OrderedCollection new;
            faceUp: OrderedCollection new;
            faceDown: OrderedCollection new;
            yourself.
    ]
    
    name: aName [ name := aName. ]
    name [ ^name. ]

    hand: aHand [ hand := aHand. ]
    hand [ ^hand ]
    
    faceUp: aFaceUp [ faceUp := aFaceUp. ]
    faceUp [ ^faceUp ]
    
    faceDown: aFaceDown [ faceDown := aFaceDown. ]
    faceDown [ ^faceDown ]

    addToHand: card [
        hand add: card
    ]

    addToFaceUp: card [
        faceUp add: card
    ]

    addToFaceDown: card [
        faceDown add: card
    ]

    swap: aHandCard with: aFaceUpCard [
        | tmpCard |
        tmpCard := hand at: aHandCard.
        hand at: aHandCard put: (faceUp at: aFaceUpCard).
        faceUp at: aFaceUpCard put: tmpCard.
    ]
    
    lowestHandCard [
        | lowestCard |
        lowestCard := hand at: 1.
        hand do: [:card |
            ((Card shCompare: card with: lowestCard) < 0)
                ifTrue: [ lowestCard := card ].
        ].
        
        ^lowestCard   
    ]

    hasCardsInHand [
        ^( hand size > 0 )
    ]

    hasCardsInFaceUp [
        ^( faceUp size > 0 )
    ]
]
