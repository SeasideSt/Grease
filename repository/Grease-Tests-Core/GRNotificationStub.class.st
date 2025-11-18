Class {
	#name : 'GRNotificationStub',
	#superclass : 'GRNotification',
	#instVars : [
		'foo'
	],
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'accessing' }
GRNotificationStub >> defaultAction [
	^ #returnValue
]

{ #category : 'accessing' }
GRNotificationStub >> foo [
	^ foo
]

{ #category : 'initialization' }
GRNotificationStub >> initialize [
	super initialize.
	foo := true
]
