Class {
	#name : 'GRSortedCollectionTest',
	#superclass : 'GRAbstractSequenceableCollectionTest',
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'configuration' }
GRSortedCollectionTest >> allowsDuplicateValues [
	^ true
]

{ #category : 'configuration' }
GRSortedCollectionTest >> collectionClass [
	^ SortedCollection
]

{ #category : 'testing-ansi' }
GRSortedCollectionTest >> isExtensible [
	^ true
]

{ #category : 'testing' }
GRSortedCollectionTest >> isHomogeneous [
	^ true
]

{ #category : 'testing-ansi' }
GRSortedCollectionTest >> isInitializable [
	^ true
]

{ #category : 'testing-ansi' }
GRSortedCollectionTest >> isSequenced [
	^ false
]

{ #category : 'testing' }
GRSortedCollectionTest >> isUnique [
	^ false
]
