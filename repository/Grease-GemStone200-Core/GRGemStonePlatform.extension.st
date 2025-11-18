Extension { #name : 'GRGemStonePlatform' }

{ #category : '*grease-gemstone200-core' }
GRGemStonePlatform >> gemstoneExceptionSelector [

	^ (ExceptionSet new) , Halt, BreakpointNotification
]

{ #category : '*grease-gemstone200-core' }
GRGemStonePlatform >> generateHardBreak [
	"Generate a GemStone hard break"

	| errorNumber allArgs |
	allArgs := { 'interrupted for Seaside debugging' } .
	errorNumber := self _errorSymbolToNumber: #rtErrHardBreak args: allArgs .
	^System signal: errorNumber args: allArgs signalDictionary: GemStoneError
]

{ #category : '*grease-gemstone200-core' }
GRGemStonePlatform >> handlesAlmostOutOfStackException: anException [

	^false
]

{ #category : '*grease-gemstone200-core' }
GRGemStonePlatform >> handlesBreakpointException: anException [

	^BreakpointNotification handles: anException
]

{ #category : '*grease-gemstone200-core' }
GRGemStonePlatform >> handlesHaltException: anException [

	^Halt handles: anException
]
