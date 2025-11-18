Class {
	#name : 'GRAbstractDictionaryTest',
	#superclass : 'GRCollectionTest',
	#instVars : [
		'associations'
	],
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'testing' }
GRAbstractDictionaryTest class >> isAbstract [
	^ self name = #GRAbstractDictionaryTest
]

{ #category : 'configuration' }
GRAbstractDictionaryTest >> allowsDuplicateValues [
	^ true
]

{ #category : 'configuration' }
GRAbstractDictionaryTest >> arbitraryAssociations [
	^ associations ifNil: [ associations := self createArbitraryAssociations ]
]

{ #category : 'configuration' }
GRAbstractDictionaryTest >> arbitraryCollection [
	| dict |
	dict := self emptyCollection.
	self arbitraryAssociations do: [ :each |
		dict at: each key put: each value ].
	^ dict
]

{ #category : 'configuration' }
GRAbstractDictionaryTest >> createArbitraryAssociations [
	self subclassResponsibility
]

{ #category : 'testing-ansi' }
GRAbstractDictionaryTest >> isExtensible [
	^ false
]

{ #category : 'testing-ansi' }
GRAbstractDictionaryTest >> isInitializable [
	^ false
]

{ #category : 'configuration' }
GRAbstractDictionaryTest >> isKey: anObject equivalentTo: anotherObject [
	self subclassResponsibility
]

{ #category : 'tests' }
GRAbstractDictionaryTest >> testAssociationsDo [
	| collection assocs count |
	collection := self arbitraryCollection.
	assocs := self arbitraryAssociations copy.
	count := 0.
	collection associationsDo: [ :assoc |
		| size |
		count := count + 1.
		size := assocs size.
		assocs := assocs
			reject: [ :each |
				(self isKey: each key equivalentTo: assoc key)
					and: [ each value = assoc value ] ].
		self assert: size - 1 = assocs size ].
	self assert: assocs isEmpty.
	self assert: count = self arbitraryAssociations size
]

{ #category : 'private' }
GRAbstractDictionaryTest >> valuesOf: aCollection [
	^ aCollection values
]
