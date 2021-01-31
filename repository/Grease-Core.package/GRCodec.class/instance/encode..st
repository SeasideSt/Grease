convenience
encode: aString
	| writeStream |
	writeStream := self encoderFor: (GRPlatform current
		writeCharacterStreamOn: (self encodedStringClass new: aString size)).
	writeStream nextPutAll: aString.
	^ writeStream contents