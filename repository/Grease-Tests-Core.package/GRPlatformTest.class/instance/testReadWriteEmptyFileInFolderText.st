tests-filestreams
testReadWriteEmptyFileInFolderText
	| text |
	text := String new.
	self 
		writeToFile: text 
		withFileNameDo:[ :fileName |
			self assert: (text = (GRPlatform current contentsOfFile: fileName binary: false)) ] 