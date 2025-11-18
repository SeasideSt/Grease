Class {
	#name : 'GRSymbolTest',
	#superclass : 'GRAbstractSequenceableCollectionTest',
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'configuration' }
GRSymbolTest >> allowsDuplicateValues [
	^ true
]

{ #category : 'configuration' }
GRSymbolTest >> arbitraryCollection [
	^ #'fadbbc'
]

{ #category : 'configuration' }
GRSymbolTest >> collectionClass [
	^ Symbol
]

{ #category : 'configuration' }
GRSymbolTest >> duplicateElement [
	^ $b
]

{ #category : 'configuration' }
GRSymbolTest >> emptyCollection [
	^ #''
]

{ #category : 'configuration' }
GRSymbolTest >> excludedElement [
	^ $Q
]

{ #category : 'configuration' }
GRSymbolTest >> includedElement [
	^ $d
]

{ #category : 'testing-ansi' }
GRSymbolTest >> isExtensible [
	^ false
]

{ #category : 'testing' }
GRSymbolTest >> isHomogeneous [
	^ true
]

{ #category : 'testing-ansi' }
GRSymbolTest >> isInitializable [
	^ false
]

{ #category : 'testing-ansi' }
GRSymbolTest >> isSequenced [
	^ false
]

{ #category : 'testing' }
GRSymbolTest >> isUnique [
	^ true
]
