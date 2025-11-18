Class {
	#name : 'GRInvalidObjectInitializationRule',
	#superclass : 'GRSlimeBlockLintRule',
	#category : 'Grease-Pharo90-Slime',
	#package : 'Grease-Pharo90-Slime'
}

{ #category : 'running' }
GRInvalidObjectInitializationRule >> checkMethod: aContext [
	(aContext methodClass isMeta not
		and: [ (aContext selector beginsWithSubCollection: #initialize)
		and: [ aContext selector numArgs > 0
		and: [ aContext methodClass ~= GRObject
		and: [ (aContext methodClass includesBehavior: GRObject)
		and: [ (aContext superMessages includes: aContext selector) not
		and: [ aContext selfMessages noneSatisfy: [ :each | each beginsWithSubCollection: #initialize ] ] ] ] ] ] ])
			ifTrue: [ result addClass: aContext methodClass selector: aContext selector ]
]

{ #category : 'accessing' }
GRInvalidObjectInitializationRule >> group [
	^ 'Grease Portability'
]

{ #category : 'accessing' }
GRInvalidObjectInitializationRule >> name [
	^ 'Invalid object initialization'
]

{ #category : 'accessing' }
GRInvalidObjectInitializationRule >> rationale [
	^ 'Initialize methods are required to call the designated initializer or its super implementation.'
]
