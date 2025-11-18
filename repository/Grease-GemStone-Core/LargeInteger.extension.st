Extension { #name : 'LargeInteger' }

{ #category : '*grease-gemstone-core' }
LargeInteger >> greaseByteAt: index [

	^ self digitAt: index
]

{ #category : '*grease-gemstone-core' }
LargeInteger >> greaseBytesCount [

	^ self digitLength
]
