Class {
	#name : 'GRNonPortableSourceFormatRule',
	#superclass : 'GRSlimeBlockLintRule',
	#category : 'Grease-Pharo40-Slime',
	#package : 'Grease-Pharo40-Slime'
}

{ #category : 'running' }
GRNonPortableSourceFormatRule >> checkClass: aContext [ 
	| comment |
	aContext isMeta 
		ifTrue: [ ^ self ].
	comment := aContext organization classComment asString.
	comment isWideString ifTrue: [
		result addClass: aContext ]
]

{ #category : 'running' }
GRNonPortableSourceFormatRule >> checkMethod: aContext [
	| foundLiteral |
	foundLiteral := false.
	"check individual literals first"
	aContext literals do: [ :each | 
		(each isString and: [ each isWideString ]) ifTrue: [
			result 
				addClass: aContext methodClass
				selector: aContext selector.
			result addSearchString:  each.
			foundLiteral := true ] ].
	
	"now check the whole method, could be in comments"
	foundLiteral ifFalse: [
		aContext sourceCode asString isWideString ifTrue: [
			result addClass: aContext methodClass selector: aContext selector ] ]
]

{ #category : 'accessing' }
GRNonPortableSourceFormatRule >> group [
	^ 'Grease Portability'
]

{ #category : 'accessing' }
GRNonPortableSourceFormatRule >> name [
	^ 'Non portable source format'
]

{ #category : 'accessing' }
GRNonPortableSourceFormatRule >> rationale [
	^ 'The method source is required to be a plain string, for portability reasons a wide-string is not supported.'
]
