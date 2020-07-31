tests-filestreams
testReadWriteEmptyFileInFolderBinary
	| bytes |
	bytes := ByteArray new.
	self 
		writeToFile: bytes 
		withFileNameDo:[ :fileName |
			self assert: (bytes = (GRPlatform current contentsOfFile: fileName binary: true)) ] 