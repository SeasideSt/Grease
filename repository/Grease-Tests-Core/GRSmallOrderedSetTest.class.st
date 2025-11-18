Class {
	#name : 'GRSmallOrderedSetTest',
	#superclass : 'GRSetTest',
	#instVars : [
		'collection'
	],
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'configuration' }
GRSmallOrderedSetTest >> collectionClass [
	^ GRSmallOrderedSet
]

{ #category : 'running' }
GRSmallOrderedSetTest >> setUp [
	super setUp.
	collection := GRSmallOrderedSet new
]

{ #category : 'testing' }
GRSmallOrderedSetTest >> testAdd [
	| object |
	object := Object new.
	self assert: collection size = 0.
	self assert: (collection add: object) == object.
	self assert: collection size = 1.
	self assert: (collection add: object) == object
]

{ #category : 'testing' }
GRSmallOrderedSetTest >> testAddAll [
	collection addAll: #(2 1 1).
	self assert: collection size = 2.
	self assert: (collection includes: 1).
	self assert: (collection includes: 2)
]

{ #category : 'testing' }
GRSmallOrderedSetTest >> testCopy [
	| copy |
	collection add: 1.
	copy := collection copy.
	collection add: 2.
	
	self assert: collection size = 2.
	self assert: copy size = 1.
	
	self assert: (collection includes: 2).
	self deny: (copy includes: 2).
]

{ #category : 'testing' }
GRSmallOrderedSetTest >> testDo [
	| seen |
	collection addAll: #(2 1 1).
	seen := Array streamContents: [ :stream |
		collection do: [ :each |
			stream nextPut: each ] ].
	self assert: seen size = 2.
	self assert: (seen at: 1) = 2.
	self assert: (seen at: 2) = 1
]

{ #category : 'testing' }
GRSmallOrderedSetTest >> testIncludes [
	self deny: (collection includes: 0).
	collection add: 0.
	self assert: (collection includes: 0)
]

{ #category : 'testing' }
GRSmallOrderedSetTest >> testIsEmpty [
	self assert: collection isEmpty.
	collection add: 1.
	self deny: collection isEmpty.
	collection remove: 1.
	self assert: collection isEmpty
]

{ #category : 'testing' }
GRSmallOrderedSetTest >> testRemove [
	collection add: 1.
	self assert: (collection remove: 1) = 1.
	self should: [ collection remove: 1 ] raise: Error
]

{ #category : 'testing' }
GRSmallOrderedSetTest >> testRemoveIfAbsent [
	| absent |
	collection add: 1.
	absent := false.
	
	self assert: (collection remove: 1 ifAbsent: [ absent := true ]) = 1.
	self deny: absent.
	
	collection remove: 1 ifAbsent: [ absent := true ].
	self assert: absent.
]

{ #category : 'testing' }
GRSmallOrderedSetTest >> testSize [
	self assert: collection size = 0.
	collection addAll: #(2 1 1).
	self assert: collection size = 2.
]
