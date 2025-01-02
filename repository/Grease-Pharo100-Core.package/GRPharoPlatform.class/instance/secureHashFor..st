cryptography
secureHashFor: aStringOrByteArray
	^ SHA1 new hashMessage: aStringOrByteArray