files
fileStreamOn: aString do: aBlock binary: aBoolean
	self 
		greaseDeprecatedApi: 'GRPlatform>>#fileStreamOn:do:binary:'
		details: 'Use readFileStreamOn:do:binary:'.
	^ self readFileStreamOn: aString do: aBlock binary: aBoolean