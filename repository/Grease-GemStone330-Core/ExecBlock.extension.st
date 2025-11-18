Extension { #name : 'ExecBlock' }

{ #category : '*grease-gemstone330-core' }
ExecBlock >> argumentCount [

	^self numArgs.
]

{ #category : '*grease-gemstone330-core' }
ExecBlock >> ifCurtailed: aBlock [

	| wasCurtailed |
	wasCurtailed := true.
	[
		self value.
		wasCurtailed := false.
	] ensure: [
		wasCurtailed ifTrue: aBlock.
	].
]

{ #category : '*grease-gemstone330-core' }
ExecBlock >> valueWithPossibleArguments: anArray [ 
     "Evaluate the block represented by the receiver with the arguments provided."
  | n args | 
  (n := self numArgs) == 0 ifTrue: [^self value].
  args := anArray copy
		size: n;
		yourself.
  ^ self valueWithArguments: args.
]
