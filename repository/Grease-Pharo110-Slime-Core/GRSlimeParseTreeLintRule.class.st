"
For compatibility for versions of Seaside older than 3.5.6
"
Class {
	#name : 'GRSlimeParseTreeLintRule',
	#superclass : 'RBParseTreeLintRule',
	#category : 'Grease-Pharo110-Slime-Core',
	#package : 'Grease-Pharo110-Slime-Core'
}

{ #category : 'testing' }
GRSlimeParseTreeLintRule class >> isVisible [

	^ self name ~= #GRSlimeParseTreeLintRule
]
