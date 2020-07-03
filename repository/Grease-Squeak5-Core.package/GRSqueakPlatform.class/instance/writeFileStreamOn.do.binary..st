as yet unclassified
writeFileStreamOn: aString do: aBlock binary: aBoolean 
	| stream |
	stream := aBoolean
				ifTrue: [ (MultiByteFileStream fileNamed: aString) ascii; wantsLineEndConversion: true; yourself ]
				ifFalse: [ (FileStream fileNamed: aString) binary ].
	[ aBlock value: stream ]
		ensure: [ stream close ]