Class {
	#name : 'GRSlimeParseTreeLintRule',
	#superclass : 'RBParseTreeLintRule',
	#category : 'Grease-Slime',
	#package : 'Grease-Slime'
}

{ #category : 'testing' }
GRSlimeParseTreeLintRule class >> isVisible [
	^ self name ~= #GRSlimeParseTreeLintRule
]

{ #category : 'accessing' }
GRSlimeParseTreeLintRule >> category [
	^ self group
]
