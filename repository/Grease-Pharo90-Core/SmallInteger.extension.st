Extension { #name : 'SmallInteger' }

{ #category : '*Grease-Pharo90-Core' }
SmallInteger >> greaseByteAt: index [
	^ self byteAt: index
]

{ #category : '*Grease-Pharo90-Core' }
SmallInteger >> greaseBytesCount [
	^ self bytesCount
]
