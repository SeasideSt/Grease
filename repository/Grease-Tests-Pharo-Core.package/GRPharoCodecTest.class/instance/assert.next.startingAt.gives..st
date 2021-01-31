private
assert: aString next: anInteger startingAt: startIndex gives: anEncodedString
	| actual encoder |
	encoder := GRCodec forEncoding: 'utf-8'.
	actual := encoder encodedStringClass streamContents: [ :stream |
		((GRCodec forEncoding: 'utf-8') encoderFor: stream)
			greaseNext: anInteger putAll: aString startingAt: startIndex ].
	encoder encodedStringClass == ByteArray
		ifTrue:[ self assert: actual = anEncodedString asByteArray ]
		ifFalse:[ self assert: actual = anEncodedString ]