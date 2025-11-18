Class {
	#name : 'GRBasicNewInitializeMissingRule',
	#superclass : 'GRSlimeBlockLintRule',
	#instVars : [
		'matcher'
	],
	#category : 'Grease-Slime',
	#package : 'Grease-Slime'
}

{ #category : 'running' }
GRBasicNewInitializeMissingRule >> checkClass: aContext [ 
	(aContext selectedClass isMeta not
		and: [ (aContext selectedClass includesSelector: #initialize)
		and: [ (#(GRObject GRNotification GRNotification GRError RBLintRule RBTransformationRule) noneSatisfy: [ :each |
				aContext selectedClass includesBehavior: (Smalltalk globals at: each) ])
		and: [ aContext selectedClass class methodDictionary noneSatisfy: [ :each | 
				matcher 
					executeTree: each parseTree
					initialAnswer: false ] ] ] ]) ifTrue: [
		result 
			addClass: aContext selectedClass
			selector: #initialize ]
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
	^ '#initialize is not called implicitely when sending #new to an object in other Smalltalk dialects. Consider subclassing GRObject.'
]
