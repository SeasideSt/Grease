Class {
	#name : 'GRInvalidObjectInitializationRule',
	#superclass : 'GRSlimeBlockLintRule',
	#category : 'Grease-Slime',
	#package : 'Grease-Slime'
}

{ #category : 'running' }
GRInvalidObjectInitializationRule >> checkMethod: aContext [ 
	(aContext selectedClass isMeta not 
		and: [ (aContext selector beginsWithSubCollection: #initialize) 
		and: [ aContext selector numArgs > 0
		and: [ aContext selectedClass ~= GRObject
		and: [ (aContext selectedClass includesBehavior: GRObject)
		and: [ (aContext superMessages includes: aContext selector) not 
		and: [ aContext selfMessages noneSatisfy: [ :each | each beginsWithSubCollection: #initialize ] ] ] ] ] ] ]) 
			ifTrue: [ result addClass: aContext selectedClass selector: aContext selector ]
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
