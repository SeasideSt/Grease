"
I check for TestCase >> #fail.
"
Class {
	#name : 'GRTestAssertionsRule',
	#superclass : 'GRReSlimeTransformationRule',
	#category : 'Grease-Pharo110-Slime-Portability',
	#package : 'Grease-Pharo110-Slime-Portability'
}

{ #category : 'hooks' }
GRTestAssertionsRule >> afterCheck: aNode mappings: mappingsDict [

	aNode methodNode methodClass isMeta
		ifTrue: [ ^ false ].
	(aNode methodNode methodClass allSuperclasses includes: (Smalltalk at: #TestCase))
		ifTrue: [ ^ true ].
	^ false
]

{ #category : 'accessing' }
GRTestAssertionsRule >> group [

	^ 'SUnit Compatibility'
]

{ #category : 'initialization' }
GRTestAssertionsRule >> initialize [

	super initialize.
	self
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
