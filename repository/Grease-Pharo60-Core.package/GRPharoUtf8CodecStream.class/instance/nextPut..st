streaming
nextPut: aCharacter
	| codePoint |
	codePoint := aCharacter codePoint.
	codePoint < 128 ifTrue: [
		^ stream nextPut: aCharacter ].
	codePoint < 256 ifTrue: [ 
		| shouldEncode |
		shouldEncode := Latin1ToUtf8Map at: codePoint + 1.
		^ shouldEncode = 1
			ifTrue: [ stream nextPutAll: (Latin1ToUtf8Encodings at: codePoint + 1) ]
			ifFalse: [ stream nextPut: aCharacter ] ].
		
	^ self nextPutAll: (String with: aCharacter)
	