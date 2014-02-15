private
writeToFile: aStringOrByteArray
	| fileName directory |
	fileName :=  'GRPharoPlatformTest'.
	directory := FileSystem disk workingDirectory.
	[ GRPlatform current
		write: aStringOrByteArray
		toFile: fileName
		inFolder: directory fullName
		] ensure: [
			(directory / fileName) delete ]