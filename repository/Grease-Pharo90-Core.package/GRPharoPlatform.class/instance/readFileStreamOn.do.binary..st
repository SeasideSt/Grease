file library
readFileStreamOn: aString do: aBlock binary: aBoolean
	"Line end conversion is no longer done for ascii... TBD!"

	^ aBoolean
		ifTrue: [ aString asFileReference binaryReadStreamDo: aBlock ]
		ifFalse: [ aString asFileReference readStreamEncoded: 'ascii' do: aBlock ]