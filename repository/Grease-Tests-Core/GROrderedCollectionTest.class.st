Class {
	#name : 'GROrderedCollectionTest',
	#superclass : 'GRAbstractSequenceableCollectionTest',
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'configuration' }
GROrderedCollectionTest >> allowsDuplicateValues [
	^ true
]

{ #category : 'configuration' }
GROrderedCollectionTest >> collectionClass [
	^ OrderedCollection
]

{ #category : 'testing-ansi' }
GROrderedCollectionTest >> isExtensible [
	^ true
]

{ #category : 'testing' }
GROrderedCollectionTest >> isHomogeneous [
	^ false
]

{ #category : 'testing-ansi' }
GROrderedCollectionTest >> isInitializable [
	^ true
]

{ #category : 'testing-ansi' }
GROrderedCollectionTest >> isSequenced [
	^ true
]

{ #category : 'testing' }
GROrderedCollectionTest >> isUnique [
	^ false
]
