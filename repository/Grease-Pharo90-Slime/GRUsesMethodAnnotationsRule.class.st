Class {
	#name : 'GRUsesMethodAnnotationsRule',
	#superclass : 'GRSlimeBlockLintRule',
	#category : 'Grease-Pharo90-Slime',
	#package : 'Grease-Pharo90-Slime'
}

{ #category : 'running' }
GRUsesMethodAnnotationsRule >> checkMethod: aContext [
	(self shouldExclude: aContext) ifFalse: [
		aContext pragmas do: [ :each |
			result
				addClass: aContext methodClass
				selector: aContext selector.
			result addSearchString: each selector ] ]
]

{ #category : 'accessing' }
GRUsesMethodAnnotationsRule >> group [
	^ 'Grease Portability'
]

{ #category : 'accessing' }
GRUsesMethodAnnotationsRule >> name [
	^ 'Uses method annotations'
]

{ #category : 'accessing' }
GRUsesMethodAnnotationsRule >> rationale [
	^ 'As of now, it is unclear if method-annotations/pragmas are compatible across all supported platforms. Likely this rule will soon be removed.'
]

{ #category : 'running' }
GRUsesMethodAnnotationsRule >> shouldExclude: aContext [
	"The REST and OmniBrowser related packages are OK to have pragmas"

	| classCategory |
	classCategory := aContext methodClass instanceSide category.
	^ #(#'-REST-' 'OmniBrowser')
		anySatisfy:
			[ :each | (classCategory indexOfSubCollection: each startingAt: 1) ~= 0 ]
]
