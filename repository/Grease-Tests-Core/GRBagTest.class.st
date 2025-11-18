Class {
	#name : 'GRBagTest',
	#superclass : 'GRCollectionTest',
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'configuration' }
GRBagTest >> allowsDuplicateValues [
	^ true
]

{ #category : 'configuration' }
GRBagTest >> collectionClass [
	^ Bag
]

{ #category : 'testing-ansi' }
GRBagTest >> isExtensible [
	^ true
]

{ #category : 'testing-ansi' }
GRBagTest >> isInitializable [
	^ true
]
