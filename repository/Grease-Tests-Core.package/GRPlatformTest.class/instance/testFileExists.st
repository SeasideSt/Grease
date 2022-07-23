tests-files
testFileExists
	| theFileName |
	self 
		writeToFile: 'test' 
		withFileNameDo:[ :fileName |
			self assert: (GRPlatform current fileExists: fileName).
			theFileName := fileName ].
	self deny: (GRPlatform current fileExists: theFileName)