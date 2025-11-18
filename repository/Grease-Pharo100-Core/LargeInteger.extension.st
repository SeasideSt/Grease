Extension { #name : 'LargeInteger' }

{ #category : '*Grease-Pharo100-Core' }
LargeInteger >> greaseByteAt: index [
	^ self byteAt: index
]

{ #category : '*Grease-Pharo100-Core' }
LargeInteger >> greaseBytesCount [
	^ self bytesCount
]
