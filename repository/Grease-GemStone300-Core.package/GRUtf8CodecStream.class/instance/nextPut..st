streaming
nextPut: aCharacter
    "old implementation is very slow !!"
"   self nextPutAll: (String with: aCharacter)"
    | codePoint |
    codePoint := aCharacter codePoint.
    codePoint > 127
        ifTrue: [ 
            codePoint > 255
                ifTrue: [ | enc str |
                        enc := (String with: aCharacter) encodeAsUTF8. 
                         str := String new: enc size.
                        1 to: enc size do: [:idx | str at: idx put: (Character value: (enc at: idx)) ].
                        stream nextPutAll: str ]
                ifFalse: [ stream nextPutAll: (Latin1ToUtf8Encodings at: codePoint + 1) ] ]
        ifFalse: [ stream nextPut: aCharacter ]