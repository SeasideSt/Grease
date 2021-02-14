conversion
decoderFor: aStream 
	^ GRPharoConverterCodecStream 
		on: aStream
		converter: ZnCharacterEncoder utf8