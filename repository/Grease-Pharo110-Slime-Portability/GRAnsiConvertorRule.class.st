Class {
	#name : 'GRAnsiConvertorRule',
	#superclass : 'GRReSlimeTransformationRule',
	#category : 'Grease-Pharo110-Slime-Portability',
	#package : 'Grease-Pharo110-Slime-Portability'
}

{ #category : 'accessing' }
GRAnsiConvertorRule >> group [

	^ 'ANSI Compatibility'
]

{ #category : 'initialization' }
GRAnsiConvertorRule >> initialize [

	super initialize.
	self
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
