Class {
	#name : 'GRReturnFormattingRule',
	#superclass : 'GRSlimeParseTreeLintRule',
	#category : 'Grease-Slime',
	#package : 'Grease-Slime'
}

{ #category : 'accessing' }
GRReturnFormattingRule >> group [
	^ 'Grease Formatting'
]

{ #category : 'initialization' }
GRReturnFormattingRule >> initialize [
	super initialize.
	self matcher
		matches: '^ ``@expr'
		do: [ :node :answer |
			answer isNil 
				ifFalse: [ answer ]
				ifTrue: [ 
					node start + 2 ~= node value start
						ifTrue: [ node ] ] ]
]

{ #category : 'accessing' }
GRReturnFormattingRule >> name [
	^ 'Return formatting'
]

{ #category : 'accessing' }
GRReturnFormattingRule >> rationale [
	^ 'There should be a single space between the ^ and the following expression.'
]
