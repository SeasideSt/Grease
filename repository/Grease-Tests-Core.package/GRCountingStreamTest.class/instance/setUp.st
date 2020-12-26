running
setUp
	| codecStream |
	codecStream := ((GRCodec forEncoding: 'utf-8') encoderFor: (WriteStream on: ByteArray new)).
	countingStream := GRCountingStream on: codecStream