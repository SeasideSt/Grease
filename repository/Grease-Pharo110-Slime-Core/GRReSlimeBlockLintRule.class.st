Class {
	#name : 'GRReSlimeBlockLintRule',
	#superclass : 'ReAbstractRule',
	#category : 'Grease-Pharo110-Slime-Core',
	#package : 'Grease-Pharo110-Slime-Core'
}

{ #category : 'testing' }
GRReSlimeBlockLintRule class >> isVisible [

	^ self name ~= #GRReSlimeBlockLintRule
]
