files
writeFileStreamOn: aString do: aBlock binary: aBoolean 
	| stream |
	stream := aBoolean
				ifTrue: [ (FileStream fileNamed: aString) binary ]
				ifFalse: [ (MultiByteFileStream fileNamed: aString) ascii; wantsLineEndConversion: true; yourself ].
	[ aBlock value: stream ]
		ensure: [ stream close ]