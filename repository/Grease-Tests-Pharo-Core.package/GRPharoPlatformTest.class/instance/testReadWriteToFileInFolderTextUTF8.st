tests-filestreams
testReadWriteToFileInFolderTextUTF8
	#('Übèrstrîñgé' '£ęλ~') do:[ :text | 
		self 
			writeToFile: text 
			withFileNameDo:[ :fileName |
				self assert: text equals: (GRPlatform current contentsOfFile: fileName binary: false) ] ].