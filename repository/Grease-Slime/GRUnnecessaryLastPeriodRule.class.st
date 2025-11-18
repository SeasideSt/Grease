Class {
	#name : 'GRUnnecessaryLastPeriodRule',
	#superclass : 'GRSlimeBlockLintRule',
	#category : 'Grease-Slime',
	#package : 'Grease-Slime'
}

{ #category : 'running' }
GRUnnecessaryLastPeriodRule >> checkMethod: aContext [ 
	aContext parseTree nodesDo: [ :node |
		node isSequence ifTrue: [
			(node statements notEmpty and: [ node periods notEmpty ]) ifTrue: [
				node periods last > node statements last stop ifTrue: [
					^ result addClass: aContext selectedClass selector: aContext selector ] ] ] ]
]

{ #category : 'accessing' }
GRUnnecessaryLastPeriodRule >> group [
	^ 'Grease Formatting'
]

{ #category : 'accessing' }
GRUnnecessaryLastPeriodRule >> name [
	^ 'Unnecessary Last Period'
]

{ #category : 'accessing' }
GRUnnecessaryLastPeriodRule >> rationale [
	^ 'Periods are not needed after the last satement.'
]

{ #category : 'running' }
GRUnnecessaryLastPeriodRule >> resetResult [
	super resetResult.
	result addSearchString: '..'; addSearchString: '.'
]
