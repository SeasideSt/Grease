Class {
	#name : 'GRSlimeParseTreeLintRule',
	#superclass : 'RBParseTreeLintRule',
	#category : 'Grease-Pharo40-Slime',
	#package : 'Grease-Pharo40-Slime'
}

{ #category : 'testing' }
GRSlimeParseTreeLintRule class >> isVisible [
	^ self name ~= #GRSlimeParseTreeLintRule
]

{ #category : 'accessing' }
GRSlimeParseTreeLintRule >> category [
	^ self group
]
