running
setUp
	| codecStream |
	codecStream := ((GRCodec forEncoding: 'utf-8') encoderFor: (WriteStream on: (GRCodec forEncoding: 'utf-8') encodedStringClass new)).
	countingStream := GRCountingStream on: codecStream