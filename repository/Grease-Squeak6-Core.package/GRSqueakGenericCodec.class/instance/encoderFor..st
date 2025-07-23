conversion
encoderFor: aStream 
	^ GRSqueakConverterCodecStream 
		on: aStream
		converter: self converter