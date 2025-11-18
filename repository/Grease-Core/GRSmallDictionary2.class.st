"
I am an implementation of a dictionary. Compared to other dictionaries I am very efficient for small sizes, speed- and space-wise. I also mantain the order in which elements are added when iterating. My implementation features some ideas from the RefactoringBrowser and others from Eclipse Collections.
"
Class {
	#name : 'GRSmallDictionary2',
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
GRSmallDictionary2 class >> new [
	^ self new: 3
]

{ #category : 'instance creation' }
GRSmallDictionary2 class >> new: anInteger [
	^ self basicNew initialize: anInteger; yourself
]

{ #category : 'instance creation' }
GRSmallDictionary2 class >> withAll: aDictionary [
	^ (self new: aDictionary size)
		addAll: aDictionary;
		yourself
]

{ #category : 'adding' }
GRSmallDictionary2 >> add: anAssociation [
	self at: anAssociation key put: anAssociation value.
	^ anAssociation
]

{ #category : 'adding' }
GRSmallDictionary2 >> addAll: aDictionary [
	aDictionary keysAndValuesDo: [ :key :value | self at: key put: value ].
	^ aDictionary
]

{ #category : 'accessing' }
GRSmallDictionary2 >> any [
	self isEmpty
		ifTrue: [ ^ self errorEmptyCollection ].
	^ table at: 2
]

{ #category : 'accessing' }
GRSmallDictionary2 >> associations [
	"Answer a Collection containing the receiver's associations."

	| result |
	result := WriteStream on: (Array new: self size).
	self associationsDo: [ :assoc | result nextPut: assoc ].
	^ result contents
]

{ #category : 'enumerating' }
GRSmallDictionary2 >> associationsDo: aBlock [
	self keysAndValuesDo: [ :key :value | aBlock value: key -> value ]
]

{ #category : 'accessing' }
GRSmallDictionary2 >> at: aKey [
	"Answer the value associated with aKey. Raise an exception, if no such key is defined."

	^ self at: aKey ifAbsent: [ self errorKeyNotFound ]
]

{ #category : 'accessing' }
GRSmallDictionary2 >> at: aKey ifAbsent: aBlock [
	"Answer the value associated with aKey. Evaluate aBlock, if no such key is defined."

	| index |
	index := self findIndexFor: aKey.
	^ index = 0
		ifFalse: [ table at: index + 1 ]
		ifTrue: [ aBlock value ]
]

{ #category : 'accessing' }
GRSmallDictionary2 >> at: aKey ifAbsentPut: aBlock [
	"Answer the value associated with aKey. Evaluate aBlock, if no such key is defined and store the return value."

	| index |
	index := self findIndexFor: aKey.
	^ index = 0
		ifFalse: [ table at: index + 1 ]
		ifTrue: [ self privateAt: aKey put: aBlock value ]
]

{ #category : 'accessing' }
GRSmallDictionary2 >> at: aKey ifPresent: aBlock [
	"Lookup aKey in the receiver. If it is present, answer the value of evaluating the given block with the value associated with the key. Otherwise, answer nil."

	| index |
	index := self findIndexFor: aKey.
	^ index = 0 ifFalse: [ aBlock value: (table at: index + 1) ]
]

{ #category : 'accessing' }
GRSmallDictionary2 >> at: aKey put: aValue [
	"Set the value of aKey to be aValue."

	| index |
	index := self findIndexFor: aKey.
	^ index = 0
		ifFalse: [ table at: index + 1 put: aValue ]
		ifTrue: [ self privateAt: aKey put: aValue ]
]

{ #category : 'enumerating' }
GRSmallDictionary2 >> do: aBlock [
	2 to: size * 2 by: 2 do: [ :index |
		aBlock value: (table at: index) ]
]

{ #category : 'private' }
GRSmallDictionary2 >> errorEmptyCollection [
	self error: 'Empty'
]

{ #category : 'private' }
GRSmallDictionary2 >> errorKeyNotFound [
	self error: 'Key not found'
]

{ #category : 'private' }
GRSmallDictionary2 >> findIndexFor: aKey [
	1 to: size * 2 - 1 by: 2 do: [ :index |
		(table at: index) = aKey
			ifTrue: [ ^ index ] ].
	^ 0
]

{ #category : 'private' }
GRSmallDictionary2 >> grow [
	| newTable |
	"#replaceFrom:to:with:startingAt: would be better but not portable"
	newTable := Array new: 4 * size.
	1 to: size * 2 do: [ :index |
		newTable at: index put: (table at: index) ].
	table := newTable
]

{ #category : 'testing' }
GRSmallDictionary2 >> includesKey: aKey [
	"Answer whether the receiver has a key equal to aKey."

	^ (self findIndexFor: aKey) ~= 0
]

{ #category : 'initialization' }
GRSmallDictionary2 >> initialize: anInteger [
	self initialize.
	size := 0.
	table := Array new: anInteger * 2
]

{ #category : 'testing' }
GRSmallDictionary2 >> isCollection [
	^ true
]

{ #category : 'testing' }
GRSmallDictionary2 >> isEmpty [
	^ size = 0
]

{ #category : 'enumerating' }
GRSmallDictionary2 >> keys [
	| keys i |
	size = 0 ifTrue: [ ^ #() ].
	i := 1.
	keys := Array new: size.
	1 to: size * 2 - 1 by: 2 do: [ :index |
		keys at: i put: (table at: index).
		i := i + 1 ].
	^ keys
]

{ #category : 'enumerating' }
GRSmallDictionary2 >> keysAndValuesDo: aBlock [
	1 to: size * 2 - 1 by: 2 do: [ :index |
		aBlock
			value: (table at: index)
			value: (table at: index + 1) ]
]

{ #category : 'enumerating' }
GRSmallDictionary2 >> keysDo: aBlock [
	1 to: size * 2 - 1 by: 2 do: [ :index |
			aBlock value: (table at: index) ]
]

{ #category : 'enumerating' }
GRSmallDictionary2 >> noneSatisfy: aOneArgumentBlock [
	size = 0 ifTrue: [ ^ true ].
	2 to: size * 2 by: 2 do: [ :index |
		(aOneArgumentBlock value: (table at: index)) ifTrue: [ ^ false ] ].
	^ true
]

{ #category : 'testing' }
GRSmallDictionary2 >> notEmpty [
	^ size ~= 0
]

{ #category : 'copying' }
GRSmallDictionary2 >> postCopy [
	super postCopy.
	table := table copy
]

{ #category : 'printing' }
GRSmallDictionary2 >> printOn: aStream [
	super printOn: aStream.

	aStream nextPut: $(.
	self size <= 100
		ifTrue: [
			| first |
			first := true.
			self keysAndValuesDo: [ :key :value |
				"keysAndValuesDo:separatedBy: would be nice"
				first
					ifTrue: [ first := false ]
					ifFalse: [ aStream space ].
				aStream
					print: key;
					nextPutAll: '->';
					print: value ] ]
		ifFalse: [
			aStream
				nextPutAll: 'size ';
				print: self size ].
	aStream nextPut: $)
]

{ #category : 'private' }
GRSmallDictionary2 >> privateAt: aKey put: aValue [
	size * 2 = table size ifTrue: [ self grow ].
	table at: (size * 2 + 1) put: aKey.
	table at: (size * 2 + 2) put: aValue.
	size := size + 1.
	^ aValue
]

{ #category : 'private' }
GRSmallDictionary2 >> removeIndex: index [
	| value |
	value := table at: index + 1.
	index to: size * 2 - 2 do: [ :i |
		table at: i put: (table at: i + 2) ].
	table at: size * 2 - 1 put: nil.
	table at: size * 2 put: nil.
	size := size - 1.
	^ value
]

{ #category : 'removing' }
GRSmallDictionary2 >> removeKey: aKey [
	"Remove aKey from the receiver, raise an exception if the element is missing."

	^ self removeKey: aKey ifAbsent: [ self errorKeyNotFound ]
]

{ #category : 'removing' }
GRSmallDictionary2 >> removeKey: aKey ifAbsent: aBlock [
	"Remove aKey from the receiver, evaluate aBlock if the element is missing."

	| index |
	index := self findIndexFor: aKey.
	index = 0 ifTrue: [ ^ aBlock value ].
	^ self removeIndex: index
]

{ #category : 'accessing' }
GRSmallDictionary2 >> size [
	^ size
]

{ #category : 'sorting' }
GRSmallDictionary2 >> sorted [
	^ self values sorted
]

{ #category : 'sorting' }
GRSmallDictionary2 >> sorted: aTwoArgumentBlock [
	^ self values sorted: aTwoArgumentBlock
]

{ #category : 'enumerating' }
GRSmallDictionary2 >> values [
	| values i |
	size = 0 ifTrue: [ ^ #() ].
	i := 1.
	values := Array new: size.
	2 to: size * 2 by: 2 do: [ :index |
		values at: i put: (table at: index).
		i := i + 1 ].
	^ values
]
