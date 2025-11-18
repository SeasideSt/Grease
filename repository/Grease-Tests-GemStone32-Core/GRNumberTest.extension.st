Extension { #name : 'GRNumberTest' }

{ #category : '*grease-tests-gemstone32-core' }
GRNumberTest >> addBlockToCollection: collection with: ea [
	
	collection add: [ea]
]

{ #category : '*grease-tests-gemstone32-core' }
GRNumberTest >> expectedFailures [
	"GemStone does not conform to the ANSI standard in this case"

	((System stoneVersionAt: 'gsVersion') beginsWith: '2.') ifTrue: [  ^#( #testToDoClosures ) ].
	^#()
]

{ #category : '*grease-tests-gemstone32-core' }
GRNumberTest >> testToDoClosuresGemStone [
	"workaround for non-ANSI compliance"
	
	| collection |
	collection := OrderedCollection new.
	1 to: 5 do: [ :ea | self addBlockToCollection: collection with: ea ].
	self assert: (collection collect: [ :ea | ea value ]) asArray = #(1 2 3 4 5)
]
