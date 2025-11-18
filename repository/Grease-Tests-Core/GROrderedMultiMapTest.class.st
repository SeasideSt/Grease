Class {
	#name : 'GROrderedMultiMapTest',
	#superclass : 'GRSmallDictionaryTest',
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'testing' }
GROrderedMultiMapTest class >> shouldInheritSelectors [
	^ true
]

{ #category : 'configuration' }
GROrderedMultiMapTest >> allowsDuplicateKeys [
	^ true
]

{ #category : 'configuration' }
GROrderedMultiMapTest >> collectionClass [
	^ GROrderedMultiMap
]

{ #category : 'tests-accessing' }
GROrderedMultiMapTest >> testAllAt [
	self assert: (collection allAt: '1') = #().
	collection at: '1' add: 'foo'.
	collection at: '1' add: 'bar'.
	self assert: (collection allAt: '1') = #( 'foo' 'bar' )
]

{ #category : 'tests-accessing' }
GROrderedMultiMapTest >> testAllAtIfAbsent [
	self assert: (collection allAt: '1' ifAbsent: [ 'absent' ]) = 'absent'.
	collection at: '1' add: 'foo'.
	collection at: '1' add: 'bar'.
	self assert: (collection allAt: '1' ifAbsent: [ 'absent' ]) = #( 'foo' 'bar' )
]

{ #category : 'tests-accessing' }
GROrderedMultiMapTest >> testAtAdd [
	collection at: '1' add: 'foo'.
	collection at: '1' add: 'bar'.
	self assertAssociations: (Array with: '1' -> 'foo' with: '1' -> 'bar')
]

{ #category : 'tests-enumerating' }
GROrderedMultiMapTest >> testKeysAndAllValuesDo [
	| seen |
	collection at: '1' add: 'foo'.
	collection at: '2' add: 'bar'.
	collection at: '1' add: 'zork'.
	seen := OrderedCollection new.
	collection keysAndAllValuesDo: [ :key :values |
		seen add: key -> values ].
	self assert: seen size = 2.
	
	self assert: (seen at: 1) key = '1'.
	self assert: (seen at: 1) value size = 2.
	self assert: ((seen at: 1) value at: 1) = 'foo'.
	self assert: ((seen at: 1) value at: 2) = 'zork'.
	
	self assert: (seen at: 2) key = '2'.
	self assert: (seen at: 2) value size = 1.
	self assert: ((seen at: 2) value at: 1) = 'bar'.
]
