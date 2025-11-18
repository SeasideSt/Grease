Extension { #name : 'SmallInteger' }

{ #category : '*grease-gemstone-core' }
SmallInteger >> greaseByteAt: index [

	^ self digitAt: index
]

{ #category : '*grease-gemstone-core' }
SmallInteger >> greaseBytesCount [

	^ self digitLength
]
