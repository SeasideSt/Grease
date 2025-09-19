tests
testDescription
	self assert: package description isNil.
	package description: 'A hopeless package'.
	self assert: package description = 'A hopeless package'