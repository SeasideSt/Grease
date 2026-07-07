testing
expectedFailures
	^ SystemVersion current major >= 14
		ifTrue: [
			"three digit color codes are fixed with Pharo 14"
			#() ]
		ifFalse: [
			#(testFromStringThreeDigit) ] 