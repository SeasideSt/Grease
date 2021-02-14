*grease-tests-gemstone32-core
testMultiByteTruncate
	self assert: ((self multiByteConvert: 'abc') truncate) = (self multiByteConvert: 'abc').
	self assert: ((self multiByteConvert: 'abc') truncate: 3) = (self multiByteConvert: 'abc').
	self assert: ((self multiByteConvert: 'abc') truncate: 2) = 'ab...'.
	
	self assert: ((self multiByteConvert: 'abc') truncate: 1 ellipsis: '') = 'a'.
	self assert: ((self multiByteConvert: 'abc') truncate: 0 ellipsis: 'none') = 'none'