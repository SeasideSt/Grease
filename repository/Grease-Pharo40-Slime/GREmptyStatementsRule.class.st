Class {
	#name : 'GREmptyStatementsRule',
	#superclass : 'GRSlimeBlockLintRule',
	#category : 'Grease-Pharo40-Slime',
	#package : 'Grease-Pharo40-Slime'
}

{ #category : 'running' }
GREmptyStatementsRule >> checkMethod: aContext [ 
	| periods position |
	aContext parseTree nodesDo: [ :node |
		(node isSequence and: [ node periods notEmpty ]) ifTrue: [
			periods := OrderedCollection withAll: node periods.
			1 to: node statements size - 1 do: [ :index |
				position := periods removeFirst.
				((node statements at: index) stop < position and: [ position < (node statements at: index + 1) start ])
					ifFalse: [ ^ result addClass: aContext methodClass selector: aContext selector ] ].
			(periods isEmpty or: [ periods size = 1 and: [ node statements notEmpty and: [ node statements last stop < periods first ] ] ])
				ifFalse: [ ^ result addClass: aContext methodClass selector: aContext selector ] ] ]
]

{ #category : 'accessing' }
GREmptyStatementsRule >> group [
	^ 'Grease Portability'
]

{ #category : 'accessing' }
GREmptyStatementsRule >> name [
	^ 'Empty Statements'
]

{ #category : 'accessing' }
GREmptyStatementsRule >> rationale [
	^ 'Empty statements are not supported by most Smalltalk implementations.'
]

{ #category : 'running' }
GREmptyStatementsRule >> resetResult [
	super resetResult.
	result addSearchString: '..'; addSearchString: '.'
]
