Class {
	#name : 'GRDynamicVariable',
	#superclass : 'DynamicVariable',
	#category : 'Grease-Squeak6-Core',
	#package : 'Grease-Squeak6-Core'
}

{ #category : 'accessing' }
GRDynamicVariable class >> default [
	^ self defaultValue
]

{ #category : 'accessing' }
GRDynamicVariable class >> defaultValue [
	^ nil
]

{ #category : 'accessing' }
GRDynamicVariable class >> use: anObject during: aBlock [
	^ self
		value: anObject
		during: aBlock
]
