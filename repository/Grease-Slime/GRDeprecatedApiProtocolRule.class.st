Class {
	#name : 'GRDeprecatedApiProtocolRule',
	#superclass : 'GRSlimeBlockLintRule',
	#instVars : [
		'matcher'
	],
	#category : 'Grease-Slime',
	#package : 'Grease-Slime'
}

{ #category : 'running' }
GRDeprecatedApiProtocolRule >> checkMethod: aContext [
	| matches |
	matches := matcher
		executeTree: aContext parseTree
		initialAnswer: OrderedCollection new.
	matches do: [ :node |
		" This ensures that the description is of the form ClassName>>#selector:"
		(node arguments first isLiteralNode and: [ node arguments first value isString and: [ aContext selectedClass name greaseString , '>>#' , aContext selector greaseString ~= node arguments first value ] ]) ifTrue: [
			result addClass: aContext selectedClass selector: aContext selector.
			result addSearchString: node arguments first value ].
		" This ensures that the description is a string and ends with a dot."
		(node arguments size > 1 and: [ node arguments second isLiteralNode and: [ node arguments second value isString and: [ (node arguments second value endsWithSubCollection: '.') not ] ] ]) ifTrue: [
			result addClass: aContext selectedClass selector: aContext selector.
			result addSearchString: node arguments second value ] ]
]

{ #category : 'accessing' }
GRDeprecatedApiProtocolRule >> group [
	^ 'Grease Formatting'
]

{ #category : 'initialization' }
GRDeprecatedApiProtocolRule >> initialize [
	super initialize.
	matcher := RBParseTreeSearcher new.
	matcher 
		matchesAnyOf: #(
			'``@receiver greaseDeprecatedApi: ``@arg1'
			'``@receiver greaseDeprecatedApi: ``@arg1 details: ``@arg2' )
		do: [ :node :answer | answer add: node; yourself ]
]

{ #category : 'accessing' }
GRDeprecatedApiProtocolRule >> name [
	^ 'Invalid use of deprecated API protocol.'
]

{ #category : 'accessing' }
GRDeprecatedApiProtocolRule >> rationale [
	^ 'Make sure to follow the following pattern: self greaseDeprecatedApi: ''Class>>#selector'' details: ''Some description''.'
]
