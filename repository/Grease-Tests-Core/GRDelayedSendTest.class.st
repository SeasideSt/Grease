Class {
	#name : 'GRDelayedSendTest',
	#superclass : 'TestCase',
	#category : 'Grease-Tests-Core',
	#package : 'Grease-Tests-Core'
}

{ #category : 'tests-accessing' }
GRDelayedSendTest >> testArgumentCount [
	" unary "
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #negated.
	self assert: send argumentCount = 0.
	send := GRDelayedSend 
		receiver: 1
		selector: #negated
		arguments: #().
	self assert: send argumentCount = 0.

	" binary "
	send := GRDelayedSend 
		receiver: 1
		selector: #+.
	self assert: send argumentCount = 1.
	send := GRDelayedSend 
		receiver: 1
		selector: #+
		argument: 2.
	self assert: send argumentCount = 0.

	" keyword "
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:.
	self assert: send argumentCount = 2.
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		argument: 2.
	self assert: send argumentCount = 1.
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		arguments: (Array 
				with: 2
				with: 3).
	self assert: send argumentCount = 0
]

{ #category : 'tests-evaluating' }
GRDelayedSendTest >> testValueBinary [
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #+.
	self 
		should: [ send value ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #+
		argument: 2.
	self assert: send value = 3
]

{ #category : 'tests-evaluating' }
GRDelayedSendTest >> testValueKeyword [
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:.
	self 
		should: [ send value ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		argument: 2.
	self 
		should: [ send value ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		arguments: (Array 
				with: 2
				with: 3).
	self deny: send value
]

{ #category : 'tests-evaluating' }
GRDelayedSendTest >> testValueUnary [
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #negated.
	self assert: send value = -1.
	send := GRDelayedSend 
		receiver: 1
		selector: #negated
		arguments: #().
	self assert: send value = -1
]

{ #category : 'tests-evaluating' }
GRDelayedSendTest >> testValueValueBinary [
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #+.
	self 
		should: 
			[ send 
				value: 2
				value: 3 ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #+
		argument: 2.
	self 
		should: 
			[ send 
				value: 2
				value: 3 ]
		raise: GRInvalidArgumentCount
]

{ #category : 'tests-evaluating' }
GRDelayedSendTest >> testValueValueKeyword [
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:.
	self deny: (send 
			value: 2
			value: 3).
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		argument: 2.
	self 
		should: 
			[ send 
				value: 4
				value: 5 ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		arguments: (Array 
				with: 2
				with: 3).
	self 
		should: 
			[ send 
				value: 4
				value: 5 ]
		raise: GRInvalidArgumentCount
]

{ #category : 'tests-evaluating' }
GRDelayedSendTest >> testValueValueUnary [
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #negated.
	self 
		should: 
			[ send 
				value: 2
				value: 3 ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #negated
		arguments: #().
	self 
		should: 
			[ send 
				value: 2
				value: 3 ]
		raise: GRInvalidArgumentCount
]

{ #category : 'tests-evaluating' }
GRDelayedSendTest >> testValueWithArgumentBinary [
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #+.
	self assert: (send value: 2) = 3.
	send := GRDelayedSend 
		receiver: 1
		selector: #+
		argument: 2.
	self 
		should: [ send value: 2 ]
		raise: GRInvalidArgumentCount
]

{ #category : 'tests-evaluating' }
GRDelayedSendTest >> testValueWithArgumentKeyword [
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:.
	self 
		should: [ send value: 2 ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		argument: 2.
	self deny: (send value: 3).
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		arguments: #(2 3 ).
	self 
		should: [ send value: 4 ]
		raise: GRInvalidArgumentCount
]

{ #category : 'tests-evaluating' }
GRDelayedSendTest >> testValueWithArgumentUnary [
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #negated.
	self 
		should: [ send value: 2 ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #negated
		arguments: #().
	self 
		should: [ send value: 2 ]
		raise: GRInvalidArgumentCount
]

{ #category : 'tests-evaluating' }
GRDelayedSendTest >> testValueWithArgumentsBinary [
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #+.
	self 
		should: [ send valueWithArguments: #(2 3 ) ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #+
		argument: 2.
	self 
		should: [ send valueWithArguments: #(3 4 ) ]
		raise: GRInvalidArgumentCount
]

{ #category : 'tests-evaluating' }
GRDelayedSendTest >> testValueWithArgumentsKeyword [
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:.
	self deny: (send valueWithArguments: #(2 3 )).
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		argument: 2.
	self 
		should: [ send valueWithArguments: #(3 4 ) ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		arguments: #(2 3 ).
	self 
		should: [ send valueWithArguments: #(4 5 ) ]
		raise: GRInvalidArgumentCount
]

{ #category : 'tests-evaluating' }
GRDelayedSendTest >> testValueWithArgumentsUnary [
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #negated.
	self 
		should: [ send valueWithArguments: #(2 3 ) ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #negated
		arguments: #().
	self 
		should: [ send valueWithArguments: #(2 3 ) ]
		raise: GRInvalidArgumentCount
]

{ #category : 'tests-evaluating' }
GRDelayedSendTest >> testValueWithPossibleArgumentsBinary [
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #+.
	self 
		should: [ send valueWithPossibleArguments: #() ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #+
		argument: 2.
	self assert: (send valueWithPossibleArguments: #()) = 3.
	send := GRDelayedSend 
		receiver: 1
		selector: #+.
	self assert: (send valueWithPossibleArguments: #(2 )) = 3.
	send := GRDelayedSend 
		receiver: 1
		selector: #+
		argument: 2.
	self assert: (send valueWithPossibleArguments: #(3 )) = 3.
	send := GRDelayedSend 
		receiver: 1
		selector: #+.
	self assert: (send valueWithPossibleArguments: #(2 3 )) = 3.
	send := GRDelayedSend 
		receiver: 1
		selector: #+
		argument: 2.
	self assert: (send valueWithPossibleArguments: #(3 4 )) = 3
]

{ #category : 'tests-evaluating' }
GRDelayedSendTest >> testValueWithPossibleArgumentsKeyword [
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:.
	self 
		should: [ send valueWithPossibleArguments: #() ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		argument: 2.
	self 
		should: [ send valueWithPossibleArguments: #() ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		arguments: (Array 
				with: 2
				with: 3).
	self deny: (send valueWithPossibleArguments: #()).
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:.
	self 
		should: [ send valueWithPossibleArguments: #(2 ) ]
		raise: GRInvalidArgumentCount.
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		argument: 2.
	self deny: (send valueWithPossibleArguments: #(3 )).
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		arguments: (Array 
				with: 2
				with: 3).
	self deny: (send valueWithPossibleArguments: #(4 )).
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:.
	self deny: (send valueWithPossibleArguments: #(2 3 )).
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		argument: 2.
	self deny: (send valueWithPossibleArguments: #(3 4 )).
	send := GRDelayedSend 
		receiver: 1
		selector: #between:and:
		arguments: (Array 
				with: 2
				with: 3).
	self deny: (send valueWithPossibleArguments: #(4 5 ))
]

{ #category : 'tests-evaluating' }
GRDelayedSendTest >> testValueWithPossibleArgumentsUnary [
	| send |
	send := GRDelayedSend 
		receiver: 1
		selector: #negated.
	self assert: (send valueWithPossibleArguments: #()) = -1.
	send := GRDelayedSend 
		receiver: 1
		selector: #negated
		arguments: #().
	self assert: (send valueWithPossibleArguments: #()) = -1.
	send := GRDelayedSend 
		receiver: 1
		selector: #negated.
	self assert: (send valueWithPossibleArguments: #(2 )) = -1.
	send := GRDelayedSend 
		receiver: 1
		selector: #negated
		arguments: #().
	self assert: (send valueWithPossibleArguments: #(2 )) = -1.
	send := GRDelayedSend 
		receiver: 1
		selector: #negated.
	self assert: (send valueWithPossibleArguments: #(2 3 )) = -1.
	send := GRDelayedSend 
		receiver: 1
		selector: #negated
		arguments: #().
	self assert: (send valueWithPossibleArguments: #(2 3 )) = -1
]
