tests-encoding
testGreaseByteAt
	self assert: (1024 greaseByteAt: 1) equals: 0.
	self assert: (1024 greaseByteAt: 2) equals: 4