Extension { #name : 'BlockClosure' }

{ #category : '*grease-squeak6-core' }
BlockClosure >> valueWithPossibleArguments: anArray [
	
	^ self valueWithEnoughArguments: anArray
]
