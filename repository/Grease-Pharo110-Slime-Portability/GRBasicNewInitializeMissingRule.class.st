Class {
	#name : 'GRBasicNewInitializeMissingRule',
	#superclass : 'GRReSlimeBlockLintRule',
	#instVars : [
		'matcher'
	],
	#category : 'Grease-Pharo110-Slime-Portability',
	#package : 'Grease-Pharo110-Slime-Portability'
}

{ #category : 'testing - interest' }
GRBasicNewInitializeMissingRule class >> checksClass [

	^ true
]

{ #category : 'running' }
GRBasicNewInitializeMissingRule >> basicCheck: aClass [

	^ aClass isMeta not
		and: [ (aClass includesSelector: #initialize)
		and: [ (#(GRObject GRNotification GRNotification GRError RBLintRule RBTransformationRule) noneSatisfy: [ :each |
				aClass includesBehavior: (Smalltalk globals at: each) ])
		and: [ aClass class methodDictionary noneSatisfy: [ :each |
				matcher
					executeTree: each parseTree
					initialAnswer: false ] ] ] ]
]

{ #category : 'accessing' }
GRBasicNewInitializeMissingRule >> group [

	^ 'Grease Portability'
]

{ #category : 'initialization' }
GRBasicNewInitializeMissingRule >> initialize [

	super initialize.
	matcher := RBParseTreeSearcher new.
	matcher
		matches: 'self basicNew initialize'
		do: [ :node :answer | true ]
]

{ #category : 'accessing' }
GRBasicNewInitializeMissingRule >> name [

	^ '#basicNew initialize is missing'
]

{ #category : 'accessing' }
GRBasicNewInitializeMissingRule >> rationale [

	^ '#initialize is not called implicitly when sending #new to an object in all Smalltalk dialects. Consider subclassing GRObject.'
]
