"
An implementation of a dynamic varaible based on notifications. 

Dialects that do not support dynamic variables or thread/process local variables can create an empty subclass of this class called GRDynamicVariable.
"
Class {
	#name : 'GRNotificationBasedDynamicVariable',
	#superclass : 'GRNotification',
	#category : 'Grease-Core-Utilities',
	#package : 'Grease-Core',
	#tag : 'Utilities'
}

{ #category : 'defaults' }
GRNotificationBasedDynamicVariable class >> defaultValue [
	^ nil
]

{ #category : 'evaluating' }
GRNotificationBasedDynamicVariable class >> use: anObject during: aBlock [
	"Set the dynamic value of the receiver to anObject during the evaluation of aBlock."

	^ aBlock on: self do: [ :notification | notification resume: anObject ]
]

{ #category : 'evaluating' }
GRNotificationBasedDynamicVariable class >> value [
	"Answer the dynamic value of the receiver."

	^ self signal
]

{ #category : 'defaults' }
GRNotificationBasedDynamicVariable >> defaultAction [
	^ self class defaultValue
]
