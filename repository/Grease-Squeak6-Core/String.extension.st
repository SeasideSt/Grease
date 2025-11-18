Extension { #name : 'String' }

{ #category : '*grease-squeak6-core' }
String >> padLeftTo: length with: char [
	^ self padded: #left to: length with: char
]

{ #category : '*grease-squeak6-core' }
String >> padRightTo: length with: char [
	^ self padded: #right to: length with: char
]

{ #category : '*grease-squeak6-core' }
String >> substrings: aString [

	^ self subStrings: aString


]

{ #category : '*grease-squeak6-core' }
String >> trimBoth [
	"Trim separators from both sides of the receiving string."
	
	^ self trimBoth: [ :char | char isSeparator ]
]

{ #category : '*grease-squeak6-core' }
String >> trimBoth: aBlock [
	"Trim characters satisfying the condition given in aBlock from both sides of the receiving string."

	^ self trimLeft: aBlock right: aBlock
]

{ #category : '*grease-squeak6-core' }
String >> trimLeft [
	"Trim separators from the left side of the receiving string."
	
	^ self trimLeft: [ :char | char isSeparator ]
]

{ #category : '*grease-squeak6-core' }
String >> trimLeft: aBlock [
	"Trim characters satisfying the condition given in aBlock from the left side of the receiving string."
	
	^ self trimLeft: aBlock right: [ :char | false ]
]

{ #category : '*grease-squeak6-core' }
String >> trimLeft: aLeftBlock right: aRightBlock [
	"Trim characters satisfying the condition given in aLeftBlock from the left side and aRightBlock from the right sides of the receiving string."

	| left right |
	left := 1.
	right := self size.
	[ left <= right and: [ aLeftBlock value: (self at: left) ] ]
		whileTrue: [ left := left + 1 ].
	[ left <= right and: [ aRightBlock value: (self at: right) ] ]
		whileTrue: [ right := right - 1 ].
	^ self copyFrom: left to: right
]

{ #category : '*grease-squeak6-core' }
String >> trimRight [
	"Trim separators from the right side of the receiving string."
	
	^ self trimRight: [ :char | char isSeparator ]
]

{ #category : '*grease-squeak6-core' }
String >> trimRight: aBlock [
	"Trim characters satisfying the condition given in aBlock from the right side of the receiving string."

	^ self trimLeft: [ :char | false ] right: aBlock
]
