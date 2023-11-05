tests-encoding
testGreaseByteAt
	self assert: (1024 greaseByteAt: 1) equals: 0.
	self assert: (1024 greaseByteAt: 2) equals: 4.
	self assert: ((SmallInteger maxVal + 10) greaseByteAt: 1) equals: 9.
	self assert: ((SmallInteger maxVal + 10) greaseByteAt: 8) equals: 16.
	self assert: ((SmallInteger minVal - 10) greaseByteAt: 1) equals: 10.
	self assert: ((SmallInteger minVal - 10) greaseByteAt: 8) equals: 16