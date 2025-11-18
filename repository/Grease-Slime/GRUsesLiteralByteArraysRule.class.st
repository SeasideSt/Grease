Class {
	#name : 'GRUsesLiteralByteArraysRule',
	#superclass : 'GRSlimeParseTreeLintRule',
	#category : 'Grease-Slime',
	#package : 'Grease-Slime'
}

{ #category : 'accessing' }
GRUsesLiteralByteArraysRule >> group [
	^ 'Grease Portability'
]

{ #category : 'initialization' }
GRUsesLiteralByteArraysRule >> initialize [
	super initialize.
	self matcher
		matches: '`#literal `{ :node | node isLiteralArray and: [ node isForByteArray ] }'
		do: [ :node :answer | answer isNil ifTrue: [ node ] ifFalse: [ answer ] ]
]

{ #category : 'accessing' }
GRUsesLiteralByteArraysRule >> name [
	^ 'Uses literal byte arrays'
]

{ #category : 'accessing' }
GRUsesLiteralByteArraysRule >> rationale [
	^ 'Literal byte arrays are not portable accross different Smalltalk dialects.'
]
