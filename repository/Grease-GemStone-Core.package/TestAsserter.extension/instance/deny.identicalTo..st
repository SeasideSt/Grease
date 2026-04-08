*grease-gemstone-core
deny: anObject identicalTo: anotherObject
	self
		deny: anObject == anotherObject
		description: anObject printString, ' is *not* identical to ', anotherObject printString.