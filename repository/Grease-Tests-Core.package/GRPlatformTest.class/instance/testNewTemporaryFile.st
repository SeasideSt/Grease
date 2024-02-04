tests-files
testNewTemporaryFile

	| temporaryFile |
	[
		temporaryFile := GRPlatform current newTemporaryFile.
		GRPlatform current
			writeFileStreamOn: temporaryFile
			do: [ :str | str nextPutAll: 'test temporary' ]
			binary: false.
		self assert: (GRPlatform current fileExists: temporaryFile)
	] ensure: [ GRPlatform current deleteFile: temporaryFile ].
	self deny: (GRPlatform current fileExists: temporaryFile)