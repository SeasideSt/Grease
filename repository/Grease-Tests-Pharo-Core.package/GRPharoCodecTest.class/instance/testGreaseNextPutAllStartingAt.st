tests
testGreaseNextPutAllStartingAt
	| umlaut encodedUmlaut |
	umlaut := String with: (Character codePoint: 228).
	encodedUmlaut := ByteArray with: (Character codePoint: 195) asInteger with: (Character codePoint: 164) asInteger.
	self assert: 'ab' next: 1 startingAt: 1 gives:  'a' asByteArray.
	self assert: 'a', umlaut, 'b' next: 1 startingAt: 1 gives:  'a' asByteArray.
	self assert: 'ab', umlaut next: 1 startingAt: 1 gives:  'a' asByteArray.
	self assert: 'a', umlaut, 'b' next: 2 startingAt: 1 gives: 'a' asByteArray, encodedUmlaut.
	self assert: 'a', umlaut, 'b' next: 1 startingAt: 2 gives: encodedUmlaut.
	self assert: 'a', umlaut, 'b' next: 2 startingAt: 2 gives: encodedUmlaut, 'b' asByteArray.
	self assert: 'a', umlaut, umlaut next: 2 startingAt: 2 gives: encodedUmlaut, encodedUmlaut.
	self assert: 'ab', umlaut, 'b', umlaut next: 3 startingAt: 2 gives: 'b' asByteArray, encodedUmlaut, 'b' asByteArray