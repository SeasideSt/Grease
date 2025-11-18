Class {
	#name : 'GRNotificationBasedDynamicVariableTest',
	#superclass : 'TestCase',
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'tests' }
GRNotificationBasedDynamicVariableTest >> testAnswer [
	self assert: (GRNotificationBasedDynamicVariable use: 'value' during: [ true ])
]

{ #category : 'tests' }
GRNotificationBasedDynamicVariableTest >> testDefaultValue [
	self assert: GRTestNotificationBasedDynamicVariable value = 'default test value'.
	
	GRTestNotificationBasedDynamicVariable
		use: 'my value'
		during: [  ].
	self assert: GRTestNotificationBasedDynamicVariable value = 'default test value' description:'The default value is no longer correct'
]

{ #category : 'tests' }
GRNotificationBasedDynamicVariableTest >> testWithNestedValue [
	GRNotificationBasedDynamicVariable 
		use: 'outer' 
		during: [
			GRNotificationBasedDynamicVariable 
				use: 'inner'
				during: [ self assert: GRNotificationBasedDynamicVariable value = 'inner' ].
			self assert: GRNotificationBasedDynamicVariable value = 'outer' ]
]

{ #category : 'tests' }
GRNotificationBasedDynamicVariableTest >> testWithValue [
	GRNotificationBasedDynamicVariable 
		use: 'value' 
		during: [ self assert: GRNotificationBasedDynamicVariable value = 'value' ]
]

{ #category : 'tests' }
GRNotificationBasedDynamicVariableTest >> testWithoutValue [
	self assert: GRNotificationBasedDynamicVariable value isNil
]
