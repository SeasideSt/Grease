"
I check for TestCase >> #fail.
"
Class {
	#name : 'GRTestAssertionsRule',
	#superclass : 'GRSlimeTransformationRule',
	#category : 'Grease-Pharo90-Slime',
	#package : 'Grease-Pharo90-Slime'
}

{ #category : 'running' }
GRTestAssertionsRule >> checkMethod: aContext [
	aContext methodClass isMeta
		ifTrue: [ ^ self ].
	(aContext methodClass allSuperclasses includes:(Smalltalk at: #TestCase))
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
