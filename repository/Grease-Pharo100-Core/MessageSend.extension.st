Extension { #name : 'MessageSend' }

{ #category : '*Grease-Pharo100-Core' }
MessageSend >> argumentCount [
	^ selector numArgs - self arguments size
]

{ #category : '*Grease-Pharo100-Core' }
MessageSend >> valueWithPossibleArguments: anArray [
	"Evaluate the block represented by the receiver.
     If the block requires one argument, use anArg, if it requires more than one,
     fill up the rest with nils."

	^ self valueWithEnoughArguments: anArray
]
