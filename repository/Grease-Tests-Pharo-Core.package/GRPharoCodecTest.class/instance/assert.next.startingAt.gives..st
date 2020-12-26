private
assert: aString next: anInteger startingAt: startIndex gives: anEncodedString
	| actual |
	actual := ByteArray streamContents: [ :stream |
		((GRCodec forEncoding: 'utf-8') encoderFor: stream)
			greaseNext: anInteger putAll: aString startingAt: startIndex ].
	self assert: actual = anEncodedString