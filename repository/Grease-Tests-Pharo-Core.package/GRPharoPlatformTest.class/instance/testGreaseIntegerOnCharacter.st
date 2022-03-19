tests
testGreaseIntegerOnCharacter
	| character |
	character := Character codePoint: 19982.
	self assert: character greaseInteger = 19982.
	character := Unicode value: 19982.
	self assert: character greaseInteger = 19982