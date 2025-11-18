Class {
	#name : 'GRQuadByteStringTest',
	#superclass : 'GRStringTest',
	#category : 'Grease-Tests-GemStone32-Core',
	#package : 'Grease-Tests-GemStone32-Core'
}

{ #category : 'configuration' }
GRQuadByteStringTest >> arbitraryCollection [
	^ 'fadbbc' asQuadByteString
]

{ #category : 'configuration' }
GRQuadByteStringTest >> collectionClass [
	^ QuadByteString
]
