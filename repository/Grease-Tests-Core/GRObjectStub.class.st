Class {
	#name : 'GRObjectStub',
	#superclass : 'GRObject',
	#instVars : [
		'foo'
	],
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'accessing' }
GRObjectStub >> foo [
	^ foo
]

{ #category : 'initialization' }
GRObjectStub >> initialize [
	super initialize.
	foo := true
]
