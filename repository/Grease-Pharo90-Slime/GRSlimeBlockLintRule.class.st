Class {
	#name : 'GRSlimeBlockLintRule',
	#superclass : 'RBBlockLintRule',
	#category : 'Grease-Pharo90-Slime',
	#package : 'Grease-Pharo90-Slime'
}

{ #category : 'testing' }
GRSlimeBlockLintRule class >> isVisible [
	^ self name ~= #GRSlimeBlockLintRule
]

{ #category : 'accessing' }
GRSlimeBlockLintRule >> category [
	^ self group
]
