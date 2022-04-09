conversion
encoderFor: aStream 
	^ GRPharoZnCodecStream 
		on: aStream
		withEncoder: (ZnCharacterEncoder newForEncoding: self name)