Class {
	#name : 'GRObjectTest',
	#superclass : 'TestCase',
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'tests' }
GRObjectTest >> testError [
	"Make sure #error: signals a subclass of GRError."
	self 
		should: [ GRObject new error: 'oh dear' ]
		raise: GRError.
	self 
		should: [ GRObject error: 'oh dear' ]
		raise: GRError
]

{ #category : 'tests' }
GRObjectTest >> testInitialize [
	"Make sure #initialize is called on #new and that calling 'super initialize' doesn't error."
	self assert: GRObjectStub new foo
]

{ #category : 'tests' }
GRObjectTest >> testRespondsTo [
	self assert: (GRObject new respondsTo: #greaseString).
	self deny: (GRObject new respondsTo: #makeMeASandwich)
]
