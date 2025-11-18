Extension { #name : 'GRGemStonePlatform' }

{ #category : '*grease-gemstone330-core' }
GRGemStonePlatform >> gemstoneExceptionSelector [

	^ (ExceptionSet new) , Halt, AlmostOutOfStack, Breakpoint
]

{ #category : '*grease-gemstone330-core' }
GRGemStonePlatform >> generateHardBreak [
	"Generate a GemStone hard break"

	^Break signal: 'interrupted for Seaside debugging'
]

{ #category : '*grease-gemstone330-core' }
GRGemStonePlatform >> handlesAlmostOutOfStackException: anException [

	^AlmostOutOfStack handles: anException
]

{ #category : '*grease-gemstone330-core' }
GRGemStonePlatform >> handlesBreakpointException: anException [

	^Breakpoint handles: anException
]

{ #category : '*grease-gemstone330-core' }
GRGemStonePlatform >> handlesHaltException: anException [

	^Halt handles: anException
]
