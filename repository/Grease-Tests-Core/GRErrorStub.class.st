Class {
	#name : 'GRErrorStub',
	#superclass : 'GRError',
	#instVars : [
		'foo'
	],
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'accessing' }
GRErrorStub >> foo [
	^ foo
]

{ #category : 'initialization' }
GRErrorStub >> initialize [
	super initialize.
	foo := true
]
