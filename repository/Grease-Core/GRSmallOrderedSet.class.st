"
I am an implementation of a dictionary. Compared to other dictionaries I am very efficient for small sizes, speed- and space-wise. I also mantain the order in which elements are added when iterating.
"
Class {
	#name : 'GRSmallOrderedSet',
	#superclass : 'GRObject',
	#instVars : [
		'size',
		'table'
	],
	#category : 'Grease-Core-Collections',
	#package : 'Grease-Core',
	#tag : 'Collections'
}

{ #category : 'instance creation' }
GRSmallOrderedSet class >> new [
	^ self new: 3
]

{ #category : 'instance creation' }
GRSmallOrderedSet class >> new: anInteger [
	^ self basicNew initialize: anInteger; yourself
]

{ #category : 'instance creation' }
GRSmallOrderedSet class >> withAll: aDictionary [
	^ (self new: aDictionary size)
		addAll: aDictionary;
		yourself
]

{ #category : 'adding' }
GRSmallOrderedSet >> add: newObject [
	(self findIndexFor: newObject) = 0
		ifTrue: [ self privateAdd: newObject ].
	^ newObject
]

{ #category : 'adding' }
GRSmallOrderedSet >> addAll: aCollection [
	aCollection do: [ :each |
		self add: each ].
	^ aCollection
]

{ #category : 'enumerating' }
GRSmallOrderedSet >> do: aOneArgumentBlock [
	1 to: size do: [ :i |
		aOneArgumentBlock value: (table at: i) ]
]

{ #category : 'enumerating' }
GRSmallOrderedSet >> do: aOneArgumentBlock separatedBy: aNiladicBlock [
	1 to: size do: [ :i |
		i > 1 ifTrue: [ aNiladicBlock value ].
		aOneArgumentBlock value: (table at: i) ]
]

{ #category : 'private ' }
GRSmallOrderedSet >> errorNotFound [
	self error: 'Not found'
]

{ #category : 'private ' }
GRSmallOrderedSet >> findIndexFor: aKey [
	1 to: size do: [ :index |
		(table at: index) = aKey
			ifTrue: [ ^ index ] ].
	^ 0
]

{ #category : 'private ' }
GRSmallOrderedSet >> grow [
	| newTable |
	"#replaceFrom:to:with:startingAt: would be better but not portable"
	newTable := Array new: 2 * size.
	1 to: size do: [ :index |
		newTable at: index put: (table at: index) ].
	table := newTable
]

{ #category : 'testing' }
GRSmallOrderedSet >> includes: anObject [
	^ (self findIndexFor: anObject) ~= 0
]

{ #category : 'initialization' }
GRSmallOrderedSet >> initialize: anInteger [
	self initialize.
	size := 0.
	table := Array new: anInteger
]

{ #category : 'testing' }
GRSmallOrderedSet >> isCollection [
	^ true
]

{ #category : 'testing' }
GRSmallOrderedSet >> isEmpty [
	^ size = 0
]

{ #category : 'copying' }
GRSmallOrderedSet >> postCopy [
	super postCopy.
	table := table copy
]

{ #category : 'private ' }
GRSmallOrderedSet >> privateAdd: newObject [
	size = table size ifTrue: [ self grow ].
	table at: (size := size + 1) put: newObject
]

{ #category : 'removing' }
GRSmallOrderedSet >> remove: anObject [
	^ self remove: anObject ifAbsent: [ self errorNotFound ]
]

{ #category : 'removing' }
GRSmallOrderedSet >> remove: anObject ifAbsent: aNiladicBlock [
	| index |
	index := self findIndexFor: anObject.
	index = 0
		ifTrue: [ ^ aNiladicBlock value ]
		ifFalse: [ self removeIndex: index ].
	^ anObject
]

{ #category : 'private ' }
GRSmallOrderedSet >> removeIndex: index [
	table at: index put: nil.
	index to: size - 1 do: [ :i |
		table at: i put: (table at: i + 1) ].
	size := size - 1
]

{ #category : 'accessing' }
GRSmallOrderedSet >> size [
	^ size
]
