Class {
	#name : 'GRTempsFormattingRule',
	#superclass : 'GRSlimeParseTreeLintRule',
	#category : 'Grease-Pharo90-Slime',
	#package : 'Grease-Pharo90-Slime'
}

{ #category : 'accessing' }
GRTempsFormattingRule >> group [
	^ 'Grease Formatting'
]

{ #category : 'initialization' }
GRTempsFormattingRule >> initialize [
	super initialize.
	self matcher
		matches: '| `temp `@temps | ``@.stmts'
		do: [ :node :answer |
			answer isNil
				ifFalse: [ answer ]
				ifTrue: [
					(node leftBar notNil and: [ node rightBar notNil ]) ifTrue: [
						| found position |
						found := false.
						position := node leftBar.
						node temporaries do: [ :each |
							found := found or: [ position + 2 ~= each start ].
							position := each stop ].
						found := found or: [ position + 2 ~= node rightBar ].
						found ifTrue: [ node ] ] ] ]
]

{ #category : 'accessing' }
GRTempsFormattingRule >> name [
	^ 'Temporaries formatting'
]

{ #category : 'accessing' }
GRTempsFormattingRule >> rationale [
	^ 'There should be a single space between the | and the individual temps.'
]
