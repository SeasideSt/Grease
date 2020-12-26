conversion
encoderFor: aStream 
	^ GRPharoConverterCodecStream 
		on: aStream
		converter: ZnUTF8Encoder new