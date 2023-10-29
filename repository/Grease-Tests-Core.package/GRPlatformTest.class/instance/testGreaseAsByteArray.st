tests-encoding
testGreaseAsByteArray
	self assert: 1024 greaseAsByteArray equals: #[4 0].
	self assert: #[1 2 3] greaseAsByteArray equals: #[1 2 3].
	self assert: '123' greaseAsByteArray equals: #[49 50 51]