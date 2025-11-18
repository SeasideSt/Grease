Class {
	#name : 'GRArrayTest',
	#superclass : 'GRAbstractSequenceableCollectionTest',
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'configuration' }
GRArrayTest >> allowsDuplicateValues [
	^ true
]

{ #category : 'configuration' }
GRArrayTest >> collectionClass [
	^ Array
]

{ #category : 'testing-ansi' }
GRArrayTest >> isExtensible [
	^ false
]

{ #category : 'testing' }
GRArrayTest >> isHomogeneous [
	^ false
]

{ #category : 'testing-ansi' }
GRArrayTest >> isInitializable [
	^ true
]

{ #category : 'testing-ansi' }
GRArrayTest >> isSequenced [
	^ true
]

{ #category : 'testing' }
GRArrayTest >> isUnique [
	^ false
]
