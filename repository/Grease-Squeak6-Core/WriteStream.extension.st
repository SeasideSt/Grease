Extension { #name : 'WriteStream' }

{ #category : '*grease-squeak6-core' }
WriteStream >> greaseNext: anInteger putAll: aCollection startingAt: startIndex [
	"Store the next anInteger elements from the given collection."
	^ self next: anInteger putAll: aCollection startingAt: startIndex
]
