Class {
	#name : 'GRSlimeBlockLintRule',
	#superclass : 'RBBlockLintRule',
	#category : 'Grease-Pharo40-Slime',
	#package : 'Grease-Pharo40-Slime'
}

{ #category : 'testing' }
GRSlimeBlockLintRule class >> isVisible [
	^ self name ~= #GRSlimeBlockLintRule
]

{ #category : 'accessing' }
GRSlimeBlockLintRule >> category [
	^ self group
]
