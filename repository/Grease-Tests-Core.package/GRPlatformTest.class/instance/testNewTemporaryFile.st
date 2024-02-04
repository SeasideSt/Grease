tests-files
testNewTemporaryFile

	| temporaryFile1 temporaryFile2 |
	[
		temporaryFile1 := GRPlatform current newTemporaryFile.
		temporaryFile2 := GRPlatform current newTemporaryFile.
		GRPlatform current
			writeFileStreamOn: temporaryFile1
			do: [ :str | str nextPutAll: 'test temporary' ]
			binary: false.
		GRPlatform current
			writeFileStreamOn: temporaryFile2
			do: [ :str | str nextPutAll: #[116 101 115 116 32 116 101 109 112 111 114 97 114 121] ]
			binary: true.
		self assert: (GRPlatform current fileExists: temporaryFile1).
		self deny: (GRPlatform current localNameOf: temporaryFile1) equals: (GRPlatform current localNameOf: temporaryFile2)
	] ensure: [ GRPlatform current deleteFile: temporaryFile1. GRPlatform current deleteFile: temporaryFile2  ].
	self deny: (GRPlatform current fileExists: temporaryFile1).
	self deny: (GRPlatform current fileExists: temporaryFile2)