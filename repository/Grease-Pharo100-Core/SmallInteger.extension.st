Extension { #name : 'SmallInteger' }

{ #category : '*Grease-Pharo100-Core' }
SmallInteger >> greaseByteAt: index [
	^ self byteAt: index
]

{ #category : '*Grease-Pharo100-Core' }
SmallInteger >> greaseBytesCount [
	^ self bytesCount
]
