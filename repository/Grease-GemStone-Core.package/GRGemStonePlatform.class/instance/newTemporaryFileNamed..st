files
newTemporaryFileNamed: aName

	| fileName |
	fileName := GRPlatform current pathSeparator,'tmp', GRPlatform current pathSeparator, aName.
	(self fileExists: fileName) ifTrue: [ GRError new signal: 'A (temporary) file with name ', aName, ' already exists.' ].
	^ (GsFile openWriteOnServer: fileName) pathName
