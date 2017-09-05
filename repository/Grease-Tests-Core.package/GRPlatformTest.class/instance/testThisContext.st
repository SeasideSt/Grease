tests-processes
testThisContext
	| methodContext |
	methodContext := self platform thisContext.
	[ 
		| blockContext |
		blockContext := self platform thisContext.
		self assert: blockContext sender == methodContext
	] value