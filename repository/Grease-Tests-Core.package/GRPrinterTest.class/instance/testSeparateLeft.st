tests-utilites
testSeparateLeft
	self assert: (self 
			separate: ''
			left: $*) = ''.
	self assert: (self 
			separate: '1'
			left: $*) = '1'.
	self assert: (self 
			separate: '12'
			left: $*) = '12'.
	self assert: (self 
			separate: '123'
			left: $*) = '123'.
	self assert: (self 
			separate: '1234'
			left: $*) = '123*4'.
	self assert: (self 
			separate: '12345'
			left: $*) = '123*45'.
	self assert: (self 
			separate: '123456'
			left: $*) = '123*456'.
	self assert: (self 
			separate: '1234567'
			left: $*) = '123*456*7'.
	self assert: (self 
			separate: '12345678'
			left: $*) = '123*456*78'.
	self assert: (self 
			separate: '123456789'
			left: $*) = '123*456*789'