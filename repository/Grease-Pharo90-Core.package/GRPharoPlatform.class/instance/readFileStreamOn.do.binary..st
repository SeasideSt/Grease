file library
readFileStreamOn: aString do: aBlock binary: aBoolean

	^ aBoolean
		ifTrue: [ aString asFileReference binaryReadStreamDo: aBlock ]
		ifFalse: [ aString asFileReference readStreamEncoded: 'ascii' do: aBlock ]