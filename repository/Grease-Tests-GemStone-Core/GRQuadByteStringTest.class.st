Class {
	#name : 'GRQuadByteStringTest',
	#superclass : 'GRStringTest',
	#category : 'Grease-Tests-GemStone-Core',
	#package : 'Grease-Tests-GemStone-Core'
}

{ #category : 'configuration' }
GRQuadByteStringTest >> arbitraryCollection [
	^ 'fadbbc' asQuadByteString
]

{ #category : 'configuration' }
GRQuadByteStringTest >> collectionClass [
	^ QuadByteString
]
