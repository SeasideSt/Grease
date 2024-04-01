tests-files
testNewTemporaryFileNamed

	| temporaryFile fileName |
	fileName := 'GRPlatformTestTemporaryFile'.
	[
		temporaryFile := GRPlatform current newTemporaryFileNamed: fileName.
		GRPlatform current
			writeFileStreamOn: temporaryFile
			do: [ :str | str nextPutAll: 'test temporary' ]
			binary: false.
		self assert: (GRPlatform current fileExists: temporaryFile).
		self should: [ GRPlatform current newTemporaryFileNamed: fileName ] raise: GRError.
	] ensure: [ GRPlatform current deleteFile: temporaryFile ].
	self deny: (GRPlatform current fileExists: temporaryFile).
	