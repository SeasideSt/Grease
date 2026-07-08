testing
testFromStringThreeDigit
	"These are all white on Pharo < 14"
	self assert: (Color fromString: 'f00') = Color red.
	self assert: (Color fromString: 'F00') = Color red.
	self assert: (Color fromString: '#f00') = Color red.
	self assert: (Color fromString: '#F00') = Color red