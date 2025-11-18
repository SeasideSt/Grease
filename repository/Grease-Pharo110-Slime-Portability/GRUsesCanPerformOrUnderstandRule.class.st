Class {
	#name : 'GRUsesCanPerformOrUnderstandRule',
	#superclass : 'GRReSlimeParseTreeLintRule',
	#category : 'Grease-Pharo110-Slime-Portability',
	#package : 'Grease-Pharo110-Slime-Portability'
}

{ #category : 'accessing' }
GRUsesCanPerformOrUnderstandRule >> group [

	^ 'Grease Portability'
]

{ #category : 'initialization' }
GRUsesCanPerformOrUnderstandRule >> initialize [

	super initialize.
	self matchesAny: #( 
		'`@receiver canPerform: `@selector'
		'`@receiver canUnderstand: `@selector' )
]

{ #category : 'accessing' }
GRUsesCanPerformOrUnderstandRule >> name [

	^ 'Sends #canPerform: or #canUnderstand:'
]

{ #category : 'accessing' }
GRUsesCanPerformOrUnderstandRule >> rationale [

	^ '#canPerform: or #canUnderstand: are not portable.'
]
