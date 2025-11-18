Extension { #name : 'PositionableStream' }

{ #category : '*Grease-Pharo100-Core' }
PositionableStream >> greaseUpToAll: aCollection [
	"Needed for Seaside ports to other dialects where #upToAll: may have
	different semantics"
	^ self upToAll: aCollection
]
