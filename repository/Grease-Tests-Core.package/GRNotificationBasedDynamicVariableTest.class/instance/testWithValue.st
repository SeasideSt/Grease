tests
testWithValue
	GRNotificationBasedDynamicVariable 
		use: 'value' 
		during: [ self assert: GRNotificationBasedDynamicVariable value = 'value' ]