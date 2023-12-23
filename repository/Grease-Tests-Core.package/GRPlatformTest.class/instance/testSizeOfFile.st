tests-files
testSizeOfFile
	| theFileName |
	self
		writeToFile: 'test me'
		withFileNameDo:[ :fileName |
			self assert: (GRPlatform current sizeOfFile: fileName) equals: 7.
			theFileName := fileName ].
	self deny: (GRPlatform current fileExists: theFileName)