Class {
	#name : 'GRSetTest',
	#superclass : 'GRCollectionTest',
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'configuration' }
GRSetTest >> allowsDuplicateValues [
	^ false
]

{ #category : 'configuration' }
GRSetTest >> collectionClass [
	^ Set
]

{ #category : 'testing-ansi' }
GRSetTest >> isExtensible [
	^ true
]

{ #category : 'testing-ansi' }
GRSetTest >> isInitializable [
	^ true
]
