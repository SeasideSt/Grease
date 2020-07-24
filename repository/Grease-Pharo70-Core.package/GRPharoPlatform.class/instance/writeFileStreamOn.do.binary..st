file library
writeFileStreamOn: aString do: aBlock binary: aBoolean
	^ aBoolean
		ifTrue: [ aString asFileReference binaryWriteStreamDo: aBlock ]
		ifFalse: [ aString asFileReference writeStreamEncoded: 'ascii' do: aBlock ]