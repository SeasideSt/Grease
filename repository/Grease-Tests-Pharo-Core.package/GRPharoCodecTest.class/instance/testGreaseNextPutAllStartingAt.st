tests
testGreaseNextPutAllStartingAt
	| umlaut encodedUmlaut |
	umlaut := String with: (Character codePoint: 228).
	((GRCodec forEncoding: 'utf-8') encodedStringClass == ByteArray)
		ifTrue:[ 	encodedUmlaut := ByteArray with: 195 with: 164 ]
		ifFalse:[ encodedUmlaut := String with: (Character codePoint: 195) with: (Character codePoint: 164) ].
	self assert: 'ab' next: 1 startingAt: 1 gives:  'a'.
	self assert: 'a', umlaut, 'b' next: 1 startingAt: 1 gives: 'a'.
	self assert: 'ab', umlaut next: 1 startingAt: 1 gives: 'a'.
	self assert: 'a', umlaut, 'b' next: 2 startingAt: 1 gives: 'a', encodedUmlaut.
	self assert: 'a', umlaut, 'b' next: 1 startingAt: 2 gives: encodedUmlaut.
	self assert: 'a', umlaut, 'b' next: 2 startingAt: 2 gives: encodedUmlaut, 'b'.
	self assert: 'a', umlaut, umlaut next: 2 startingAt: 2 gives: encodedUmlaut, encodedUmlaut.
	self assert: 'ab', umlaut, 'b', umlaut next: 3 startingAt: 2 gives: 'b', encodedUmlaut, 'b'