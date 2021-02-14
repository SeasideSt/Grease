*grease-tests-squeak5-core
writeToFile: aStringOrByteArray withFileNameDo: aBlock
	| fileName directory |
	fileName :=  'GRSqueakPlatformTest'.
	directory :=  FileDirectory default.
	[ GRPlatform current
		write: aStringOrByteArray
		toFile: fileName
		inFolder: directory fullName.
	aBlock value: directory fullName,GRPlatform current pathSeparator,fileName
		] ensure: [
			directory deleteFileNamed: fileName ]