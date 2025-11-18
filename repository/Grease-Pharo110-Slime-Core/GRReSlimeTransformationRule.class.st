Class {
	#name : 'GRReSlimeTransformationRule',
	#superclass : 'ReNodeRewriteRule',
	#category : 'Grease-Pharo110-Slime-Core',
	#package : 'Grease-Pharo110-Slime-Core'
}

{ #category : 'testing' }
GRReSlimeTransformationRule class >> isVisible [

	^ self name ~= #GRReSlimeTransformationRule
]
