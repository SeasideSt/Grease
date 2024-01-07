accessing-code
compile: aString in: aClass

	GRPlatform current
		compile: aString
		into: aClass
		classified: #accessing