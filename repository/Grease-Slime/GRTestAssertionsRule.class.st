"
I check for TestCase >> #fail.
"
Class {
	#name : 'GRTestAssertionsRule',
	#superclass : 'GRSlimeTransformationRule',
	#category : 'Grease-Slime',
	#package : 'Grease-Slime'
}

{ #category : 'running' }
GRTestAssertionsRule >> checkMethod: aContext [ 
	aContext selectedClass isMeta
		ifTrue: [ ^ self ].
	(aContext includesBehaviorNamed: #TestCase)
		ifFalse: [ ^ self ].
	^ super checkMethod: aContext 
]

{ #category : 'accessing' }
GRTestAssertionsRule >> group [
	^ 'SUnit Compatibility'
]

{ #category : 'initialization' }
GRTestAssertionsRule >> initialize [
	super initialize.
	self rewriteRule
		replace: 'self fail'
			with: 'self assert: false'
]

{ #category : 'accessing' }
GRTestAssertionsRule >> name [
	^ 'TestCase >> #fail'
]

{ #category : 'accessing' }
GRTestAssertionsRule >> rationale [
	^ 'TestCase >> #fail is not portable.'
]
