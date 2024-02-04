files
newTemporaryFileNamed: aName

	| fileName |
	fileName := '/tmp/', aName.
	(self fileExists: fileName) ifTrue: [ GRError new signal: 'A (temporary) file with name ', aName, ' already exists.' ].
	^ (GsFile openWriteOnServer: fileName) pathName
