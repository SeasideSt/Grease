tests
testCodecUtf8Bom
	#('UTF-8' 'utf-8') do: [ :codecName |
		| codec bom |
		codec := GRCodec forEncoding: codecName.
		(codec encodedStringClass == ByteArray)
			ifTrue:[ bom := self asByteArray: #(239 187 191) ]
			ifFalse:[bom := self asString: #(239 187 191) ].
		self assert: (codec decode: bom , (self utf8StringOrByteArrayForCodec: codec)) = self decodedString.
		self assert: (codec url decode: bom , (self utf8StringOrByteArrayForCodec: codec)) = self decodedString ]