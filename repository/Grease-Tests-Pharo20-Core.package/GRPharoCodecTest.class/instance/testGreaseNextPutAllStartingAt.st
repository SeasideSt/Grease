tests
testGreaseNextPutAllStartingAt
	| umlaut encodedUmlaut |
	umlaut := String with: (Character value: 228).
	encodedUmlaut := String with: (Character value: 195) with: (Character value: 164).
	self assert: 'ab' next: 1 startingAt: 1 gives:  'a'.
	self assert: 'a', umlaut, 'b' next: 1 startingAt: 1 gives:  'a'.
	self assert: 'a', umlaut, 'b' next: 2 startingAt: 1gives:  'a', encodedUmlaut.
	self assert: 'a', umlaut, 'b' next: 1 startingAt: 2 gives:  encodedUmlaut.
	self assert: 'a', umlaut, 'b' next: 2 startingAt: 2 gives:  encodedUmlaut, 'b'.
	self assert: 'a', umlaut, umlaut next: 2 startingAt: 2 gives:  encodedUmlaut, encodedUmlaut.
	self assert: 'ab', umlaut, 'b', umlaut next: 3 startingAt: 2 gives:  'b', encodedUmlaut, 'b'