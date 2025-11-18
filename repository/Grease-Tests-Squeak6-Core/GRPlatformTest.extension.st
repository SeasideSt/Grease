Extension { #name : 'GRPlatformTest' }

{ #category : '*grease-tests-squeak6-core' }
GRPlatformTest >> testScaledDecimalGreaseString [
	self assert: 123.4s1 greaseString = '123.4'.
	self assert: 123.4s2 greaseString = '123.40'.
	self assert: 123s0 greaseString = '123'
]

{ #category : '*grease-tests-squeak6-core' }
GRPlatformTest >> writeToFile: aStringOrByteArray withFileNameDo: aBlock [
	| fileName directory |
	fileName :=  'GRSqueakPlatformTest'.
	directory :=  FileDirectory default.
	[ GRPlatform current
		write: aStringOrByteArray
		toFile: fileName
		inFolder: directory fullName.
	aBlock value: directory fullName, GRPlatform current pathSeparator, fileName
		] ensure: [
			directory deleteFileNamed: fileName ]
]
