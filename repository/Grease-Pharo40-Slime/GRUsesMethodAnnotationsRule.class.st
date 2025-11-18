Class {
	#name : 'GRUsesMethodAnnotationsRule',
	#superclass : 'GRSlimeBlockLintRule',
	#category : 'Grease-Pharo40-Slime',
	#package : 'Grease-Pharo40-Slime'
}

{ #category : 'running' }
GRUsesMethodAnnotationsRule >> checkMethod: aContext [
	(self shouldExclude: aContext) ifFalse: [
		aContext pragmas do: [ :each |
			result 
				addClass: aContext methodClass
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
	classCategory := aContext methodClass theNonMetaClass category.
	^ #(#'-REST-' 'OmniBrowser') anySatisfy: [ :each |
		 (classCategory indexOfSubCollection: each startingAt: 1) ~= 0 ]
]
