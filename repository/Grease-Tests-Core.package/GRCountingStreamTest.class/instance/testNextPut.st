testing
testNextPut
	countingStream nextPut: (Character value: 16rE4).
	self assert: countingStream size = 2.
	self assert: countingStream count = 1.
	self assert: countingStream contents = (String with:  (Character value: 16rC3) with:  (Character value: 16rA4))