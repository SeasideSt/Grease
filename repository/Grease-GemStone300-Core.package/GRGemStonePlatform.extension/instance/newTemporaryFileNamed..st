*grease-gemstone300-core
newTemporaryFileNamed: aName

	^ (GsFile openWriteOnServer: '/tmp/', aName) pathName
