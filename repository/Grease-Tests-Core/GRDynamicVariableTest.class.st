Class {
	#name : 'GRDynamicVariableTest',
	#superclass : 'TestCase',
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'tests' }
GRDynamicVariableTest >> testAnswer [
	self assert: (GRDynamicVariable use: 'value' during: [ true ])
]

{ #category : 'tests' }
GRDynamicVariableTest >> testDefaultValue [
	self assert: GRTestDynamicVariable value = 'default test value'.
	
	GRTestDynamicVariable
		use: 'my value'
		during: [  ].
	self assert: GRTestDynamicVariable value = 'default test value' description:'The default value is no longer correct'
]

{ #category : 'tests' }
GRDynamicVariableTest >> testWithNestedValue [
	GRDynamicVariable 
		use: 'outer' 
		during: [
			GRDynamicVariable 
				use: 'inner'
				during: [ self assert: GRDynamicVariable value = 'inner' ].
			self assert: GRDynamicVariable value = 'outer' ]
]

{ #category : 'tests' }
GRDynamicVariableTest >> testWithValue [
	GRDynamicVariable 
		use: 'value' 
		during: [ self assert: GRDynamicVariable value = 'value' ]
]

{ #category : 'tests' }
GRDynamicVariableTest >> testWithoutValue [
	self assert: GRDynamicVariable value isNil
]
