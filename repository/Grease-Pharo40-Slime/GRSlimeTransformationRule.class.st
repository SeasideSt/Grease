Class {
	#name : 'GRSlimeTransformationRule',
	#superclass : 'RBTransformationRule',
	#category : 'Grease-Pharo40-Slime',
	#package : 'Grease-Pharo40-Slime'
}

{ #category : 'testing' }
GRSlimeTransformationRule class >> isVisible [
	^ self name ~= #GRSlimeTransformationRule
]
