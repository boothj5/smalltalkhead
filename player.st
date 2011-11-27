Object subclass: Player [
    | name |

    Player class >> name: aName [
        ^(self new)
            setName: aName; 
            yourself.
    ]
    
    setName: aName [
        name := aName.
    ]

    getName [
        ^name.
    ]
]
