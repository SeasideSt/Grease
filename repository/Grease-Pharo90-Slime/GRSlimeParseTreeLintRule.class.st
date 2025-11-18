Class {
	#name : 'GRSlimeParseTreeLintRule',
	#superclass : 'RBParseTreeLintRule',
	#category : 'Grease-Pharo90-Slime',
	#package : 'Grease-Pharo90-Slime'
}

{ #category : 'testing' }
GRSlimeParseTreeLintRule class >> isVisible [
	^ self name ~= #GRSlimeParseTreeLintRule
]

{ #category : 'accessing' }
GRSlimeParseTreeLintRule >> category [
	^ self group
]
