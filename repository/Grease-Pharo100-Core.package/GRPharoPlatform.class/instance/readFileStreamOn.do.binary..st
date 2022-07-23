files
readFileStreamOn: aString do: aBlock binary: aBoolean

	^ aBoolean
		ifTrue: [ aString asFileReference binaryReadStreamDo: aBlock ]
		ifFalse: [ aString asFileReference readStreamEncoded: 'utf-8' do: aBlock ]