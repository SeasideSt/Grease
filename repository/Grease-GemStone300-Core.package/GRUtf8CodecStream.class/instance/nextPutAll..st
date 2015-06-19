streaming
nextPutAll: aString
  "conversion of smaller string is faster if not using the changeClassTo: trick"

  binary
    ifTrue: [ stream nextPutAll: aString asString ]
    ifFalse: [ stream nextPutAll: aString encodeAsUTF8intoString ]