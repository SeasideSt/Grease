tests
testWithNestedValue
	GRNotificationBasedDynamicVariable 
		use: 'outer' 
		during: [
			GRNotificationBasedDynamicVariable 
				use: 'inner'
				during: [ self assert: GRNotificationBasedDynamicVariable value = 'inner' ].
			self assert: GRNotificationBasedDynamicVariable value = 'outer' ]