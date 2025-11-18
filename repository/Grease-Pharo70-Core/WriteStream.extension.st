Extension { #name : 'WriteStream' }

{ #category : '*Grease-Pharo70-Core' }
WriteStream >> greaseNext: anInteger putAll: aCollection startingAt: startIndex [
	"Store the next anInteger elements from the given collection."
	^ self next: anInteger putAll: aCollection startingAt: startIndex
]
