"
A GRDynamicVariable is a variable that is visible only in the stackframes outgoing from this one.

Example:

GRDynamicVariable
	use: 'Seaside'
	during: [ self compilcatedCalculation ]
	
Whenever GRDynamicVariable value gets evaluated somewhere inside [ self compilcatedCalculation ] or a method invoked directly or indirectly by it, its value will be 'Seaside'. If no #use:during: handler is around the current stack frame, then the value will be the return value of the class side #defaultValue.

Do not use GRDynamicVariable directly, instead create a subclass for each variable you want to use.
"
Class {
	#name : 'GRDynamicVariable',
	#superclass : 'DynamicVariable',
	#category : 'Grease-Pharo60-Core',
	#package : 'Grease-Pharo60-Core'
}

{ #category : 'defaults' }
GRDynamicVariable class >> defaultValue [
	^ nil
]

{ #category : 'accessing' }
GRDynamicVariable class >> use: anObject during: aBlock [
	^ self
		value: anObject
		during: aBlock
]

{ #category : 'accessing' }
GRDynamicVariable >> default [
	^ self class defaultValue
]
