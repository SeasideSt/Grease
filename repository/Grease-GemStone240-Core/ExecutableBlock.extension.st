Extension { #name : 'ExecutableBlock' }

{ #category : '*grease-gemStone240-core' }
ExecutableBlock >> argumentCount [

	^self numArgs.
]

{ #category : '*grease-gemStone240-core' }
ExecutableBlock >> ifCurtailed: aBlock [

	| wasCurtailed |
	wasCurtailed := true.
	[
		self value.
		wasCurtailed := false.
	] ensure: [
		wasCurtailed ifTrue: aBlock.
	].
]

{ #category : '*grease-gemStone240-core' }
ExecutableBlock >> tempVarRefs [
	self halt.
]

{ #category : '*grease-gemStone240-core' }
ExecutableBlock >> valueWithPossibleArguments: anArray [ 
     "Evaluate the block represented by the receiver with the arguments provided."
  | n args | 
  (n := self numArgs) == 0 ifTrue: [^self value].
  args := anArray copy
		size: n;
		yourself.
  ^ self valueWithArguments: args.
]
