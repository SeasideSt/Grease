Extension { #name : 'ReadByteStreamPortable' }

{ #category : '*grease-gemstone-kernelv370' }
ReadByteStreamPortable >> greaseUpToAll: aCollection [
	"Needed for Seaside ports to other dialects where #upToAll: may have
	different semantics"

	^self upToAll: aCollection
]
