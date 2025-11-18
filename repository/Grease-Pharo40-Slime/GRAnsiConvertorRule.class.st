Class {
	#name : 'GRAnsiConvertorRule',
	#superclass : 'GRSlimeTransformationRule',
	#category : 'Grease-Pharo40-Slime',
	#package : 'Grease-Pharo40-Slime'
}

{ #category : 'accessing' }
GRAnsiConvertorRule >> group [
	^ 'ANSI Compatibility'
]

{ #category : 'initialization' }
GRAnsiConvertorRule >> initialize [
	super initialize.
	self rewriteRule
		replace: '``@object asString' with: '``@object greaseString';
		replace: '``@object asInteger' with: '``@object greaseInteger'
]

{ #category : 'accessing' }
GRAnsiConvertorRule >> name [
	^ 'Convertors'
]

{ #category : 'accessing' }
GRAnsiConvertorRule >> rationale [
	^ 'The ANSI standard does not support #asInteger and #asString on Object.'
]
