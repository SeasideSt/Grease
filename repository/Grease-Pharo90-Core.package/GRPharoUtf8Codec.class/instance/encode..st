convenience
encode: aString
	| writeStream |
	writeStream := self encoderFor: (ByteArray new: aString size) writeStream.
	writeStream nextPutAll: aString.
	^ writeStream contents