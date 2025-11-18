Class {
	#name : 'GRReSlimeParseTreeLintRule',
	#superclass : 'ReNodeMatchRule',
	#category : 'Grease-Pharo110-Slime-Core',
	#package : 'Grease-Pharo110-Slime-Core'
}

{ #category : 'testing' }
GRReSlimeParseTreeLintRule class >> isVisible [

	^ self name ~= #GRReSlimeParseTreeLintRule
]
