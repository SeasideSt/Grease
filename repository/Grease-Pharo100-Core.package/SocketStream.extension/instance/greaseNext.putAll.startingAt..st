*Grease-Pharo100-Core
greaseNext: anInteger putAll: aCollection startingAt: startIndex
	"Put a String or a ByteArray onto the stream starting at the given position.
	Currently a large collection will allocate a large buffer."

	| toPut |
	anInteger = 0 ifTrue: [
		^ aCollection ].
	toPut := binary ifTrue: [ aCollection asByteArray ] ifFalse: [ aCollection asString ].
	self adjustOutBuffer: anInteger.
	outBuffer replaceFrom: outNextToWrite to: outNextToWrite + anInteger - 1 with: toPut startingAt: startIndex.
	outNextToWrite := outNextToWrite + anInteger.
	self checkFlush