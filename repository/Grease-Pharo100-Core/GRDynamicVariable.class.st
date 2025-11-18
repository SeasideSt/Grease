Class {
	#name : 'GRDynamicVariable',
	#superclass : 'DynamicVariable',
	#category : 'Grease-Pharo100-Core',
	#package : 'Grease-Pharo100-Core'
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
