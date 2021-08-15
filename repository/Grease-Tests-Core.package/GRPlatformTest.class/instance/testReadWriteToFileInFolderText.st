tests-filestreams
testReadWriteToFileInFolderText
	#('Ph''nglui mglw''nafh Cthulhu R''lyeh wgah''nagl fhtagn' 'Übèrstrîñgé') do:[ :text | 
		self 
			writeToFile: text 
			withFileNameDo:[ :fileName |
				self assert: text equals: (GRPlatform current contentsOfFile: fileName binary: false) ] ].