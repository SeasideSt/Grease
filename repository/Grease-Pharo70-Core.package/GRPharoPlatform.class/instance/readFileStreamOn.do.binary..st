file library
readFileStreamOn: aString do: aBlock binary: aBoolean
	"Line end conversion is no longer done for ascii... TBD!"

	^ aBoolean
		ifTrue: [ aString asFileReference binaryReadStreamDo: aBlock ]
		ifFalse: [ aString asFileReference readStreamEncoded: 'utf-8' do: aBlock ]