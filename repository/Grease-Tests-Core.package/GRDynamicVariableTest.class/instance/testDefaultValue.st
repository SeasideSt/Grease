tests
testDefaultValue
	self assert: GRTestDynamicVariable value = 'default test value'.
	
	GRTestDynamicVariable
		use: 'my value'
		during: [  ].
	self assert: GRTestDynamicVariable value = 'default test value' description:'The default value is no longer correct'.	
	