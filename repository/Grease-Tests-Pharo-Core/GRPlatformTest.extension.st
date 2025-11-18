Extension { #name : 'GRPlatformTest' }

{ #category : '*Grease-Tests-Pharo-Core' }
GRPlatformTest >> testScaledDecimalGreaseString [
	self assert: 123.4s1 greaseString = '123.4'.
	self assert: 123.4s2 greaseString = '123.40'.
	self assert: 123s0 greaseString = '123'
]

{ #category : '*Grease-Tests-Pharo-Core' }
GRPlatformTest >> writeToFile: aStringOrByteArray withFileNameDo: aBlock [
	| fileName directory |
	fileName :=  'GRPharoPlatformTest'.
	directory := FileSystem disk workingDirectory.
	[ GRPlatform current
		write: aStringOrByteArray
		toFile: fileName
		inFolder: directory fullName.
	aBlock value: directory fullName,GRPlatform current pathSeparator,fileName
		] ensure: [
			(directory / fileName) delete ]
]
