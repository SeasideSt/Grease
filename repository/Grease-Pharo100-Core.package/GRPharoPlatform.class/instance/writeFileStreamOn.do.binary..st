files
writeFileStreamOn: aString do: aBlock binary: aBoolean
	^ aBoolean
		ifTrue: [ aString asFileReference binaryWriteStreamDo: aBlock ]
		ifFalse: [ aString asFileReference writeStreamEncoded: 'utf-8' do: [ :str | aBlock value: (ZnNewLineWriterStream on: str) ] ]