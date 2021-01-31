tests
testCodecUtf8
	#('UTF-8' 'utf-8') do: [ :codecName |
		| codec |
		codec := GRCodec forEncoding: codecName.
		self assert: codec name asLowercase = codecName asLowercase.
		self assert: codec url name asLowercase = codecName asLowercase.
		self assert: (codec encode: self decodedString) = (self utf8StringOrByteArrayForCodec: codec).
		self assert: (codec url encode: self decodedString) = (self utf8StringOrByteArrayForCodec: codec).
		self assert: (codec decode: (self utf8StringOrByteArrayForCodec: codec)) = self decodedString.
		self assert: (codec url decode: (self utf8StringOrByteArrayForCodec: codec)) = self decodedString ]