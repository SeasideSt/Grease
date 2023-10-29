tests-encoding
testGreaseBytesCount
	self assert: 1024 greaseBytesCount equals: 2.
	self assert: (SmallInteger maxVal + 10) greaseBytesCount equals: 8.
	self assert: (SmallInteger minVal + 10) greaseBytesCount equals: 8