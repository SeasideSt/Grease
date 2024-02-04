files
newTemporaryFileNamed: aName

	^ (GsFile openWriteOnServer: '/tmp/', aName) pathName
