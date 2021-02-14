conversion
encoderFor: aStream 
	^ GRPharoConverterCodecStream 
		on: aStream
		converter: ZnCharacterEncoder utf8