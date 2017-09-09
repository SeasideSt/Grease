tests
testDefaultValue
	self assert: GRTestNotificationBasedDynamicVariable value = 'default test value'.
	
	GRTestNotificationBasedDynamicVariable
		use: 'my value'
		during: [  ].
	self assert: GRTestNotificationBasedDynamicVariable value = 'default test value' description:'The default value is no longer correct'