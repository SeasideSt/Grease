Extension { #name : 'MessageSend' }

{ #category : '*grease-gemstone-core' }
MessageSend >> argumentCount [

	^selector argumentCount - arguments size.
]

{ #category : '*grease-gemstone-core' }
MessageSend >> evaluateWithArguments: anArray [
	^ self valueWithArguments: anArray
]

{ #category : '*grease-gemstone-core' }
MessageSend >> value: anArg [

	^self valueWithArguments: (Array with: anArg).
]

{ #category : '*grease-gemstone-core' }
MessageSend >> value: arg1 value: arg2 [

	^self valueWithArguments: (Array with: arg1 with: arg2).
]

{ #category : '*grease-gemstone-core' }
MessageSend >> valueWithPossibleArgument: anArg [

     "Evaluate the block represented by the receiver.
     If the block requires one argument, use anArg, if it requires more than one,
     fill up the rest with nils."

	^self numArgs = 0
		ifTrue: [ self value ]
	    	ifFalse: [
			receiver
				perform: selector
				withArguments: ((self arguments, (Array with: anArg)) first: self numArgs) ]
]

{ #category : '*grease-gemstone-core' }
MessageSend >> valueWithPossibleArguments: anArray [

     "Evaluate the block represented by the receiver.
     If the block requires one argument, use anArg, if it requires more than one,
     fill up the rest with nils."

	| count |
	^(count := selector argumentCount) = 0
		ifTrue: [ self value ]
	    	ifFalse: [
			receiver
				perform: selector
				withArguments: ((self arguments, anArray) first: count) ]
]
