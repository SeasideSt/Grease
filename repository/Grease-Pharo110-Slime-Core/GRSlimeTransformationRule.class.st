"
For compatibility for versions of Seaside older than 3.5.6
"
Class {
	#name : 'GRSlimeTransformationRule',
	#superclass : 'RBTransformationRule',
	#category : 'Grease-Pharo110-Slime-Core',
	#package : 'Grease-Pharo110-Slime-Core'
}

{ #category : 'testing' }
GRSlimeTransformationRule class >> isVisible [

	^ self name ~= #GRSlimeTransformationRule
]
