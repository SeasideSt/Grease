Class {
	#name : 'GRUsesMethodAnnotationsRule',
	#superclass : 'GRSlimeBlockLintRule',
	#category : 'Grease-Slime',
	#package : 'Grease-Slime'
}

{ #category : 'running' }
GRUsesMethodAnnotationsRule >> checkMethod: aContext [
	(self shouldExclude: aContext) ifFalse: [
		aContext compiledMethod pragmas do: [ :each |
			result 
				addClass: aContext selectedClass
				selector: aContext selector.
			result addSearchString: each keyword ] ]
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
	classCategory := aContext selectedClass theNonMetaClass category.
	^ #(#'-REST-' 'OmniBrowser') anySatisfy: [ :each |
		 (classCategory indexOfSubCollection: each startingAt: 1) ~= 0 ]
]
