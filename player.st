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
    
    faceUp: aFaceUp [ faceUp := aFaceUp. ]
    
    faceDown: aFaceDown [ faceDown := aFaceDown. ]
]
