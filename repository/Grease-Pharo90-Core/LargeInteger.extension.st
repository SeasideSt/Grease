Extension { #name : 'LargeInteger' }

{ #category : '*Grease-Pharo90-Core' }
LargeInteger >> greaseByteAt: index [
	^ self byteAt: index
]

{ #category : '*Grease-Pharo90-Core' }
LargeInteger >> greaseBytesCount [
	^ self bytesCount
]
