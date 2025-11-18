Class {
	#name : 'GRInvalidObjectInitializationRule',
	#superclass : 'GRReSlimeBlockLintRule',
	#category : 'Grease-Pharo110-Slime-Portability',
	#package : 'Grease-Pharo110-Slime-Portability'
}

{ #category : 'testing - interest' }
GRInvalidObjectInitializationRule class >> checksMethod [

	^ true
]

{ #category : 'running' }
GRInvalidObjectInitializationRule >> basicCheck: aMethod [

	^ (aMethod methodClass isMeta not
		and: [ (aMethod selector beginsWithSubCollection: #initialize)
		and: [ aMethod selector numArgs > 0
		and: [ aMethod methodClass ~= GRObject
		and: [ (aMethod methodClass includesBehavior: GRObject)
		and: [ (aMethod superMessages includes: aMethod selector) not
		and: [ aMethod selfMessages noneSatisfy: [ :each | each beginsWithSubCollection: #initialize ] ] ] ] ] ] ])
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
