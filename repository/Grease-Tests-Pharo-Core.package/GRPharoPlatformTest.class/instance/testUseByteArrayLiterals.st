tests
testUseByteArrayLiterals
	| useByteArrayLiterals |
	useByteArrayLiterals := GRPlatform current useByteArrayLiterals.
	self assert: (useByteArrayLiterals or: [ useByteArrayLiterals not ])