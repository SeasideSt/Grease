Extension { #name : 'Random' }

{ #category : '*grease-squeak6-core' }
Random >> randomFrom: aCollection [

	^ aCollection atRandom: self
]
