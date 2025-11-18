Class {
	#name : 'GRIntervalTest',
	#superclass : 'GRAbstractSequenceableCollectionTest',
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'configuration' }
GRIntervalTest >> allowsDuplicateValues [
	^ false
]

{ #category : 'configuration' }
GRIntervalTest >> arbitraryCollection [
	^ 1 to: 4
]

{ #category : 'configuration' }
GRIntervalTest >> collectionClass [
	^ Interval
]

{ #category : 'configuration' }
GRIntervalTest >> emptyCollection [
	^ 1 to: 0
]

{ #category : 'testing-ansi' }
GRIntervalTest >> isExtensible [
	^ false
]

{ #category : 'testing' }
GRIntervalTest >> isHomogeneous [
	^ true
]

{ #category : 'testing-ansi' }
GRIntervalTest >> isInitializable [
	^ false
]

{ #category : 'testing-ansi' }
GRIntervalTest >> isSequenced [
	^ false
]

{ #category : 'testing' }
GRIntervalTest >> isUnique [
	^ false
]

{ #category : 'tests' }
GRIntervalTest >> testBeginsWithSubCollection [
	self assert: ((-5 to: 10 by: 3) beginsWithSubCollection: (-5 to: 7 by: 3)).
	self assert: ((-5 to: 10 by: 3) beginsWithSubCollection: (-5 to: 10 by: 3)).
	self deny: ((-5 to: 10 by: 3) beginsWithSubCollection: (-8 to: 10 by: 3))
]

{ #category : 'tests' }
GRIntervalTest >> testEndsWithSubCollection [
	self assert: ((-5 to: 10 by: 3) endsWithSubCollection: (-2 to: 10 by: 3)).
	self assert: ((-5 to: 10 by: 3) endsWithSubCollection: (-5 to: 10 by: 3)).
	self deny: ((-5 to: 10 by: 3) endsWithSubCollection: (-5 to: 13 by: 3))
]

{ #category : 'tests' }
GRIntervalTest >> testSorted [
	"Unlike super implementation do not assume Interval >> #sorted returns a new object"
	| sorted collection |
	collection := self arbitraryCollection.
	sorted := collection sorted.
	self assert: sorted validSequencedResponseFrom: collection.
	self assert: sorted sortedWith: [ :a :b | a <= b ].
	
	sorted := collection sorted: [ :a :b | a > b ].
	self assert: sorted validSequencedNewResponseFrom: collection.
	self assert: sorted sortedWith: [ :a :b | a > b ]
]
