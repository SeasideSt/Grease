Class {
	#name : 'GRAnsiCharactersRule',
	#superclass : 'GRReSlimeTransformationRule',
	#category : 'Grease-Pharo110-Slime-Portability',
	#package : 'Grease-Pharo110-Slime-Portability'
}

{ #category : 'accessing' }
GRAnsiCharactersRule >> group [

	^ 'ANSI Compatibility'
]

{ #category : 'initialization' }
GRAnsiCharactersRule >> initialize [

	super initialize.
	self
		replace: 'Character value: ``@expr'
		with: 'Character codePoint: ``@expr'.
	self
		replace: '`#source `{:node | node value isCharacter }` to: `#target'
		byEvaluating: [ :node |
			(node receiver value isCharacter and: [
				 node arguments first value isCharacter ])
				ifTrue: [
					RBLiteralNode value: (String streamContents: [ :stream |
							 node receiver value codePoint to: node arguments first value codePoint do: [ :code | stream nextPut: (Character codePoint: code) ] ]) ]
				ifFalse: [ node ] ]
]

{ #category : 'accessing' }
GRAnsiCharactersRule >> name [

	^ 'Characters'
]

{ #category : 'accessing' }
GRAnsiCharactersRule >> rationale [

	^ 'Character value: 64 and $a to: $b is not ANSI compatible.'
]
