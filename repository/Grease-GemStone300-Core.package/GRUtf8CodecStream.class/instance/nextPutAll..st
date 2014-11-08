streaming
nextPutAll: aString
    "conversion of smaller string is faster if not using the changeClassTo: trick"
    binary
        ifTrue: [ stream nextPutAll: aString asString ]
        ifFalse: [ aString size > 8
                        ifTrue: [ stream nextPutAll: (aString encodeAsUTF8 changeClassTo: String) ]
                        ifFalse: [ | enc  str | enc := aString encodeAsUTF8. 
                                     str := String new: enc size.
                                    1 to: enc size do: [:idx | str at: idx put: (Character value: (enc at: idx)) ].
                                    stream nextPutAll: str ] ]
