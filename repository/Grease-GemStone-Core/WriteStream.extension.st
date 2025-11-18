Extension { #name : 'WriteStream' }

{ #category : '*grease-gemstone-core' }
WriteStream >> crlf [

	self
		nextPut: Character cr;
		nextPut: Character lf;
		yourself.
]

{ #category : '*grease-gemstone-core' }
WriteStream >> greaseNext: anInteger putAll: aCollection startingAt: startIndex [
	"Store the next anInteger elements from the given collection."

	(startIndex = 1 and:[anInteger = aCollection size])
		ifTrue:[^self nextPutAll: aCollection].
	^self nextPutAll: (aCollection copyFrom: startIndex to: startIndex+anInteger-1)
]
