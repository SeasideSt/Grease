Class {
	#name : 'GRCollectionTest',
	#superclass : 'TestCase',
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'testing' }
GRCollectionTest class >> isAbstract [
	^ self name = #GRCollectionTest
]

{ #category : 'configuration' }
GRCollectionTest >> allowsDuplicateValues [
	"Does the tested collection allow storage of duplicate (equal) values."

	self subclassResponsibility
]

{ #category : 'configuration' }
GRCollectionTest >> arbitraryCollection [
	"An general collection for testing. It should meet the needs of #duplicateElement,
	#excludedElement, #includedElement, and so on where appropriate.  Make sure the
	duplicated element doesn't end up being in the first or last position both before
	and after sorting."
	
	^ self collectionClass withAll: #(4 3 1 2 3 5)
]

{ #category : 'asserting' }
GRCollectionTest >> assert: aCollection sortedWith: sortBlock [
	"Assert that aCollection is correctly sorted according to sortBlock."

	1 to: aCollection size -1 do: [ :index |
		| a b |
		a := aCollection at: index.
		b := aCollection at: index + 1.
		self assert: ((sortBlock value: a value: b) or: [ (sortBlock value: b value: a) not ]) ]
]

{ #category : 'asserting' }
GRCollectionTest >> assert: responseCollection validSequencedNewResponseFrom: receiverCollection [
	"Assert that the returned object is, in fact a new object, and that it is
	of a valid response class for the tested collection."
	
	self deny: responseCollection == receiverCollection.
	self assert: (self isValidNewSequencedResponseClass: responseCollection class)
]

{ #category : 'asserting' }
GRCollectionTest >> assert: responseCollection validSequencedResponseFrom: receiverCollection [
	"Assert that the returned object is of a valid response class for the tested collection."
	
	self assert: (self isValidNewSequencedResponseClass: responseCollection class)
]

{ #category : 'configuration' }
GRCollectionTest >> collectionClass [
	"Answer the collection class that is being tested."

	self subclassResponsibility
]

{ #category : 'configuration' }
GRCollectionTest >> duplicateElement [
	"Answer an element that appears multiple times in #arbitraryCollection."

	^ 3
]

{ #category : 'configuration' }
GRCollectionTest >> emptyCollection [
	"Answer an empty collection."

	^ self collectionClass new
]

{ #category : 'configuration' }
GRCollectionTest >> excludedElement [
	"Answer an element that does not appear in #arbitraryCollection."

	^ 19
]

{ #category : 'configuration' }
GRCollectionTest >> includedElement [
	"Answer a (non-duplicate) element that does appear in #arbitraryCollection."

	^ 2
]

{ #category : 'testing-ansi' }
GRCollectionTest >> isExtensible [
	"Answer whether the tested Collection implements the <extensibleCollection>
	protocol as defined in ANSI 5.7.5	."
		
	self subclassResponsibility
]

{ #category : 'testing-ansi' }
GRCollectionTest >> isInitializable [
	"Answer whether the tested Collection implements the <initializableCollection factory>
	protocol as defined in ANSI 5.7.23."
	
	self subclassResponsibility
]

{ #category : 'configuration' }
GRCollectionTest >> isValidNewSequencedResponseClass: aClass [
	"Answer whether aClass is a valid return type for methods that return a new sequenced
	collection. These are methods such as #copyFrom:to: or #reverse, which are
	defined by ANSI for most classes to return the same class as the receiver.
	However, for Interval (and maybe other cases), ANSI specifies that the response
	may be any <sequencedReadableCollection>."
	
	^ aClass == self collectionClass or: [
		aClass allSuperclasses includes: SequenceableCollection ]
]

{ #category : 'tests' }
GRCollectionTest >> testAny [
	| collection |
	collection := self arbitraryCollection.
	
	self assert: ((self valuesOf: collection) includes: collection any)
]

{ #category : 'tests' }
GRCollectionTest >> testEmptyAny [
	| collection |
	collection := self emptyCollection.
	
	self should: [ (self valuesOf: collection) includes: collection any ] raise: Error
]

{ #category : 'tests' }
GRCollectionTest >> testIsCollection [
	self assert: self arbitraryCollection isCollection
]

{ #category : 'tests' }
GRCollectionTest >> testNoneSatisfy [
	| excluded included |
	excluded := self excludedElement.
	self assert: (self arbitraryCollection noneSatisfy: [ :each | each = excluded ]).
	included := self includedElement.
	self deny: (self arbitraryCollection noneSatisfy: [ :each | each = included ]).
	self assert: (self emptyCollection noneSatisfy: [ :each | true ])
]

{ #category : 'tests' }
GRCollectionTest >> testNotEmpty [
	
	self assert: self arbitraryCollection notEmpty.
	self deny:  self emptyCollection notEmpty.
	self assert: self arbitraryCollection notEmpty.
	self deny:  self emptyCollection notEmpty
]

{ #category : 'tests' }
GRCollectionTest >> testSorted [
	| sorted collection |
	collection := self arbitraryCollection.
	sorted := collection sorted.
	self assert: sorted validSequencedNewResponseFrom: collection.
	self assert: sorted sortedWith: [ :a :b | a <= b ].
	
	sorted := collection sorted: [ :a :b | a > b ].
	self assert: sorted validSequencedNewResponseFrom: collection.
	self assert: sorted sortedWith: [ :a :b | a > b ]
]

{ #category : 'private' }
GRCollectionTest >> valuesOf: aCollection [
	"Answer the values of aCollecion. Dictionary tests override this."
	
	^ aCollection
]
