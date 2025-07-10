conversion
encoderFor: aStream 
	^ GRSqueakUtf8CodecStream 
		on: aStream
		converter: UTF8TextConverter new