file library
asMethodReturningString: aByteArrayOrString named: aSymbol
	"Generates the source of a method named aSymbol that returns aByteArrayOrString as a String.

	This implementation answers a String formatted like so

	aSymbol
		^ aByteArrayOrString

	Subclasses need to override this method if the dialect needs changes to support Unicode string literals"
	^ String streamContents: [ :stream |
		stream
			nextPutAll: aSymbol;
			nextPut: Character cr.
		stream
			tab;
			nextPutAll: '^ '''.
		aByteArrayOrString greaseString do: [ :each |
			each = $' ifTrue: [ stream nextPut: $' ].
			stream nextPut: each ].
		stream nextPut: $' ]