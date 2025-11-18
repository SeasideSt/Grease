Extension { #name : 'CharacterCollection' }

{ #category : '*grease-gemstone-core' }
CharacterCollection >> excerpt: aString [
	"Answer an excerpt of the receiver that matches the first occurence of aString. If aString isn't found, nil is answered."
	
	^ self excerpt: aString radius: 100
]

{ #category : '*grease-gemstone-core' }
CharacterCollection >> excerpt: aString radius: anInteger [
	"Answer an excerpt of the receiver that matches the first occurence of aString. The radius anInteger expands the excerpt on each side of the first occurrence by the number of characters defined in radius. If aString isn't found, nil is answered."
	
	^ self excerpt: aString radius: anInteger ellipsis: '...'
]

{ #category : '*grease-gemstone-core' }
CharacterCollection >> excerpt: aString radius: anInteger ellipsis: anEllipsisString [
	"Answer an excerpt of the receiver that matches the first occurence of aString. The radius anInteger expands the excerpt on each side of the first occurrence by the number of characters defined in radius. If aString isn't found, nil is answered."

	| index start stop |
	(index := self indexOfSubCollection: aString) = 0
		ifTrue: [ ^ nil ].
	start := index - anInteger max: 1.
	stop := index + anInteger + aString size - 1 min: self size.
	^ (start > 1 ifTrue: [ anEllipsisString ] ifFalse: [ '' ]) ,
		(self copyFrom: start to: stop) ,
	  	(stop < self size ifTrue: [ anEllipsisString ] ifFalse: [ '' ])
]

{ #category : '*grease-gemstone-core' }
CharacterCollection >> greaseInteger [
	"Convert the receiver to an integer, answer nil if this is not a number."
	| number stream negated char |
	number := nil.
	stream := self readStream.
	negated := stream peek = $-.
	negated ifTrue: [ stream next ].
	[ stream atEnd not and: [ (char := stream next) isDigit ] ] whileTrue: [
		number := (number isNil  ifTrue: [ 0 ]ifFalse: [ 10 * number ])
			+ (char greaseInteger - $0 greaseInteger) ].
	^ (number isNil or: [ negated not ]) 
		ifFalse: [ number negated ]
		ifTrue: [ number ]
]

{ #category : '*grease-gemstone-core' }
CharacterCollection >> pluralize [
	^ GRInflector pluralize: self
]

{ #category : '*grease-gemstone-core' }
CharacterCollection >> print: anObject on: aStream [
	aStream nextPutAll: self
]

{ #category : '*grease-gemstone-core' }
CharacterCollection >> substrings: aCharacter [
	"Pharo 6+ compatibility"
 	^ self subStrings: aCharacter
]

{ #category : '*grease-gemstone-core' }
CharacterCollection >> trimBoth [
	"Trim separators from both sides of the receiving string."
	
	^ self trimBoth: [ :char | char isSeparator ]
]

{ #category : '*grease-gemstone-core' }
CharacterCollection >> trimBoth: aBlock [
	"Trim characters satisfying the condition given in aBlock from both sides of the receiving string."

	^ self trimLeft: aBlock right: aBlock
]

{ #category : '*grease-gemstone-core' }
CharacterCollection >> trimLeft [
	"Trim separators from the left side of the receiving string."
	
	^ self trimLeft: [ :char | char isSeparator ]
]

{ #category : '*grease-gemstone-core' }
CharacterCollection >> trimLeft: aBlock [
	"Trim characters satisfying the condition given in aBlock from the left side of the receiving string."
	
	^ self trimLeft: aBlock right: [ :char | false ]
]

{ #category : '*grease-gemstone-core' }
CharacterCollection >> trimLeft: aLeftBlock right: aRightBlock [
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

{ #category : '*grease-gemstone-core' }
CharacterCollection >> trimRight [
	"Trim separators from the right side of the receiving string."
	
	^ self trimRight: [ :char | char isSeparator ]
]

{ #category : '*grease-gemstone-core' }
CharacterCollection >> trimRight: aBlock [
	"Trim characters satisfying the condition given in aBlock from the right side of the receiving string."

	^ self trimLeft: [ :char | false ] right: aBlock
]

{ #category : '*grease-gemstone-core' }
CharacterCollection >> truncate [
	"Truncate the receiver to 30 characters."
	
	^ self truncate: 30
]

{ #category : '*grease-gemstone-core' }
CharacterCollection >> truncate: anInteger [
	"Truncate the receiver to anInteger characters."
	
	^ self truncate: anInteger ellipsis: '...'
]

{ #category : '*grease-gemstone-core' }
CharacterCollection >> truncate: anInteger ellipsis: aString [
	"Truncate the receiver to anInteger characters and append aString as ellipsis if necessary."

	^ anInteger < self size
		ifTrue: [ (self copyFrom: 1 to: anInteger) , aString ]
		ifFalse: [ self copy ]
]
