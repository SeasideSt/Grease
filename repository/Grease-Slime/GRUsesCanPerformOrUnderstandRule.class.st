Class {
	#name : 'GRUsesCanPerformOrUnderstandRule',
	#superclass : 'GRSlimeParseTreeLintRule',
	#category : 'Grease-Slime',
	#package : 'Grease-Slime'
}

{ #category : 'accessing' }
GRUsesCanPerformOrUnderstandRule >> group [
	^ 'Grease Portability'
]

{ #category : 'initialization' }
GRUsesCanPerformOrUnderstandRule >> initialize [
	super initialize.
	self matcher
		matchesAnyOf: #(
			'`@receiver canPerform: `@selector'
			'`@receiver canUnderstand: `@selector' )
		do: [ :node :answer | answer isNil ifTrue: [ node ] ifFalse: [ answer ] ]
]

{ #category : 'accessing' }
GRUsesCanPerformOrUnderstandRule >> name [
	^ 'Sends #canPerform: or #canUnderstand:'
]

{ #category : 'accessing' }
GRUsesCanPerformOrUnderstandRule >> rationale [
	^ '#canPerform: or #canUnderstand: are not portable.'
]
