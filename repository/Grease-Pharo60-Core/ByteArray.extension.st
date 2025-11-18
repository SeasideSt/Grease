Extension { #name : 'ByteArray' }

{ #category : '*Grease-Pharo60-Core' }
ByteArray >> greaseString [
	"ByteArrays should not automatically be converted to Strings. You should use a GRCodec for this."
	^ self printString
]
