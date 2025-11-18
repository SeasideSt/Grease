Extension { #name : 'SocketStream' }

{ #category : '*grease-squeak6-core' }
SocketStream >> greaseNext: anInteger putAll: aCollection startingAt: startIndex [
	"Put a String or a ByteArray onto the stream starting at the given position.
	Currently a large collection will allocate a large buffer."

	anInteger > 0 ifFalse: [	^ aCollection ].
	^self
		next: anInteger
		putAll: (self isBinary ifTrue: [ aCollection asByteArray ] ifFalse: [ aCollection asString ])
		startingAt: startIndex.

]
