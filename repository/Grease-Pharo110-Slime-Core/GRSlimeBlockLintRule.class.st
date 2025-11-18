"
For compatibility for versions of Seaside older than 3.5.6
"
Class {
	#name : 'GRSlimeBlockLintRule',
	#superclass : 'RBBlockLintRule',
	#category : 'Grease-Pharo110-Slime-Core',
	#package : 'Grease-Pharo110-Slime-Core'
}

{ #category : 'testing' }
GRSlimeBlockLintRule class >> isVisible [

	^ self name ~= #GRSlimeBlockLintRule
]
