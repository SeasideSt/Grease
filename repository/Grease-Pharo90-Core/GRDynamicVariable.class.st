Class {
	#name : 'GRDynamicVariable',
	#superclass : 'DynamicVariable',
	#category : 'Grease-Pharo90-Core',
	#package : 'Grease-Pharo90-Core'
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
