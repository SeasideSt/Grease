convenience
decoderFor: aStream 
	^ GRPharoDeprecatedUtf8CodecStream 
		on: aStream
		converter: UTF8TextConverter new