Object subclass: Player [
    | name |

    Player class >> name: aName [
        ^(self new)
            name: aName; 
            yourself.
    ]
    
    name: aName [ name := aName. ]
    name [ ^name. ]
]
