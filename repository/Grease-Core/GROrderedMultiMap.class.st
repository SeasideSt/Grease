"
I am an implementation of an ordered multi-map. I allow multiple values to be associated with the same key and maintain the order of addition. #at: and its derivatives all operate on the first matching key, while #allAt: returns the complete list of values for a key in the order they were added.
"
Class {
	#name : 'GROrderedMultiMap',
	#superclass : 'GRSmallDictionary',
	#category : 'Grease-Core-Collections',
	#package : 'Grease-Core',
	#tag : 'Collections'
}

{ #category : 'accessing' }
GROrderedMultiMap >> add: anAssociation [
	self privateAt: anAssociation key put: anAssociation value.
	^ anAssociation
]

{ #category : 'adding' }
GROrderedMultiMap >> addAll: aDictionary [
	aDictionary keysAndValuesDo: [ :key :value |
			self privateAt: key put: value ].
	^ aDictionary
]

{ #category : 'accessing' }
GROrderedMultiMap >> allAt: aKey [
	^ Array streamContents: [ :stream |
		1 to: size do: [ :index |
			(keys at: index) = aKey
				ifTrue: [ stream nextPut: (values at: index) ] ] ]
]

{ #category : 'accessing' }
GROrderedMultiMap >> allAt: aKey ifAbsent: absentBlock [
	| results |
	results := self allAt: aKey.
	^ results isEmpty
		ifTrue: [ absentBlock value ]
		ifFalse: [ results ]
]

{ #category : 'accessing' }
GROrderedMultiMap >> at: aKey add: aValue [
	"Add an association between aKey and aValue. Do not replace existing
	values with the same key."

	^ self privateAt: aKey put: aValue
]

{ #category : 'enumerating' }
GROrderedMultiMap >> keysAndAllValuesDo: aTwoArgumentBlock [
	| seenKeys |
	seenKeys := GRSmallOrderedSet new.
	1 to: size do: [ :index |
		| key |
		key := keys at: index.
		(seenKeys includes: key) ifFalse: [
			aTwoArgumentBlock
				value: key
				value: (self privateAllAt: key startingAt: index).
			seenKeys add: key ] ]
]

{ #category : 'private' }
GROrderedMultiMap >> privateAllAt: aKey startingAt: aStartInteger [
	^ Array new: 2 streamContents: [ :stream |
		aStartInteger to: size do: [ :index |
			(keys at: index) = aKey
				ifTrue: [ stream nextPut: (values at: index) ] ] ]
]

{ #category : 'accessing' }
GROrderedMultiMap >> removeKey: aKey ifAbsent: aBlock [
	"Remove aKey from the receiver, evaluate aBlock if the element is missing."

	"This is inefficient and could be optimized."
	| removed |
	removed := Array new: 2 streamContents: [ :stream |
		| index |
		[ (index := self findIndexFor: aKey) = 0 ] whileFalse: [
			stream nextPut: (self removeIndex: index) ] ].
	^ removed isEmpty
		ifTrue: [ aBlock value ]
		ifFalse: [ removed ]
]
